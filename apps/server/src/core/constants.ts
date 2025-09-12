export const CACHE_TTLS = Object.freeze({
	"1h": 1 * 60 * 60,
	"24h": 24 * 60 * 60,
} as const);

export const CACHE_PREFIXES = Object.freeze({
	DRIVER: "driver:",
} as const);
