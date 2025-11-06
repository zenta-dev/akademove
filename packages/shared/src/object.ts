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

export function trimObjectValues<T extends Record<string, unknown>>(obj: T): T {
	for (const key in obj) {
		if (!Object.hasOwn(obj, key)) continue;

		const val = obj[key];

		if (typeof val === "string") {
			obj[key] = val.trim() as T[Extract<keyof T, string>];
		} else if (Array.isArray(val)) {
			obj[key] = val.map((item) =>
				typeof item === "object" && item !== null && !Array.isArray(item)
					? trimObjectValues(item as Record<string, unknown>)
					: typeof item === "string"
						? item.trim()
						: item,
			) as T[Extract<keyof T, string>];
		} else if (val !== null && typeof val === "object") {
			obj[key] = trimObjectValues(val as Record<string, unknown>) as T[Extract<
				keyof T,
				string
			>];
		}
	}

	return obj;
}
export function omit<T extends object, K extends readonly (keyof T)[]>(
	obj: T,
	keys: K,
): Omit<T, K[number]>;

export function omit<T extends object, K extends keyof T>(
	obj: T,
	...keys: K[]
): Omit<T, K>;

export function omit<T extends object>(
	obj: T,
	keysOrFirst?: readonly (keyof T)[] | keyof T,
	...rest: (keyof T)[]
): Omit<T, keyof typeof keySet> {
	const keys: readonly (keyof T)[] = Array.isArray(keysOrFirst)
		? keysOrFirst
		: keysOrFirst === undefined
			? []
			: [keysOrFirst, ...rest];

	const keySet = new Set<PropertyKey>(keys as readonly PropertyKey[]);

	const result = {} as Record<PropertyKey, unknown>;

	const allKeys: readonly PropertyKey[] = [
		...Object.getOwnPropertyNames(obj),
		...Object.getOwnPropertySymbols(obj),
	];

	for (const key of allKeys) {
		if (!keySet.has(key)) {
			const desc = Object.getOwnPropertyDescriptor(obj, key);
			if (desc) {
				Object.defineProperty(result, key, desc);
			}
		}
	}

	return result as unknown as Omit<T, keyof typeof keySet>;
}
