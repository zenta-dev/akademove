import {
	extractLocaleFromRequest,
	getLocale,
	type Locale,
	setLocale,
} from "@repo/i18n";
import type { RoleAccess } from "@repo/schema";
import { cookieParser } from "@repo/shared";
import { createIsomorphicFn, createServerFn } from "@tanstack/react-start";
import { getRequest, getRequestHeaders } from "@tanstack/react-start/server";
import * as z from "zod";
import { detectDevice } from "@/utils/user-agent";
import { orpcClient } from "./orpc";

export const getServerHeaders = createServerFn({ method: "GET" }).handler(
	async () => {
		const headers: Record<string, string> = {};
		for (const [key, value] of getRequestHeaders().entries()) {
			headers[key] = value;
		}
		return headers;
	},
);

export const getLayout = createIsomorphicFn()
	.client(() => {
		const ua =
			typeof navigator !== "undefined" ? navigator.userAgent : undefined;
		return detectDevice(ua);
	})
	.server(() => {
		const headers = getRequestHeaders();
		const ua = headers.get("User-Agent") ?? "";
		return detectDevice(ua);
	});

export const getSession = createIsomorphicFn()
	.client(async () => {
		try {
			const result = await orpcClient.auth.getSession();
			const user = result.body.data?.user;
			if (!user) return undefined;
			return user;
		} catch (_error) {
			return undefined;
		}
	})
	.server(async () => {
		const headers = getRequestHeaders();
		try {
			const result = await orpcClient.auth.getSession(
				{},
				{ context: { headers } },
			);
			const user = result.body.data?.user;
			if (!user) return undefined;
			return user;
		} catch (_error) {
			return undefined;
		}
	});

export const hasAccess = createIsomorphicFn()
	.client(async (roles: RoleAccess[]) => {
		try {
			const res = await orpcClient.auth.hasAccess({
				body: { roles },
			});
			return res.body.data;
		} catch (_) {
			return false;
		}
	})
	.server(async (roles: RoleAccess[]) => {
		try {
			const headers = getRequestHeaders();
			const res = await orpcClient.auth.hasAccess(
				{
					body: { roles },
				},
				{ context: { headers } },
			);
			return res.body.data;
		} catch (_) {
			return false;
		}
	});

export const setThemeCookie = createServerFn({ method: "POST" })
	.inputValidator(z.enum(["system", "dark", "light"]))
	.handler(async ({ data }) => {
		const headers = new Headers();
		headers.set("Set-Cookie", `theme=${data}; path=/; max-age=34560000;`);
		return new Response(JSON.stringify({ ok: true }), { headers });
	});

export const getThemeCookie = createServerFn({ method: "GET" }).handler(
	async () => {
		const headers = await getServerHeaders();
		const cookie = cookieParser(headers.cookie ?? "");
		return cookie.theme ?? "system";
	},
);

export const getLocaleIsomorphic = createIsomorphicFn()
	.client(getLocale)
	.server(() => {
		const req = getRequest();
		const cookie = cookieParser(req.headers.get("cookie") ?? "");

		const locale = cookie.locale as Locale | undefined;
		if (locale) setLocale(locale, { reload: false });

		return locale ?? extractLocaleFromRequest(req);
	});
