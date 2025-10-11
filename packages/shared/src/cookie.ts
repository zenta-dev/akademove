import { AUTH_CONSTANTS } from "@repo/schema/constants";

interface AuthCookieOptions {
	token: string;
	maxAge?: number; // in seconds
	isDev?: boolean;
}

export function getAuthTokenName(isDev?: boolean): string {
	return isDev
		? AUTH_CONSTANTS.SESSION_TOKEN
		: `__Secure-${AUTH_CONSTANTS.SESSION_TOKEN}`;
}

export function cookieParser(str: string) {
	return Object.fromEntries(
		str.split(";").map((c) => {
			const [key, value] = c.trim().split("=");
			return [key, value];
		}),
	);
}

export function getAuthToken({
	headers,
	isDev,
}: {
	headers: Headers;
	isDev?: boolean;
}) {
	const authHeader = headers.get("authorization");
	const cookieHeader = headers.get("cookie");

	const bearerToken = authHeader?.startsWith("Bearer ")
		? authHeader.split(" ")[1]
		: undefined;

	let cookieToken: string | undefined;
	if (cookieHeader) {
		const cookies = cookieParser(cookieHeader);
		cookieToken = cookies[getAuthTokenName(isDev)];
	}
	return bearerToken ?? cookieToken;
}

export function composeAuthCookieValue({
	token,
	maxAge = 60 * 60 * 24, // 1 day, in seconds
	isDev = false,
}: AuthCookieOptions): string {
	const name = getAuthTokenName(isDev);

	const parts = [
		`${name}=${token}`,
		`Max-Age=${maxAge}`,
		"Path=/",
		"HttpOnly",
		"Secure",
		"SameSite=None",
	];

	if (!isDev) {
		parts.push("Domain=.zenta.dev");
	}

	return parts.join("; ");
}
