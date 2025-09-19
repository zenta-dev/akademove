import { env } from "cloudflare:workers";
import { createLocalJWKSet, type JWTPayload, jwtVerify } from "jose";
import type { AuthService } from "@/core/services/auth";
import type { HasPermissionRole } from "@/core/services/auth.permission";

export async function validateToken(token: string, auth: AuthService) {
	try {
		const remoteJWKS = await auth.api.getJwks();
		const JWKS = createLocalJWKSet(remoteJWKS);
		const { payload } = await jwtVerify(token, JWKS, {
			issuer: env.AUTH_URL,
			audience: env.AUTH_URL,
		});
		return payload as JWTPayload & {
			id: string;
			email: string;
			role: HasPermissionRole;
			banned: boolean;
		};
	} catch (error) {
		console.error("Token validation failed:", error);
		throw error;
	}
}
