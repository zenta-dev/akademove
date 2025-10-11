import { randomBytes, scryptSync, timingSafeEqual } from "node:crypto";

export interface PasswordHashOptions {
	N?: number;
	r?: number;
	p?: number;
	keyLength?: number;
	saltLength?: number;
	maxmem?: number;
}

export class PasswordManager {
	private readonly config: Required<PasswordHashOptions>;

	constructor(options?: PasswordHashOptions) {
		this.config = {
			N: options?.N ?? 16384,
			r: options?.r ?? 16,
			p: options?.p ?? 1,
			keyLength: options?.keyLength ?? 64,
			saltLength: options?.saltLength ?? 16,
			maxmem: options?.maxmem ?? 128 * 16384 * 16 * 2,
		};
	}

	hash(password: string): string {
		if (!password) throw new Error("Password must not be empty");

		const salt = randomBytes(this.config.saltLength);
		const key = scryptSync(
			password.normalize("NFKC"),
			salt,
			this.config.keyLength,
			{
				N: this.config.N,
				r: this.config.r,
				p: this.config.p,
				maxmem: this.config.maxmem,
			},
		);

		return `${salt.toString("hex")}:${key.toString("hex")}`;
	}

	verify(hash: string, password: string): boolean {
		if (!hash || !password) return false;

		const [saltHex, keyHex] = hash.split(":");
		if (!saltHex || !keyHex) {
			throw new Error("Invalid password hash format");
		}

		const salt = Buffer.from(saltHex, "hex");
		const storedKey = Buffer.from(keyHex, "hex");
		const targetKey = scryptSync(
			password.normalize("NFKC"),
			salt,
			this.config.keyLength,
			{
				N: this.config.N,
				r: this.config.r,
				p: this.config.p,
				maxmem: this.config.maxmem,
			},
		);

		return timingSafeEqual(targetKey, storedKey);
	}
}
