import { type PaymentEnvelope, PaymentEnvelopeSchema } from "@repo/schema/ws";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

export class PaymentRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
	}

	broadcast(message: PaymentEnvelope, opts?: BroadcastOptions): void {
		const parse = PaymentEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			logger.warn(parse, "Invalid payment WS message");
			return;
		}
		super.broadcast(parse.data, opts);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);

		const { success, data } = await PaymentEnvelopeSchema.safeParseAsync(
			JSON.parse(message.toString()),
		);

		if (!success) {
			logger.warn(data, "[PaymentRoom] Invalid payment WS message format");
			return;
		}

		// Handle client-to-server actions
		if (data.t === "s" && data.a !== undefined) {
			try {
				if (data.a === "CHECK_NEW_DATA") {
					await this.#handleCheckNewData(ws, data);
				}
			} catch (error) {
				logger.error(
					{ error, action: data.a },
					"[PaymentRoom] WebSocket message handler failed",
				);
			}
		}
	}

	/**
	 * Handle CHECK_NEW_DATA action - client asks if there's new data since lastKnownVersion
	 * This replaces HTTP polling with WebSocket-based data sync
	 *
	 * Client sends: { a: "CHECK_NEW_DATA", p: { syncRequest: { paymentId, lastKnownVersion } } }
	 * Server responds:
	 *   - NEW_DATA with full payment detail if data changed
	 *   - NO_DATA if no changes since lastKnownVersion
	 */
	async #handleCheckNewData(ws: WebSocket, data: PaymentEnvelope) {
		const syncRequest = data.p.syncRequest;
		if (!syncRequest) {
			logger.warn(
				data,
				"[PaymentRoom] Invalid CHECK_NEW_DATA payload - missing syncRequest",
			);
			return;
		}

		const { paymentId, lastKnownVersion } = syncRequest;

		try {
			// Fetch current payment state from database
			const payment = await this.#repo.payment.get(paymentId);

			// Use updatedAt as version indicator
			const currentVersion = payment.updatedAt.toISOString();

			// Compare versions - if lastKnownVersion is missing or different, send new data
			const hasNewData =
				!lastKnownVersion || lastKnownVersion !== currentVersion;

			if (hasNewData) {
				// Find associated transaction
				const transaction = await this.#svc.db.query.transaction.findFirst({
					where: (f, op) => op.eq(f.id, payment.transactionId),
				});

				// Find associated wallet if transaction exists
				const wallet = transaction
					? await this.#svc.db.query.wallet.findFirst({
							where: (f, op) => op.eq(f.id, transaction.walletId),
						})
					: null;

				// Convert transaction to schema-compatible format
				const transactionData = transaction
					? {
							id: transaction.id,
							walletId: transaction.walletId,
							type: transaction.type,
							amount: toNumberSafe(transaction.amount),
							status: transaction.status,
							balanceBefore: transaction.balanceBefore
								? toNumberSafe(transaction.balanceBefore)
								: undefined,
							balanceAfter: transaction.balanceAfter
								? toNumberSafe(transaction.balanceAfter)
								: undefined,
							description: transaction.description ?? undefined,
							createdAt: transaction.createdAt,
							updatedAt: transaction.updatedAt,
						}
					: undefined;

				// Convert wallet to schema-compatible format
				const walletData = wallet
					? {
							id: wallet.id,
							userId: wallet.userId,
							balance: toNumberSafe(wallet.balance),
							currency: wallet.currency,
							isActive: wallet.isActive,
							createdAt: wallet.createdAt,
							updatedAt: wallet.updatedAt,
						}
					: undefined;

				const newDataResponse: PaymentEnvelope = {
					e: "NEW_DATA",
					f: "s",
					t: "c",
					p: {
						payment,
						transaction: transactionData,
						wallet: walletData,
						syncRequest: {
							paymentId,
							lastKnownVersion: currentVersion,
						},
					},
				};

				logger.debug(
					{ paymentId, previousVersion: lastKnownVersion, currentVersion },
					"[PaymentRoom] Sending NEW_DATA response",
				);
				ws.send(JSON.stringify(newDataResponse));
			} else {
				// No changes since last known version
				const noDataResponse: PaymentEnvelope = {
					e: "NO_DATA",
					f: "s",
					t: "c",
					p: {
						syncRequest: {
							paymentId,
							lastKnownVersion: currentVersion,
						},
					},
				};

				logger.debug(
					{ paymentId, version: currentVersion },
					"[PaymentRoom] Sending NO_DATA response - no changes",
				);
				ws.send(JSON.stringify(noDataResponse));
			}
		} catch (error) {
			logger.error(
				{ error, paymentId },
				"[PaymentRoom] Failed to handle CHECK_NEW_DATA",
			);
			// Send NO_DATA on error to avoid blocking client
			const errorResponse: PaymentEnvelope = {
				e: "NO_DATA",
				f: "s",
				t: "c",
				p: {},
			};
			ws.send(JSON.stringify(errorResponse));
		}
	}
}
