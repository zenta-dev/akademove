import * as z from "zod/v4";

export function toOAPIRequestBody(
	schema: z.ZodType,
	contentType = "multipart/form-data",
) {
	const jsonSchema = z.toJSONSchema(schema);

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
