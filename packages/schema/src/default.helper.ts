import { z } from "zod";

/**
 * Helper type to get all possible paths in an object type
 */
type Paths<T> = T extends object
	? {
			[K in keyof T & string]: T[K] extends object
				? T[K] extends unknown[] | Date | Map<unknown, unknown> | Set<unknown>
					? K
					: K | `${K}.${Paths<T[K]>}`
				: K;
		}[keyof T & string]
	: never;

/**
 * Helper type to get the value type at a specific path
 */
type PathValue<T, P extends string> = P extends `${infer Key}.${infer Rest}`
	? Key extends keyof T
		? PathValue<T[Key], Rest>
		: never
	: P extends keyof T
		? T[P]
		: never;

/**
 * Type-safe field overrides - keys are valid paths, values match field types
 */
type FieldOverrides<T> = Partial<{
	[K in Paths<T>]: PathValue<T, K>;
}>;

/**
 * Options for customizing default value generation
 */
type CreateDefaultOptions<T> = {
	/** Override specific fields by path (fully type-safe) */
	overrides?: FieldOverrides<T>;

	/** Strategy for enum fields: 'first' (default) | 'last' | custom value */
	enumStrategy?: "first" | "last" | ((values: readonly unknown[]) => unknown);

	/** Strategy for optional fields: 'undefined' (default) | 'skip' */
	optionalStrategy?: "undefined" | "skip";
};

/**
 * Creates type-safe default values from a Zod schema
 */
export function createDefaults<T extends z.ZodTypeAny>(
	schema: T,
	options?: CreateDefaultOptions<z.infer<T>>,
): z.infer<T> {
	return createDefaultsInternal(schema, options || {}, "") as z.infer<T>;
}

function createDefaultsInternal<T extends z.ZodTypeAny>(
	schema: T,
	options: CreateDefaultOptions<unknown>,
	path: string,
): unknown {
	// Check for field override
	if (options.overrides && path in options.overrides) {
		return (options.overrides as Record<string, unknown>)[path];
	}

	// ZodDefault - use the default value
	if (schema instanceof z.ZodDefault) {
		const defaultValue = (schema as unknown as { defaultValue: unknown })
			.defaultValue;
		return typeof defaultValue === "function" ? defaultValue() : defaultValue;
	}

	// ZodOptional
	if (schema instanceof z.ZodOptional) {
		return options.optionalStrategy === "skip" ? undefined : undefined;
	}

	// ZodNullable
	if (schema instanceof z.ZodNullable) {
		return null;
	}

	// ZodObject - recursively create defaults
	if (schema instanceof z.ZodObject) {
		const result: Record<string, unknown> = {};
		const shape = schema.shape;

		for (const key in shape) {
			const fieldPath = path ? `${path}.${key}` : key;
			const value = createDefaultsInternal(shape[key], options, fieldPath);

			// Skip undefined if strategy is 'skip'
			if (!(options.optionalStrategy === "skip" && value === undefined)) {
				result[key] = value;
			}
		}

		return result;
	}

	// ZodArray
	if (schema instanceof z.ZodArray) {
		return [];
	}

	// ZodString
	if (schema instanceof z.ZodString) {
		return "";
	}

	// ZodNumber
	if (schema instanceof z.ZodNumber) {
		return 0;
	}

	// ZodBoolean
	if (schema instanceof z.ZodBoolean) {
		return false;
	}

	// ZodDate
	if (schema instanceof z.ZodDate) {
		return new Date();
	}

	// ZodEnum
	if (schema instanceof z.ZodEnum) {
		const enumValues = (schema as unknown as { enumValues: unknown[] })
			.enumValues;
		return getEnumValue(enumValues || [], options.enumStrategy);
	}

	// ZodLiteral
	if (schema instanceof z.ZodLiteral) {
		return (schema as unknown as { value: unknown }).value;
	}

	// ZodRecord
	if (schema instanceof z.ZodRecord) {
		return {};
	}

	// ZodMap
	if (schema instanceof z.ZodMap) {
		return new Map();
	}

	// ZodSet
	if (schema instanceof z.ZodSet) {
		return new Set();
	}

	// ZodUnion - use first option
	if (schema instanceof z.ZodUnion) {
		const options_array = (schema as unknown as { options: unknown[] }).options;
		const firstOption = options_array?.[0];
		if (firstOption) {
			return createDefaultsInternal(firstOption as z.ZodTypeAny, options, path);
		}
		return undefined;
	}

	// ZodDiscriminatedUnion - use first option
	if (schema instanceof z.ZodDiscriminatedUnion) {
		const opts_map = (
			schema as unknown as { optionsMap: Map<unknown, z.ZodTypeAny> }
		).optionsMap;
		const opts = Array.from(opts_map?.values() || []);
		if (opts[0]) {
			return createDefaultsInternal(opts[0], options, path);
		}
		return undefined;
	}

	// ZodIntersection - merge both sides
	if (schema instanceof z.ZodIntersection) {
		const leftSchema = (schema as unknown as { left: z.ZodTypeAny }).left;
		const rightSchema = (schema as unknown as { right: z.ZodTypeAny }).right;
		const left = createDefaultsInternal(leftSchema, options, path);
		const right = createDefaultsInternal(rightSchema, options, path);
		if (
			typeof left === "object" &&
			typeof right === "object" &&
			left !== null &&
			right !== null
		) {
			return {
				...(left as Record<string, unknown>),
				...(right as Record<string, unknown>),
			};
		}
		return left;
	}

	// ZodTuple
	if (schema instanceof z.ZodTuple) {
		const items = (schema as unknown as { items: z.ZodTypeAny[] }).items;
		return (items || []).map((item, i: number) =>
			createDefaultsInternal(item, options, `${path}[${i}]`),
		);
	}

	// ZodCatch
	if (schema instanceof z.ZodCatch) {
		try {
			const innerType = (schema as unknown as { innerType: z.ZodTypeAny })
				.innerType;
			return createDefaultsInternal(innerType, options, path);
		} catch {
			const catchValue = (schema as unknown as { catchValue: unknown })
				.catchValue;
			return typeof catchValue === "function" ? catchValue() : catchValue;
		}
	}

	// Fallback
	return undefined;
}

function getEnumValue(
	values: readonly unknown[],
	strategy?: CreateDefaultOptions<unknown>["enumStrategy"],
): unknown {
	if (!strategy || strategy === "first") {
		return values[0];
	}
	if (strategy === "last") {
		return values[values.length - 1];
	}
	return strategy(values);
}
