import { m } from "@repo/i18n";
import { unflattenData } from "@repo/schema/flatten.helper";
import {
	composeAuthCookieValue,
	nullToUndefined,
	trimObjectValues,
} from "@repo/shared";
import { AuthError, BaseError, RepositoryError } from "@/core/error";
import { hasRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DuplicateAccountService } from "@/features/fraud/services";
import { isDev, log } from "@/utils";
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
					context.repo.badge.main
						.getByCode("NEW_CUSTOMER", opts)
						.catch(() => null),
				]);

				// Duplicate account detection (non-blocking - monitoring only)
				if (ipAddress ?? data.name) {
					const [recentIpRegistrations, similarNames] = await Promise.all([
						ipAddress
							? context.repo.fraud.getRecentRegistrationsByIp(ipAddress)
							: Promise.resolve([]),
						data.name
							? context.repo.fraud.findSimilarUserNames(data.name)
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

					// Log fraud event if signals detected
					if (
						duplicateResult.hasDuplicates &&
						duplicateResult.signals.length > 0
					) {
						const score = DuplicateAccountService.calculateScore(
							duplicateResult.signals,
						);

						// Fire and forget - don't block registration
						context.repo.fraud
							.create(
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
							)
							.catch((error) => {
								log.error(
									{ error, userId: result.user.id },
									"[AuthHandler] Failed to log duplicate account fraud event",
								);
							});
					}

					// Record the IP for future duplicate detection
					if (ipAddress) {
						context.repo.fraud
							.recordRegistrationIp(result.user.id, ipAddress, opts)
							.catch((error) => {
								log.error(
									{ error, userId: result.user.id },
									"[AuthHandler] Failed to record registration IP",
								);
							});
					}
				}

				const [signInResult] = await Promise.all([
					context.repo.auth.signIn(data, opts),
					context.repo.auth
						.sendEmailVerification({ email: data.email })
						.catch((err) => {
							log.error(
								{ error: err, email: data.email },
								"[AuthHandler] Failed to send verification email after user sign up",
							);
						}),
				]);

				// Create badge separately if it exists
				if (newCustomerBadge) {
					await context.repo.badge.user.create(
						{
							userId: result.user.id,
							badgeId: newCustomerBadge.id,
						},
						opts,
					);
				}

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
				log.error({ error }, "[AuthHandler] Failed to sign up user");
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
						context.repo.badge.main
							.getByCode("NEW_DRIVER", opts)
							.catch(() => null),
					]);

					// Duplicate account detection for drivers (includes bank account check)
					const bankAccountNumber = data.detail?.bank?.number
						? String(data.detail.bank.number)
						: undefined;
					if (ipAddress ?? data.name ?? bankAccountNumber) {
						const [existingBankAccounts, recentIpRegistrations, similarNames] =
							await Promise.all([
								bankAccountNumber
									? context.repo.fraud.checkBankAccountExists(bankAccountNumber)
									: Promise.resolve([]),
								ipAddress
									? context.repo.fraud.getRecentRegistrationsByIp(ipAddress)
									: Promise.resolve([]),
								data.name
									? context.repo.fraud.findSimilarUserNames(data.name)
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

						// Log fraud event if signals detected
						if (
							duplicateResult.hasDuplicates &&
							duplicateResult.signals.length > 0
						) {
							const score = DuplicateAccountService.calculateScore(
								duplicateResult.signals,
							);

							// Fire and forget - don't block registration
							context.repo.fraud
								.create(
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
								)
								.catch((error) => {
									log.error(
										{ error, userId: result.user.id },
										"[AuthHandler] Failed to log driver duplicate account fraud event",
									);
								});
						}

						// Record the IP for future duplicate detection
						if (ipAddress) {
							context.repo.fraud
								.recordRegistrationIp(result.user.id, ipAddress, opts)
								.catch((error) => {
									log.error(
										{ error, userId: result.user.id },
										"[AuthHandler] Failed to record driver registration IP",
									);
								});
						}
					}

					const [signInResult] = await Promise.all([
						context.repo.auth.signIn(data, opts),
						context.repo.driver.main.create(
							{
								...data.detail,
								userId: result.user.id,
							},
							opts,
						),
						context.repo.auth
							.sendEmailVerification({ email: data.email })
							.catch((err) => {
								log.error(
									{ error: err, email: data.email },
									"[AuthHandler] Failed to send verification email after driver sign up",
								);
							}),
					]);

					// Create badge separately if it exists
					if (newDriverBadge) {
						await context.repo.badge.user.create(
							{
								userId: result.user.id,
								badgeId: newDriverBadge.id,
							},
							opts,
						);
					}

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
					log.error(
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

			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const [result, newMerchantBadge] = await Promise.all([
						context.repo.auth.signUpMerchant(data, opts),
						context.repo.badge.main
							.getByCode("NEW_MERCHANT", opts)
							.catch(() => null),
					]);

					const [signInResult] = await Promise.all([
						context.repo.auth.signIn(data),
						context.repo.merchant.main.create(
							{
								...data.detail,
								userId: result.user.id,
							},
							opts,
						),
						context.repo.auth
							.sendEmailVerification({ email: data.email })
							.catch((err) => {
								log.error(
									{ error: err, email: data.email },
									"[AuthHandler] Failed to send verification email after merchant sign up",
								);
							}),
					]);

					// Create badge separately if it exists
					if (newMerchantBadge) {
						await context.repo.badge.user.create(
							{
								userId: result.user.id,
								badgeId: newMerchantBadge.id,
							},
							opts,
						);
					}

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
					log.error({ error }, "[AuthHandler] Failed to sign up merchant");
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
	signOut: priv.signOut.handler(async ({ context }) => {
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

		await context.repo.auth.signOut(context.token);

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
			await context.repo.auth.sendEmailVerification(trimObjectValues(body));

			return {
				status: 202,
				body: {
					message: "Email verification sent successfully",
					data: true,
				},
			};
		},
	),
	verifyEmail: pub.verifyEmail.handler(async ({ context, input: { body } }) => {
		await context.repo.auth.verifyEmail(trimObjectValues(body));

		return {
			status: 200,
			body: {
				message: "Email verified successfully",
				data: true,
			},
		};
	}),
});
