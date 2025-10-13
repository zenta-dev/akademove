import { implement } from "@orpc/server";
import {
	composeAuthCookieValue,
	nullToUndefined,
	type Permissions,
} from "@repo/shared";
import { AuthError } from "@/core/error";
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
				isDev: isDev,
				maxAge: 7 * 60 * 60 * 24,
			}),
		);

		return {
			status: 200,
			body: { message: "OK", data: nullToUndefined(result) },
		};
	}),
	signUpUser: os.signUpUser.handler(async ({ context, input: { body } }) => {
		const result = await context.repo.auth.signUp({ ...body, role: "user" });

		return {
			status: 200,
			body: { message: "OK", data: nullToUndefined(result) },
		};
	}),
	signUpDriver: os.signUpDriver.handler(
		async ({ context, input: { body } }) => {
			const result = await context.repo.auth.signUpDriver(body);

			await context.repo.driver.create({
				...body,
				...body.detail,
				userId: result.user.id,
			});

			return {
				status: 200,
				body: { message: "OK", data: nullToUndefined(result) },
			};
		},
	),
	signUpMerchant: os.signUpMerchant.handler(
		async ({ context, input: { body } }) => {
			const result = await context.repo.auth.signUpMerchant(body);
			await context.repo.merchant.main.create({
				...body,
				...body.detail,
				userId: result.user.id,
			});

			return {
				status: 200,
				body: { message: "OK", data: nullToUndefined(result) },
			};
		},
	),
	signOut: os.signOut.use(authMiddleware).handler(async ({ context }) => {
		context.resHeaders?.set(
			"Set-Cookie",
			composeAuthCookieValue({
				token: "",
				isDev: isDev,
				maxAge: 0,
			}),
		);

		return {
			status: 200,
			body: { message: "OK", data: true },
		};
	}),
	getSession: os.getSession.use(authMiddleware).handler(async ({ context }) => {
		if (!context.token) {
			throw new AuthError("Invalid token", { code: "BAD_REQUEST" });
		}
		const result = await context.repo.auth.getSession(context.token);

		if (result.token) {
			context.resHeaders?.set(
				"Set-Cookie",
				composeAuthCookieValue({
					token: result.token,
					isDev: isDev,
					maxAge: 7 * 60 * 60 * 24,
				}),
			);
		}

		return {
			status: 200,
			body: { message: "OK", data: nullToUndefined(result) },
		};
	}),
	forgotPassword: os.forgotPassword.handler(
		async ({ context, input: { body } }) => {
			const _res = await context.repo.auth.forgotPassword(body);
			return {
				status: 200,
				body: { message: "UNIMPELEMNTED", data: true },
			};
		},
	),
	resetPassword: os.resetPassword.handler(
		async ({ context, input: { body } }) => {
			const _res = await context.repo.auth.resetPassword(body);
			return {
				status: 200,
				body: { message: "UNIMPELEMNTED", data: true },
			};
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
				body: { message: "OK", data: ok },
			};
		}),
});
