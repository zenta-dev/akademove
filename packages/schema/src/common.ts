import * as z from "zod";

export const LocationSchema = z.object({
	lat: z.number(),
	lng: z.number(),
});

export const TimeSchema = z.object({
	h: z.number(),
	m: z.number(),
});

export const DateSchema = z.number();

export const EmptySchema = z.null();

export const UUIDParamSchema = z.object({ id: z.uuid() });
export const GetQuerySchema = z.object({
	fromCache: z.preprocess((v) => {
		return v === "true" || v === true;
	}, z.boolean().default(false)),
});

export const FailedResponseSchema = z.object({
	success: z.literal(false),
	message: z.string(),
	errors: z.array(z.string()),
});

export const createSuccessResponseSchema = <T>(schema: T) =>
	z.object({
		success: z.literal(true),
		message: z.string(),
		data: schema,
	});

export const listifySchema = <T extends z.core.SomeType>(schema: T) =>
	z.array(schema);

export type Location = z.infer<typeof LocationSchema>;
export type Time = z.infer<typeof TimeSchema>;

export type FailedResponse = z.infer<typeof FailedResponseSchema>;
export type SuccessResponse<T> = z.infer<
	ReturnType<typeof createSuccessResponseSchema<T>>
>;
