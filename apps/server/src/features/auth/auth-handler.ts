import { m } from "@repo/i18n";
import type { User } from "@repo/schema";
import type { BankProvider } from "@repo/schema/common";
import { unflattenData } from "@repo/schema/flatten.helper";
import {
	composeAuthCookieValue,
	nullToUndefined,
	trimObjectValues,
} from "@repo/shared";
import { AuthError, BaseError, RepositoryError } from "@/core/error";
import { hasRoles, orpcAuthMiddleware } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DuplicateAccountService } from "@/features/fraud/services";
import { isDev } from "@/utils";
import { logger } from "@/utils/logger";
import { AuthSpec } from "./auth-spec";

const { pub, priv } = createORPCRouter(AuthSpec);

export const AuthHandler = pub.router({
	signIn: pub.signIn.handler(async ({ context, input: { body } }) => {
		const result = await context.repo.auth.signIn(trimObjectValues(body));

		// FIX: Check if user is banned BEFORE returning token
		if (result.user.banned) {
			// Check if ban has expired
			if (result.user.banExpires && new Date() > result.user.banExpires) {
				// Ban expired - allow sign in and clear ban status
				// Note: A separate job should handle clearing expired bans
			} else {
				// Ban is still active - throw error, don't return token
				const message = result.user.banReason
					? `Account banned: ${result.user.banReason}`
					: "Your account has been banned";
				throw new AuthError(message, {
					code: "FORBIDDEN",
				});
			}
		}

		context.resHeaders?.set(
			"Set-Cookie",
			composeAuthCookieValue({
				token: result.token,
				isDev,
				maxAge: 7 * 24 * 60 * 60,
			}),
		);

		return {
			status: 200,
			body: {
				message: m.sign_in_successful({}, context),
				data: nullToUndefined(result),
			},
		} as const;
	}),
	signUpUser: pub.signUpUser.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(unflattenData(body));

		// Get IP for fraud detection
		const ipAddress =
			context.req.headers.get("x-forwarded-for") ??
			context.req.headers.get("x-real-ip") ??
			undefined;
		const userAgent = context.req.headers.get("user-agent") ?? undefined;

		return await context.svc.db.transaction(async (tx) => {
			try {
				const opts = { tx };
				const [result, newCustomerBadge] = await Promise.all([
					context.repo.auth.signUp({ ...data, role: "USER" }, opts),
					context.repo.badge.main.getByCode("NEW_CUSTOMER", opts),
				]);

				const tasks: Promise<unknown>[] = [];

				// Duplicate account detection (non-blocking - monitoring only)
				if (ipAddress ?? data.name) {
					const [recentIpRegistrations, similarNames] = await Promise.all([
						ipAddress
							? context.repo.fraud.getRecentRegistrationsByIp(
									{ ipAddress },
									opts,
								)
							: Promise.resolve([]),
						data.name
							? context.repo.fraud.findSimilarUserNames(data, opts)
							: Promise.resolve([]),
					]);

					const duplicateResult = DuplicateAccountService.checkForDuplicates(
						{
							ipAddress,
							name: data.name,
						},
						{
							existingBankAccounts: [],
							recentIpRegistrations,
							similarNames,
						},
						{
							userId: result.user.id,
							name: data.name,
							email: data.email,
							ipAddress,
							userAgent,
						},
					);

					// Log fraud event if signals detected - await inside transaction
					// to ensure data consistency on rollback
					if (
						duplicateResult.hasDuplicates &&
						duplicateResult.signals.length > 0
					) {
						const score = DuplicateAccountService.calculateScore(
							duplicateResult.signals,
						);

						try {
							await context.repo.fraud.create(
								{
									eventType: duplicateResult.signals[0].type,
									severity: duplicateResult.signals[0].severity,
									status: "PENDING",
									userId: result.user.id,
									driverId: null,
									signals: duplicateResult.signals,
									score,
									location: null,
									previousLocation: null,
									distanceKm: null,
									timeDeltaSeconds: null,
									velocityKmh: null,
									ipAddress: ipAddress ?? null,
									userAgent: userAgent ?? null,
									handledById: null,
									resolution: null,
									actionTaken: null,
									detectedAt: new Date(),
									resolvedAt: null,
								},
								opts,
							);
						} catch (error) {
							logger.error(
								{ error, userId: result.user.id },
								"[AuthHandler] Failed to log duplicate account fraud event",
							);
							// Continue registration even if fraud logging fails
						}
					}

					// Record the IP for future duplicate detection
					if (ipAddress) {
						try {
							await context.repo.fraud.recordRegistrationIp(
								result.user.id,
								ipAddress,
								opts,
							);
						} catch (error) {
							logger.error(
								{ error, userId: result.user.id },
								"[AuthHandler] Failed to record registration IP",
							);
							// Continue registration even if IP logging fails
						}
					}
				}

				tasks.push(
					context.repo.badge.user.create(
						{
							userId: result.user.id,
							badgeId: newCustomerBadge.id,
						},
						opts,
					),
				);
				await Promise.all(tasks);

				const [signInResult] = await Promise.all([
					context.repo.auth.signIn(data, opts),
				]);

				await context.repo.auth.sendEmailVerification(
					{ email: data.email },
					opts,
				);

				if (!signInResult.user.banned) {
					context.resHeaders?.set(
						"Set-Cookie",
						composeAuthCookieValue({
							token: signInResult.token,
							isDev,
							maxAge: 7 * 24 * 60 * 60,
						}),
					);
				}

				return {
					status: 201,
					body: {
						message: m.server_user_created(),
						data: nullToUndefined(signInResult),
					},
				} as const;
			} catch (error) {
				logger.error({ error }, "[AuthHandler] Failed to sign up user");
				if (error instanceof BaseError) {
					throw error;
				}
				throw new RepositoryError(m.error_internal_server(), {
					code: "INTERNAL_SERVER_ERROR",
				});
			}
		});
	}),
	signUpDriver: pub.signUpDriver.handler(
		async ({ context, input: { body } }) => {
			const data = trimObjectValues(unflattenData(body));

			// Validate bank account before creating driver
			// This prevents registration with invalid bank accounts that would fail during withdrawals
			if (data.detail?.bank?.provider && data.detail?.bank?.number) {
				const bankValidation =
					await context.svc.bankValidation.validateBankAccount({
						bankProvider: data.detail.bank.provider as BankProvider,
						accountNumber: String(data.detail.bank.number),
					});

				if (!bankValidation.isValid) {
					throw new AuthError(m.server_bank_validation_failed(), {
						code: "BAD_REQUEST",
					});
				}

				logger.info(
					{
						bankProvider: data.detail.bank.provider,
						accountName: bankValidation.accountName,
					},
					"[AuthHandler] Bank account validated for driver sign-up",
				);
			}

			// Get IP for fraud detection
			const ipAddress =
				context.req.headers.get("x-forwarded-for") ??
				context.req.headers.get("x-real-ip") ??
				undefined;
			const userAgent = context.req.headers.get("user-agent") ?? undefined;

			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const [result, newDriverBadge] = await Promise.all([
						context.repo.auth.signUpDriver(data, opts),
						context.repo.badge.main.getByCode("NEW_DRIVER", opts),
					]);

					const tasks: Promise<unknown>[] = [];

					// Duplicate account detection for drivers (includes bank account check)
					const bankAccountNumber = data.detail?.bank?.number
						? String(data.detail.bank.number)
						: undefined;
					if (ipAddress ?? data.name ?? bankAccountNumber) {
						const [existingBankAccounts, recentIpRegistrations, similarNames] =
							await Promise.all([
								bankAccountNumber
									? context.repo.fraud.checkBankAccountExists(
											{ bankAccountNumber },
											opts,
										)
									: Promise.resolve([]),
								ipAddress
									? context.repo.fraud.getRecentRegistrationsByIp(
											{ ipAddress },
											opts,
										)
									: Promise.resolve([]),
								data.name
									? context.repo.fraud.findSimilarUserNames(data, opts)
									: Promise.resolve([]),
							]);

						const duplicateResult = DuplicateAccountService.checkForDuplicates(
							{
								bankAccountNumber,
								ipAddress,
								name: data.name,
							},
							{
								existingBankAccounts,
								recentIpRegistrations,
								similarNames,
							},
							{
								userId: result.user.id,
								name: data.name,
								email: data.email,
								bankAccountNumber,
								ipAddress,
								userAgent,
							},
						);

						// Log fraud event if signals detected - await inside transaction
						// to ensure data consistency on rollback
						if (
							duplicateResult.hasDuplicates &&
							duplicateResult.signals.length > 0
						) {
							const score = DuplicateAccountService.calculateScore(
								duplicateResult.signals,
							);

							try {
								await context.repo.fraud.create(
									{
										eventType: duplicateResult.signals[0].type,
										severity: duplicateResult.signals[0].severity,
										status: "PENDING",
										userId: result.user.id,
										driverId: null, // Driver not created yet at this point
										signals: duplicateResult.signals,
										score,
										location: null,
										previousLocation: null,
										distanceKm: null,
										timeDeltaSeconds: null,
										velocityKmh: null,
										ipAddress: ipAddress ?? null,
										userAgent: userAgent ?? null,
										handledById: null,
										resolution: null,
										actionTaken: null,
										detectedAt: new Date(),
										resolvedAt: null,
									},
									opts,
								);
							} catch (error) {
								logger.error(
									{ error, userId: result.user.id },
									"[AuthHandler] Failed to log driver duplicate account fraud event",
								);
								// Continue registration even if fraud logging fails
							}
						}

						// Record the IP for future duplicate detection
						if (ipAddress) {
							try {
								await context.repo.fraud.recordRegistrationIp(
									result.user.id,
									ipAddress,
									opts,
								);
							} catch (error) {
								logger.error(
									{ error, userId: result.user.id },
									"[AuthHandler] Failed to record driver registration IP",
								);
								// Continue registration even if IP logging fails
							}
						}
					}

					tasks.push(
						context.repo.driver.main.create(
							{
								...data.detail,
								userId: result.user.id,
							},
							opts,
						),
					);

					tasks.push(
						context.repo.badge.user.create(
							{
								userId: result.user.id,
								badgeId: newDriverBadge.id,
							},
							opts,
						),
					);

					await Promise.all(tasks);

					const [signInResult] = await Promise.all([
						context.repo.auth.signIn(data, opts),
					]);

					await context.repo.auth.sendEmailVerification(
						{ email: data.email },
						opts,
					);

					if (!signInResult.user.banned) {
						context.resHeaders?.set(
							"Set-Cookie",
							composeAuthCookieValue({
								token: signInResult.token,
								isDev,
								maxAge: 7 * 24 * 60 * 60,
							}),
						);
					}

					return {
						status: 201,
						body: {
							message: m.server_driver_registered(),
							data: nullToUndefined(signInResult),
						},
					} as const;
				} catch (error) {
					logger.error(
						{ error },
						`[AuthHandler] Failed to sign up driver ${error}`,
					);
					if (error instanceof BaseError) {
						throw error;
					}
					throw new RepositoryError(`An error occured, ${error}`, {
						code: "INTERNAL_SERVER_ERROR",
					});
				}
			});
		},
	),
	signUpMerchant: pub.signUpMerchant.handler(
		async ({ context, input: { body } }) => {
			const data = trimObjectValues(unflattenData(body));

			// Validate bank account before creating merchant
			// This prevents registration with invalid bank accounts that would fail during withdrawals
			if (data.detail?.bank?.provider && data.detail?.bank?.number) {
				const bankValidation =
					await context.svc.bankValidation.validateBankAccount({
						bankProvider: data.detail.bank.provider as BankProvider,
						accountNumber: String(data.detail.bank.number),
					});

				if (!bankValidation.isValid) {
					throw new AuthError(m.server_bank_validation_failed(), {
						code: "BAD_REQUEST",
					});
				}

				logger.info(
					{
						bankProvider: data.detail.bank.provider,
						accountName: bankValidation.accountName,
					},
					"[AuthHandler] Bank account validated for merchant sign-up",
				);
			}

			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const [result, newMerchantBadge] = await Promise.all([
						context.repo.auth.signUpMerchant(data, opts),
						context.repo.badge.main.getByCode("NEW_MERCHANT", opts),
					]);

					await Promise.all([
						context.repo.merchant.main.create(
							{
								...data.detail,
								userId: result.user.id,
							},
							opts,
						),
						context.repo.badge.user.create(
							{
								userId: result.user.id,
								badgeId: newMerchantBadge.id,
							},
							opts,
						),
					]);

					const [signInResult] = await Promise.all([
						context.repo.auth.signIn(data, opts),
					]);

					await context.repo.auth.sendEmailVerification(
						{ email: data.email },
						opts,
					);

					if (!signInResult.user.banned) {
						context.resHeaders?.set(
							"Set-Cookie",
							composeAuthCookieValue({
								token: signInResult.token,
								isDev,
								maxAge: 7 * 24 * 60 * 60,
							}),
						);
					}

					return {
						status: 201,
						body: {
							message: m.server_merchant_registered(),
							data: nullToUndefined(signInResult),
						},
					} as const;
				} catch (error) {
					logger.error({ error }, "[AuthHandler] Failed to sign up merchant");
					if (error instanceof BaseError) {
						throw error;
					}
					throw new RepositoryError(m.error_internal_server(), {
						code: "INTERNAL_SERVER_ERROR",
					});
				}
			});
		},
	),
	signOut: priv.signOut.handler(async ({ context, input: { body } }) => {
		context.resHeaders?.set(
			"Set-Cookie",
			composeAuthCookieValue({
				token: "",
				isDev,
				maxAge: 0,
			}),
		);

		if (!context.token) {
			throw new AuthError(m.error_invalid_authentication_token(), {
				code: "BAD_REQUEST",
			});
		}

		const tasks: Promise<unknown>[] = [
			context.repo.auth.signOut(context.token),
		];

		// Remove FCM token for this session/device if provided
		if (body?.fcmToken) {
			tasks.push(
				context.repo.notification.removeByToken({ token: body.fcmToken }),
			);
			logger.info(
				{ userId: context.user?.id },
				"[AuthHandler] Removing FCM token on sign out",
			);
		}

		await Promise.all(tasks);

		return {
			status: 200,
			body: {
				message: m.server_signout(),
				data: true,
			},
		} as const;
	}),
	getSession: priv.getSession.handler(async ({ context }) => {
		if (!context.token) {
			throw new AuthError(m.error_invalid_authentication_token(), {
				code: "BAD_REQUEST",
			});
		}
		const result = await context.repo.auth.getSession(context.token);

		if (result.token) {
			context.resHeaders?.set(
				"Set-Cookie",
				composeAuthCookieValue({
					token: result.token,
					isDev,
					maxAge: 7 * 24 * 60 * 60,
				}),
			);
		}

		return {
			status: 200,
			body: {
				message: m.server_session_retrieved(),
				data: nullToUndefined(result),
			},
		} as const;
	}),
	forgotPassword: pub.forgotPassword.handler(
		async ({ context, input: { body } }) => {
			await context.repo.auth.forgotPassword(trimObjectValues(body));

			return {
				status: 202,
				body: {
					message: m.server_password_reset_requested(),
					data: true,
				},
			};
		},
	),
	resetPassword: pub.resetPassword.handler(
		async ({ context, input: { body } }) => {
			await context.repo.auth.resetPassword(trimObjectValues(body));

			return {
				status: 200,
				body: {
					message: m.server_password_reset(),
					data: true,
				},
			} as const;
		},
	),
	hasAccess: priv.hasAccess.handler(async ({ context, input: { body } }) => {
		logger.debug(
			{ user: context.user, roles: body.roles },
			"verifying permissions",
		);
		const ok = hasRoles(context.user?.role, ...body.roles);

		return {
			status: 200,
			body: {
				message: m.server_permission_verified(),
				data: ok,
			},
		} as const;
	}),
	exchangeToken: priv.exchangeToken.handler(async ({ context }) => {
		if (!context.user) {
			throw new AuthError(m.error_invalid_session());
		}
		const token = await context.manager.jwt.signForWebSocket({
			id: context.user.id,
			role: context.user.role,
		});
		return {
			status: 200,
			body: {
				message: m.server_token_exchanged(),
				data: token,
			},
		};
	}),
	sendEmailVerification: pub.sendEmailVerification.handler(
		async ({ context, input: { body } }) => {
			return context.svc.db.transaction(async (tx) => {
				const opts = { tx };
				await context.repo.auth.sendEmailVerification(
					trimObjectValues(body),
					opts,
				);

				return {
					status: 202,
					body: {
						message: "Email verification sent successfully",
						data: true,
					},
				};
			});
		},
	),
	verifyEmail: pub
		.use(orpcAuthMiddleware)
		.verifyEmail.handler(async ({ context, input: { body } }) => {
			await context.svc.db.transaction(async (tx) => {
				await context.repo.auth.verifyEmail(trimObjectValues(body), { tx });
			});

			let token: string | undefined;
			let user: User | undefined;

			if (context.token && context.user) {
				const valid = await context.repo.auth.getSession(context.token);
				if (valid) {
					token = valid.token;
					user = valid.user;
					context.resHeaders?.set(
						"Set-Cookie",
						composeAuthCookieValue({
							token: context.token,
							isDev,
							maxAge: 7 * 24 * 60 * 60,
						}),
					);
				}
			}

			return {
				status: 200,
				body: {
					message: "Email verified successfully",
					data: { ok: true, token, user },
				},
			};
		}),
});
