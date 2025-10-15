export function unprefixKeys<
	T extends Record<string, unknown>,
	Prefix extends string,
>(
	obj: T,
	prefix: Prefix,
): {
	[K in keyof T as K extends `${Prefix}${infer Rest}`
		? Uncapitalize<Rest>
		: K]: T[K];
} {
	const result: Record<string, unknown> = {};

	for (const [key, value] of Object.entries(obj)) {
		if (key.startsWith(prefix)) {
			const newKey = key.slice(prefix.length);
			result[newKey.charAt(0).toLowerCase() + newKey.slice(1)] = value;
		} else {
			result[key] = value;
		}
	}

	// biome-ignore lint/suspicious/noExplicitAny: cant cast the output
	return result as any;
}
