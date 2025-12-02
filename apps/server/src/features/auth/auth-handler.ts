import { m } from "@repo/i18n";
import { unflattenData } from "@repo/schema/flatten.helper";
import {
	composeAuthCookieValue,
	nullToUndefined,
	type Permissions,
	trimObjectValues,
} from "@repo/shared";
import { AuthError, BaseError, RepositoryError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { isDev, log } from "@/utils";
import { AuthSpec } from "./auth-spec";

const { pub, priv } = createORPCRouter(AuthSpec);

export const AuthHandler = pub.router({
	signIn: pub.signIn.handler(async ({ context, input: { body } }) => {
		const result = await context.repo.auth.signIn(trimObjectValues(body));

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
		return await context.svc.db.transaction(async (tx) => {
			try {
				const opts = { tx };
				const [result, newCustomerBadge] = await Promise.all([
					context.repo.auth.signUp({ ...data, role: "USER" }, opts),
					context.repo.badge.main.getByCode("NEW_CUSTOMER", opts),
				]);

				await context.repo.badge.user.create(
					{
						userId: result.user.id,
						badgeId: newCustomerBadge.id,
					},
					opts,
				);

				return {
					status: 201,
					body: {
						message: m.server_user_created(),
						data: nullToUndefined(result),
					},
				} as const;
			} catch (error) {
				log.error({ error }, "[AuthHandler] Failed to sign up user");
				if (error instanceof BaseError) {
					throw error;
				}
				throw new RepositoryError("An error occured", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}
		});
	}),
	signUpDriver: pub.signUpDriver.handler(
		async ({ context, input: { body } }) => {
			const data = trimObjectValues(unflattenData(body));
			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const [result, newDriverBadge] = await Promise.all([
						context.repo.auth.signUpDriver(data, opts),
						context.repo.badge.main.getByCode("NEW_DRIVER", opts),
					]);
					await Promise.allSettled([
						context.repo.driver.main.create(
							{
								...data.detail,
								userId: result.user.id,
							},
							opts,
						),
						context.repo.badge.user.create(
							{
								userId: result.user.id,
								badgeId: newDriverBadge.id,
							},
							opts,
						),
					]);

					return {
						status: 201,
						body: {
							message: m.server_driver_registered(),
							data: nullToUndefined(result),
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
					const [result, newCustomerBadge] = await Promise.all([
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
								badgeId: newCustomerBadge.id,
							},
							opts,
						),
					]);

					return {
						status: 201,
						body: {
							message: m.server_merchant_registered(),
							data: nullToUndefined(result),
						},
					} as const;
				} catch (error) {
					log.error({ error }, "[AuthHandler] Failed to sign up merchant");
					if (error instanceof BaseError) {
						throw error;
					}
					throw new RepositoryError("An error occured", {
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
			throw new AuthError("Invalid authentication token.", {
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
			throw new AuthError("Invalid authentication token.", {
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
	hasPermission: priv.hasPermission.handler(
		async ({ context, input: { body } }) => {
			const ok = context.svc.rbac.hasPermission({
				role: context.user.role,
				permissions: body.permissions as Permissions,
			});

			return {
				status: 200,
				body: {
					message: "Permission verification completed.",
					data: ok,
				},
			} as const;
		},
	),
	exchangeToken: priv.exchangeToken.handler(async ({ context }) => {
		if (!context.user) {
			throw new AuthError("Invalid session");
		}
		const token = await context.manager.jwt.signForWebSocket({
			id: context.user.id,
			role: context.user.role,
		});
		return {
			status: 200,
			body: {
				message: "Successfully retrieved users data",
				data: token,
			},
		};
	}),
});
