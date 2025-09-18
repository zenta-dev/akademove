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
		return result.data as unknown as { user: User; session: Session };
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
