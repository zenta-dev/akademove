import type { Session } from "@repo/schema/auth";
import type { User } from "@repo/schema/user";
import { createIsomorphicFn, createServerFn } from "@tanstack/react-start";
import { getHeaders } from "@tanstack/react-start/server";
import { detectDevice } from "@/utils/user-agent";
import { authClient } from "./auth-client";

export const getServerHeaders = createServerFn({ method: "GET" }).handler(
	async () => {
		return getHeaders();
	},
);

export const getLayout = createIsomorphicFn()
	.client(() => {
		const ua =
			typeof navigator !== "undefined" ? navigator.userAgent : undefined;
		return detectDevice(ua);
	})
	.server(() => {
		const headers = getHeaders();
		const ua = headers["user-agent"] ?? headers["User-Agent"];
		return detectDevice(ua);
	});

export const getSession = createIsomorphicFn()
	.client(async () => {
		const result = await authClient.getSession();
		if (result.error) return undefined;
		return (result.data ?? undefined) as unknown as
			| { user: User; session: Session }
			| undefined;
	})
	.server(async () => {
		const headers = new Headers();
		for (const [k, v] of Object.entries(await getServerHeaders())) {
			if (v) headers.set(k, v);
		}
		const response = await fetch(
			`${import.meta.env.VITE_SERVER_URL}/auth/get-session`,
			{ method: "GET", headers },
		);
		const result: { user: User; session: Session } | null =
			await response.json();
		if (!result || !result.user) return undefined;
		return result;
	});

type Permissions = Parameters<
	(typeof authClient)["admin"]["hasPermission"]
>["0"]["permissions"];

export const hasAccess = createIsomorphicFn()
	.client(async (permissions: Permissions) => {
		console.log("client permissions", permissions);

		const result = await authClient.admin.hasPermission({
			permissions,
		});
		if (result.error || result.data.error || !result.data.success) return false;
		return true;
	})
	.server(async (permissions: Permissions) => {
		console.log("server permissions", permissions);
		const headers = getHeaders();
		const response = await fetch(
			`${import.meta.env.VITE_SERVER_URL}/auth/admin/has-permission`,
			{
				credentials: "include",
				method: "POST",
				headers: {
					Cookie: headers.cookie || "",
					"Content-Type": "application/json",
				},
				body: JSON.stringify({ permissions }),
			},
		);
		if (!response.ok) return false;
		const result = await response.json();
		if (!result) return false;
		if (result.error) return false;
		if (!result.success) return false;
		return true;
	});
