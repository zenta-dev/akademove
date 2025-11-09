import z from "zod";

export function extractSchemaKeysAsEnum<T extends z.ZodRawShape>(
	schema: z.ZodObject<T>,
) {
	const keys = Object.keys(schema.shape) as [
		keyof T & string,
		...(keyof T & string)[],
	];

	return z.enum(keys);
}
export function mergeEnums<T extends readonly [z.ZodEnum, ...z.ZodEnum[]]>(
	...enums: T
) {
	const allValues = enums.flatMap((enumSchema) => enumSchema.options);
	const uniqueValues = [...new Set(allValues)] as [string, ...string[]];

	return z.enum(uniqueValues);
}
