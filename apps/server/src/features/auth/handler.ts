import { implement } from "@orpc/server";
import { unflattenData } from "@repo/schema/flatten.helper";
import {
	composeAuthCookieValue,
	nullToUndefined,
	type Permissions,
} from "@repo/shared";
import { AuthError, BaseError, RepositoryError } from "@/core/error";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware } from "@/core/middlewares/auth";
import { isDev } from "@/utils";
import { AuthSpec } from "./spec";

const os = implement(AuthSpec).$context<ORPCContext>();

export const AuthHandler = os.router({
	signIn: os.signIn.handler(async ({ context, input: { body } }) => {
		const result = await context.repo.auth.signIn(body);

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
				message: "User authenticated successfully.",
				data: nullToUndefined(result),
			},
		} as const;
	}),
	signUpUser: os.signUpUser.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			try {
				const opts = { tx };
				const result = await context.repo.auth.signUp(
					{ ...body, role: "user" },
					opts,
				);

				return {
					status: 201,
					body: {
						message: "User account created successfully.",
						data: nullToUndefined(result),
					},
				} as const;
			} catch (error) {
				if (error instanceof BaseError) {
					throw error;
				}
				console.error(error);
				throw new RepositoryError("An error occured", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}
		});
	}),
	signUpDriver: os.signUpDriver.handler(
		async ({ context, input: { body } }) => {
			const unflatten = unflattenData(body);
			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const result = await context.repo.auth.signUpDriver(unflatten, opts);
					await context.repo.driver.create(
						{
							...unflatten.detail,
							userId: result.user.id,
						},
						opts,
					);

					return {
						status: 201,
						body: {
							message: "Driver account registered successfully.",
							data: nullToUndefined(result),
						},
					} as const;
				} catch (error) {
					if (error instanceof BaseError) {
						throw error;
					}
					console.error(error);
					throw new RepositoryError("An error occured", {
						code: "INTERNAL_SERVER_ERROR",
					});
				}
			});
		},
	),
	signUpMerchant: os.signUpMerchant.handler(
		async ({ context, input: { body } }) => {
			const unflatten = unflattenData(body);

			return await context.svc.db.transaction(async (tx) => {
				try {
					const opts = { tx };
					const result = await context.repo.auth.signUpMerchant(
						unflatten,
						opts,
					);
					await context.repo.merchant.main.create(
						{
							...unflatten.detail,
							userId: result.user.id,
						},
						opts,
					);

					return {
						status: 201,
						body: {
							message: "Merchant account registered successfully.",
							data: nullToUndefined(result),
						},
					} as const;
				} catch (error) {
					if (error instanceof BaseError) {
						throw error;
					}
					console.error(error);
					throw new RepositoryError("An error occured", {
						code: "INTERNAL_SERVER_ERROR",
					});
				}
			});
		},
	),
	signOut: os.signOut.use(authMiddleware).handler(async ({ context }) => {
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
				message: "User signed out successfully.",
				data: true,
			},
		} as const;
	}),
	getSession: os.getSession.use(authMiddleware).handler(async ({ context }) => {
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
				message: "Session retrieved successfully.",
				data: nullToUndefined(result),
			},
		} as const;
	}),
	forgotPassword: os.forgotPassword.handler(
		async ({ context, input: { body } }) => {
			await context.repo.auth.forgotPassword(body);

			return {
				status: 202,
				body: {
					message: "Password reset instructions sent to the registered email.",
					data: true,
				},
			};
		},
	),
	resetPassword: os.resetPassword.handler(
		async ({ context, input: { body } }) => {
			await context.repo.auth.resetPassword(body);

			return {
				status: 200,
				body: {
					message: "Password has been reset successfully.",
					data: true,
				},
			} as const;
		},
	),
	hasPermission: os.hasPermission
		.use(authMiddleware)
		.handler(async ({ context, input: { body } }) => {
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
		}),
});
