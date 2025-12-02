type Output<T, Prefix extends string> = {
	[K in keyof T as K extends `${Prefix}${infer Rest}`
		? Uncapitalize<Rest>
		: K]: T[K];
};

export function unprefixKeys<
	T extends Record<string, unknown>,
	Prefix extends string,
>(obj: T, prefix: Prefix): Output<T, Prefix> {
	const result: Record<string, unknown> = {};

	for (const [key, value] of Object.entries(obj)) {
		if (key.startsWith(prefix)) {
			const newKey = key.slice(prefix.length);
			result[newKey.charAt(0).toLowerCase() + newKey.slice(1)] = value;
		} else {
			result[key] = value;
		}
	}

	return result as unknown as Output<T, Prefix>;
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

type NullToUndefined<T> =
	// preserve null → undefined
	T extends null
		? undefined
		: // preserve built-in objects
			T extends Date
			? Date
			: T extends RegExp
				? RegExp
				: T extends Map<infer K, infer V>
					? Map<NullToUndefined<K>, NullToUndefined<V>>
					: T extends Set<infer U>
						? Set<NullToUndefined<U>>
						: // arrays
							T extends (infer U)[]
							? NullToUndefined<U>[]
							: // plain objects
								T extends object
								? { [K in keyof T]: NullToUndefined<T[K]> }
								: // primitives
									T;

export function nullsToUndefined<T>(obj: T): NullToUndefined<T> {
	if (obj === null) return undefined as NullToUndefined<T>;
	if (typeof obj !== "object") return obj as NullToUndefined<T>;

	// preserve special instances
	if (
		obj instanceof Date ||
		obj instanceof RegExp ||
		obj instanceof Map ||
		obj instanceof Set
	) {
		return obj as NullToUndefined<T>;
	}

	if (Array.isArray(obj)) {
		const arr = obj as unknown[];
		const len = arr.length;
		const result = new Array(len);
		for (let i = 0; i < len; i++) {
			const value = arr[i];
			result[i] = value === null ? undefined : nullsToUndefined(value);
		}
		return result as unknown as NullToUndefined<T>;
	}

	const record = obj as Record<string, unknown>;
	const result: Record<string, unknown> = {};

	for (const key in record) {
		if (Object.hasOwn(record, key)) {
			const value = record[key];
			result[key] = value === null ? undefined : nullsToUndefined(value);
		}
	}

	return result as unknown as NullToUndefined<T>;
}
