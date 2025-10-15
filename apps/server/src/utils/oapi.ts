import * as z from "zod/v4";

function transformSchema<T extends z.ZodTypeAny>(schema: T): z.ZodTypeAny {
	if (schema instanceof z.ZodFile) {
		return z.file();
	}

	if (schema instanceof z.ZodObject) {
		const shape = schema.shape;
		const transformedShape: Record<string, z.ZodTypeAny> = {};

		for (const key in shape) {
			transformedShape[key] = transformSchema(shape[key] as z.ZodTypeAny);
		}

		return z.object(transformedShape);
	}

	if (schema instanceof z.ZodArray) {
		return z.array(transformSchema(schema.element as z.ZodTypeAny));
	}

	if (schema instanceof z.ZodOptional) {
		return transformSchema(schema.unwrap() as z.ZodTypeAny).optional();
	}

	if (schema instanceof z.ZodNullable) {
		return transformSchema(schema.unwrap() as z.ZodTypeAny).nullable();
	}

	if (schema instanceof z.ZodUnion) {
		return z.union(
			schema.options.map((opt) => transformSchema(opt as z.ZodTypeAny)) as [
				z.ZodTypeAny,
				z.ZodTypeAny,
				...z.ZodTypeAny[],
			],
		);
	}

	return schema;
}

export function toOAPIRequestBody<T extends z.ZodTypeAny>(
	schema: T,
	contentType = "multipart/form-data",
) {
	const transformedSchema = transformSchema(schema);

	const jsonSchema = z.toJSONSchema(transformedSchema);

	const cleanSchema = { ...jsonSchema };
	delete cleanSchema.$schema;

	return {
		requestBody: {
			required: true,
			content: {
				[contentType]: {
					schema: cleanSchema,
				},
			},
		},
	} as Record<string, unknown>;
}
