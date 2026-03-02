import type { ExecutionContext } from "@cloudflare/workers-types";
import { and, eq, isNotNull, lte } from "drizzle-orm";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

const log = logger.child({ module: "WalletTransferVerificationCron" });

/**
 * Verification result for a completed order
 */
interface VerificationResult {
	orderId: string;
	type: "RIDE" | "DELIVERY" | "FOOD";
	driverEarning: number;
	merchantEarning: number | null;
	issues: string[];
	fixed: boolean;
}

/**
 * Scheduled handler for verifying wallet transfers on completed orders
 *
 * This cron job runs every 5 minutes to verify that completed orders
 * have their corresponding wallet transfers (EARNING transactions) properly recorded.
 *
 * It checks:
 * 1. Driver EARNING transaction exists for completed orders with driverEarning > 0
 * 2. Merchant EARNING transaction exists for FOOD orders with merchantEarning > 0
 * 3. Transaction amounts match order's driverEarning/merchantEarning values
 *
 * If discrepancies are found, it attempts to fix them by:
 * - Creating missing EARNING transactions
 * - Crediting the correct wallet balance
 *
 * Called by Cloudflare Workers cron trigger (every 5 minutes)
 */
export async function handleWalletTransferVerificationCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	const startTime = Date.now();
	let ordersChecked = 0;
	let issuesFound = 0;
	let issuesFixed = 0;
	const verificationResults: VerificationResult[] = [];

	try {
		log.info(
			{},
			"[WalletTransferVerificationCron] Starting wallet transfer verification",
		);

		const svc = getServices();
		const repo = getRepositories(svc, getManagers());

		// Find completed orders from the last 24 hours that have earnings set
		// We check a broader time range to catch any missed transfers
		const twentyFourHoursAgo = new Date(Date.now() - 24 * 60 * 60 * 1000);

		const completedOrders = await svc.db.query.order.findMany({
			where: (f, { gte }) =>
				and(
					eq(f.status, "COMPLETED"),
					lte(f.updatedAt, new Date()), // Up to now
					gte(f.updatedAt, twentyFourHoursAgo), // From 24 hours ago
					isNotNull(f.driverEarning), // Has driver earning set
				),
			limit: 100, // Process in batches
			orderBy: (f, { asc }) => asc(f.updatedAt),
		});

		log.info(
			{ orderCount: completedOrders.length },
			"[WalletTransferVerificationCron] Found completed orders to verify",
		);

		for (const order of completedOrders) {
			ordersChecked++;
			const result: VerificationResult = {
				orderId: order.id,
				type: order.type as "RIDE" | "DELIVERY" | "FOOD",
				driverEarning: toNumberSafe(order.driverEarning ?? "0"),
				merchantEarning: order.merchantEarning
					? toNumberSafe(order.merchantEarning)
					: null,
				issues: [],
				fixed: false,
			};

			try {
				// Skip if no driver ID (shouldn't happen for completed orders)
				if (!order.completedDriverId && !order.driverId) {
					result.issues.push("No driver ID found on completed order");
					verificationResults.push(result);
					issuesFound++;
					continue;
				}

				const driverId = order.completedDriverId ?? order.driverId;

				// Get driver to find userId for wallet lookup
				const driver = await svc.db.query.driver.findFirst({
					where: (f, op) => op.eq(f.id, driverId ?? ""),
				});

				if (!driver?.userId) {
					result.issues.push(`Driver ${driverId} not found or missing userId`);
					verificationResults.push(result);
					issuesFound++;
					continue;
				}

				// Get driver's wallet
				let driverWallet: { id: string; balance: string } | undefined;
				try {
					const wallet = await repo.wallet.getByUserId(driver.userId);
					driverWallet = { id: wallet.id, balance: wallet.balance.toString() };
				} catch {
					result.issues.push(
						`Wallet not found for driver userId ${driver.userId}`,
					);
					verificationResults.push(result);
					issuesFound++;
					continue;
				}

				// Check for driver EARNING transaction
				const driverEarningAmount = toNumberSafe(order.driverEarning ?? "0");

				if (driverEarningAmount > 0) {
					const driverEarningTx = await svc.db.query.transaction.findFirst({
						where: (f) =>
							and(
								eq(f.referenceId, order.id),
								eq(f.walletId, driverWallet?.id ?? ""),
								eq(f.type, "EARNING"),
								eq(f.status, "SUCCESS"),
							),
					});

					if (!driverEarningTx) {
						result.issues.push(
							`Missing EARNING transaction for driver (expected: ${driverEarningAmount})`,
						);
						issuesFound++;

						// Attempt to fix: Create the missing transaction and credit wallet
						try {
							await svc.db.transaction(async (tx) => {
								// First, add balance to driver wallet
								const balanceResult = await svc.walletServices.balance.add(
									{
										walletId: driverWallet?.id ?? "",
										amount: driverEarningAmount,
									},
									{ tx },
								);

								// Then create the transaction record
								await repo.transaction.insert(
									{
										walletId: driverWallet?.id ?? "",
										type: "EARNING",
										amount: driverEarningAmount,
										balanceBefore: balanceResult.balanceBefore,
										balanceAfter: balanceResult.balanceAfter,
										status: "SUCCESS",
										description: `[RECOVERED] Driver earning for order #${order.id.slice(0, 8)}`,
										referenceId: order.id,
										metadata: {
											orderId: order.id,
											orderType: order.type,
											recoveredBy: "WalletTransferVerificationCron",
											recoveredAt: new Date().toISOString(),
										},
									},
									{ tx },
								);

								log.info(
									{
										orderId: order.id,
										walletId: driverWallet?.id,
										amount: driverEarningAmount,
									},
									"[WalletTransferVerificationCron] Fixed missing driver EARNING transaction",
								);
							});

							result.fixed = true;
							issuesFixed++;
						} catch (fixError) {
							log.error(
								{ error: fixError, orderId: order.id },
								"[WalletTransferVerificationCron] Failed to fix driver EARNING transaction",
							);
							result.issues.push(
								`Failed to fix: ${fixError instanceof Error ? fixError.message : "Unknown error"}`,
							);
						}
					} else {
						// Verify amount matches
						const txAmount = toNumberSafe(driverEarningTx.amount);
						if (Math.abs(txAmount - driverEarningAmount) > 0.01) {
							result.issues.push(
								`Driver EARNING amount mismatch: tx=${txAmount}, expected=${driverEarningAmount}`,
							);
							issuesFound++;
						}
					}
				}

				// For FOOD orders, verify merchant EARNING transaction
				if (
					order.type === "FOOD" &&
					order.merchantId &&
					order.merchantEarning
				) {
					const merchantEarningAmount = toNumberSafe(order.merchantEarning);

					if (merchantEarningAmount > 0) {
						// Get merchant to find userId for wallet lookup
						const merchant = await svc.db.query.merchant.findFirst({
							where: (f, op) => op.eq(f.id, order.merchantId ?? ""),
						});

						if (!merchant?.userId) {
							result.issues.push(
								`Merchant ${order.merchantId} not found or missing userId`,
							);
							issuesFound++;
						} else {
							// Get merchant's wallet
							let merchantWallet: { id: string } | undefined;
							try {
								merchantWallet = await repo.wallet.getByUserId(merchant.userId);
							} catch {
								result.issues.push(
									`Wallet not found for merchant userId ${merchant.userId}`,
								);
								issuesFound++;
							}

							if (merchantWallet) {
								const merchantEarningTx =
									await svc.db.query.transaction.findFirst({
										where: (f) =>
											and(
												eq(f.referenceId, order.id),
												eq(f.walletId, merchantWallet?.id ?? ""),
												eq(f.type, "EARNING"),
												eq(f.status, "SUCCESS"),
											),
									});

								if (!merchantEarningTx) {
									result.issues.push(
										`Missing EARNING transaction for merchant (expected: ${merchantEarningAmount})`,
									);
									issuesFound++;

									// Attempt to fix: Create the missing transaction and credit wallet
									try {
										await svc.db.transaction(async (tx) => {
											// First, add balance to merchant wallet
											const balanceResult =
												await svc.walletServices.balance.add(
													{
														walletId: merchantWallet?.id ?? "",
														amount: merchantEarningAmount,
													},
													{ tx },
												);

											// Then create the transaction record
											await repo.transaction.insert(
												{
													walletId: merchantWallet?.id ?? "",
													type: "EARNING",
													amount: merchantEarningAmount,
													balanceBefore: balanceResult.balanceBefore,
													balanceAfter: balanceResult.balanceAfter,
													status: "SUCCESS",
													description: `[RECOVERED] Merchant earning for order #${order.id.slice(0, 8)}`,
													referenceId: order.id,
													metadata: {
														orderId: order.id,
														orderType: order.type,
														recoveredBy: "WalletTransferVerificationCron",
														recoveredAt: new Date().toISOString(),
													},
												},
												{ tx },
											);

											log.info(
												{
													orderId: order.id,
													merchantId: order.merchantId,
													walletId: merchantWallet?.id,
													amount: merchantEarningAmount,
												},
												"[WalletTransferVerificationCron] Fixed missing merchant EARNING transaction",
											);
										});

										result.fixed = true;
										issuesFixed++;
									} catch (fixError) {
										log.error(
											{ error: fixError, orderId: order.id },
											"[WalletTransferVerificationCron] Failed to fix merchant EARNING transaction",
										);
										result.issues.push(
											`Failed to fix merchant: ${fixError instanceof Error ? fixError.message : "Unknown error"}`,
										);
									}
								} else {
									// Verify amount matches
									const txAmount = toNumberSafe(merchantEarningTx.amount);
									if (Math.abs(txAmount - merchantEarningAmount) > 0.01) {
										result.issues.push(
											`Merchant EARNING amount mismatch: tx=${txAmount}, expected=${merchantEarningAmount}`,
										);
										issuesFound++;
									}
								}
							}
						}
					}
				}

				if (result.issues.length > 0) {
					verificationResults.push(result);
				}
			} catch (error) {
				log.error(
					{ error, orderId: order.id },
					"[WalletTransferVerificationCron] Error verifying order",
				);
				result.issues.push(
					`Verification error: ${error instanceof Error ? error.message : "Unknown error"}`,
				);
				verificationResults.push(result);
				issuesFound++;
			}
		}

		const duration = Date.now() - startTime;

		log.info(
			{
				ordersChecked,
				issuesFound,
				issuesFixed,
				durationMs: duration,
			},
			"[WalletTransferVerificationCron] Completed wallet transfer verification",
		);

		// Log detailed results if any issues were found
		if (verificationResults.length > 0) {
			log.warn(
				{ results: verificationResults },
				"[WalletTransferVerificationCron] Verification issues detected",
			);
		}

		return new Response(
			JSON.stringify({
				success: true,
				ordersChecked,
				issuesFound,
				issuesFixed,
				durationMs: duration,
				results: verificationResults,
			}),
			{ status: 200, headers: { "Content-Type": "application/json" } },
		);
	} catch (error) {
		log.error(
			{ error },
			"[WalletTransferVerificationCron] Failed to verify wallet transfers",
		);
		return new Response("Wallet transfer verification failed", { status: 500 });
	}
}
