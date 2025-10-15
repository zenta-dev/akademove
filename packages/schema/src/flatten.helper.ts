/** biome-ignore-all lint/suspicious/noExplicitAny: at this point it's just too complex to type properly */

import { z } from "zod/v4";

/* ------------------------------ Type Helpers ------------------------------ */

type UnwrapZodType<T> = T extends z.ZodOptional<infer U>
	? UnwrapZodType<U>
	: T extends z.ZodDefault<infer U>
		? UnwrapZodType<U>
		: T extends z.ZodNullable<infer U>
			? UnwrapZodType<U>
			: T;

type BuildPrefix<P extends string, K extends string> = P extends ""
	? K
	: `${P}_${K}`;

type Entry<K extends string, V extends z.ZodTypeAny> = { key: K; value: V };

type FlattenEntries<
	T extends Record<string, z.ZodTypeAny>,
	P extends string = "",
> = {
	[K in keyof T & string]: UnwrapZodType<T[K]> extends z.ZodObject<infer U>
		? FlattenEntries<U, BuildPrefix<P, K>>
		: Entry<BuildPrefix<P, K>, T[K]>;
}[keyof T & string];

type FlattenZodShape<
	T extends Record<string, z.ZodTypeAny>,
	P extends string = "",
> = {
	[E in FlattenEntries<T, P> as E extends Entry<infer K, any>
		? K
		: never]: E extends Entry<any, infer V> ? V : never;
};

/* -------------------------- Flatten Zod Object ---------------------------- */

export function flattenZodObject<
	T extends z.ZodObject<z.ZodRawShape>,
	P extends string = "",
>(schema: T, prefix: P = "" as P): z.ZodObject<FlattenZodShape<T["shape"], P>> {
	const flatShape: Record<string, z.ZodTypeAny> = {};

	function flatten(
		obj: z.ZodObject<z.ZodRawShape>,
		currentPrefix: string,
	): void {
		for (const key in obj.shape) {
			const value = obj.shape[key];
			if (!value) continue;
			const newKey = currentPrefix ? `${currentPrefix}_${key}` : key;

			let unwrapped: z.ZodTypeAny = value as z.ZodAny;
			while (
				unwrapped instanceof z.ZodOptional ||
				unwrapped instanceof z.ZodDefault ||
				unwrapped instanceof z.ZodNullable
			) {
				unwrapped = unwrapped.unwrap() as z.ZodAny;
			}

			if (unwrapped instanceof z.ZodObject) {
				flatten(unwrapped, newKey);
			} else {
				flatShape[newKey] = value as z.ZodAny;
			}
		}
	}

	flatten(schema, prefix);
	return z.object(flatShape) as z.ZodObject<FlattenZodShape<T["shape"], P>>;
}

/* ------------------------------ Unflatten --------------------------------- */

type SplitKey<S extends string> = S extends `${infer Head}_${infer Tail}`
	? [Head, ...SplitKey<Tail>]
	: [S];

type NestedFromParts<Parts extends string[], Value> = Parts extends [
	infer Head extends string,
	...infer Tail extends string[],
]
	? { [K in Head]: NestedFromParts<Tail, Value> }
	: Value;

type UnionToIntersection<U> = (U extends any ? (k: U) => void : never) extends (
	k: infer I,
) => void
	? I
	: never;

type UnflattenUnion<
	T extends Record<string, any>,
	Prefix extends string = "",
> = {
	[K in keyof T & string]: K extends `${Prefix}_${infer Rest}`
		? NestedFromParts<SplitKey<Rest>, T[K]>
		: Prefix extends ""
			? NestedFromParts<SplitKey<K>, T[K]>
			: never;
}[keyof T & string];

type Unflatten<
	T extends Record<string, any>,
	Prefix extends string = "",
> = UnionToIntersection<UnflattenUnion<T, Prefix>>;

export function unflattenData<
	T extends Record<string, any>,
	P extends string = "",
>(flatData: T, prefix: P = "" as P): Unflatten<T, P> {
	const result: Record<string, any> = {};

	for (const key in flatData) {
		const relativeKey = prefix
			? key.replace(new RegExp(`^${prefix}_`), "")
			: key;
		const parts = relativeKey.split("_");
		let current = result;

		for (let i = 0; i < parts.length - 1; i++) {
			const part = parts[i];
			if (!part) continue;
			current[part] ??= {};
			current = current[part];
		}

		const lastPart = parts[parts.length - 1];
		if (!lastPart) continue;
		current[lastPart] = flatData[key];
	}

	return result as Unflatten<T, P>;
}
