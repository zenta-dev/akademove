import type { Permissions } from "@repo/shared";
import { createIsomorphicFn, createServerFn } from "@tanstack/react-start";
import { getRequestHeaders } from "@tanstack/react-start/server";
import { detectDevice } from "@/utils/user-agent";
import { orpcClient } from "./orpc";

export const getServerHeaders = createServerFn({ method: "GET" }).handler(
	async () => {
		const headers: Record<string, string> = {};
		for (const [key, value] of getRequestHeaders().entries()) {
			headers[key] = value;
		}
		return;
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
		const headers = new Headers();
		for (const [k, v] of getRequestHeaders().entries()) {
			if (v) headers.set(k, v);
		}
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
	.client(async (permissions: Permissions) => {
		try {
			await orpcClient.auth.hasPermission({
				body: { permissions },
			});
			return true;
		} catch (_error) {
			return false;
		}
	})
	.server(async (permissions: Permissions) => {
		try {
			await orpcClient.auth.hasPermission({
				body: { permissions },
			});
			return true;
		} catch (_error) {
			return false;
		}
	});
