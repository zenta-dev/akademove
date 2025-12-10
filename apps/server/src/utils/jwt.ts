import { env } from "cloudflare:workers";
import type { ClientAgent } from "@repo/schema/common";
import type { UserRole } from "@repo/schema/user";
import { type JWTPayload, jwtVerify, SignJWT } from "jose";
import { AuthError, BaseError } from "@/core/error";
import { logger } from "./logger";

export interface CustomPayload {
	id: string;
	role: UserRole;
	expiration: number;
}

export interface TokenPayload extends CustomPayload {
	shouldRotate: boolean;
}

export class JwtManager {
	private readonly secretKey: Uint8Array;
	private readonly issuer: string;
	private readonly audience: string;
	private readonly expiration: string;
	private readonly rotationThresholdMs: number;

	constructor(options: {
		secret: string;
		issuer?: string;
		audience?: string;
		expiration?: string;
		rotationThresholdHours?: number;
	}) {
		this.secretKey = new TextEncoder().encode(options.secret);
		this.issuer = options.issuer ?? env.AUTH_URL;
		this.audience = options.audience ?? `.${env.ROOT_DOMAIN}`;
		this.expiration = options.expiration ?? "1h";
		this.rotationThresholdMs =
			(options.rotationThresholdHours ?? 12) * 60 * 60 * 1000;
	}

	async sign({
		id,
		role,
		expiration,
		clientAgent,
	}: {
		id: string;
		role: UserRole;
		expiration?: string | number;
		clientAgent?: ClientAgent;
	}): Promise<string> {
		return new SignJWT({ sub: id, role })
			.setProtectedHeader({ alg: "HS256" })
			.setIssuer(this.issuer)
			.setAudience(
				clientAgent ? `${clientAgent}${this.audience}` : this.audience,
			)
			.setExpirationTime(expiration ?? this.expiration)
			.setIssuedAt()
			.sign(this.secretKey);
	}

	async signForWebSocket({
		id,
		role,
		clientAgent,
		ttlSeconds = 180, // 3 minutes default
	}: {
		id: string;
		role: UserRole;
		clientAgent?: ClientAgent;
		ttlSeconds?: number;
	}): Promise<string> {
		return new SignJWT({
			sub: id,
			role,
			ws: true,
		})
			.setProtectedHeader({ alg: "HS256" })
			.setIssuer(this.issuer)
			.setAudience(
				clientAgent ? `${clientAgent}.${this.audience}` : this.audience,
			)
			.setExpirationTime(`${ttlSeconds}s`)
			.setIssuedAt()
			.sign(this.secretKey);
	}

	async verify(token: string): Promise<TokenPayload> {
		try {
			const { payload } = await jwtVerify(token, this.secretKey, {
				issuer: this.issuer,
				audience: this.audience,
			});

			if (!payload.sub || !payload.role || !payload.exp) {
				throw new AuthError("Invalid session token", { code: "BAD_REQUEST" });
			}

			const expMs = payload.exp * 1000;
			const timeUntilExpiry = expMs - Date.now();

			return {
				id: payload.sub,
				role: payload.role as UserRole,
				expiration: expMs,
				shouldRotate: timeUntilExpiry < this.rotationThresholdMs,
			};
		} catch (error) {
			logger.error(error, `${this.verify.name} | Error => `);
			if (error instanceof BaseError) throw error;
			throw new AuthError("Invalid or expired token", {
				code: "UNAUTHORIZED",
			});
		}
	}

	decode(token: string): JWTPayload {
		const parts = token.split(".");
		if (parts.length !== 3 || !parts[1]) {
			throw new AuthError("Invalid token format", { code: "UNAUTHORIZED" });
		}

		const jsonPayload =
			typeof atob !== "undefined"
				? atob(parts[1].replace(/-/g, "+").replace(/_/g, "/"))
				: Buffer.from(parts[1], "base64").toString("utf-8");

		return JSON.parse(jsonPayload);
	}
}
