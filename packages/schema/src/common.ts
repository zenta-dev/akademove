import type { ZodObject, ZodRawShape } from "zod";
import * as z from "zod";
import { CONSTANTS } from "./constants.ts";

export const LocationSchema = z
	.object({
		lat: z.coerce.number(),
		lng: z.coerce.number(),
	})
	.meta({
		title: "Location",
		ref: "Location",
	});

export const TimeSchema = z
	.object({
		h: z.number(),
		m: z.number(),
	})
	.meta({
		title: "Time",
		ref: "Time",
	});

export const BankSchema = z
	.object({
		provider: z.enum(CONSTANTS.BANK_PROVIDERS),
		number: z.coerce.number(),
	})
	.meta({
		title: "Bank",
		ref: "Bank",
	});

export const PhoneSchema = z
	.object({
		countryCode: z.enum(["ID"]),
		number: z.coerce.number(),
	})
	.meta({
		title: "Phone",
		ref: "Phone",
	});
export const DateSchema = z.coerce.date();

export const DayOfWeekSchema = z.enum(CONSTANTS.DAY_OF_WEEK);

export const EmptySchema = z.null();

export const UUIDParamSchema = z
	.object({ id: z.uuid() })
	.meta({ ref: "UUIDParam" });

export const StringParamSchema = z
	.object({ id: z.string() })
	.meta({ ref: "UUIDParam" });

export const GetQuerySchema = z
	.object({
		fromCache: z.preprocess((v) => {
			return v === "true" || v === true;
		}, z.boolean().default(false)),
	})
	.meta({ ref: "GetQuery" });

export const FailedResponseSchema = z
	.object({
		message: z.string(),
		code: z.string(),
	})
	.meta({
		title: "FailedResponse",
		ref: "FailedResponse",
	});

export const createSuccessResponseSchema = <T>(schema: T) =>
	z.object({
		message: z.string(),
		data: schema,
	});

export const listifySchema = <T extends z.core.SomeType>(schema: T) =>
	z.array(schema);

export const ClientAgentSchema = z.enum(["unknown", "mobile", "web"]);

export type Location = z.infer<typeof LocationSchema>;
export type Time = z.infer<typeof TimeSchema>;
export type Bank = z.infer<typeof BankSchema>;
export type Phone = z.infer<typeof PhoneSchema>;
export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;
export type FailedResponse = z.infer<typeof FailedResponseSchema>;
export type SuccessResponse<T> = z.infer<
	ReturnType<typeof createSuccessResponseSchema<T>>
>;
export type ClientAgent = z.infer<typeof ClientAgentSchema>;

type PrefixKeys<T extends ZodRawShape, Prefix extends string> = {
	[K in keyof T as `${Prefix}${Extract<K, string>}`]: T[K];
};

export function prefixSchemaKeys<T extends ZodObject, Prefix extends string>(
	schema: T,
	prefix: Prefix,
): ZodObject<PrefixKeys<T["shape"], Prefix>> {
	const newShape = Object.fromEntries(
		Object.entries(schema.shape).map(([key, value]) => [
			`${prefix}${key}`,
			value,
		]),
	) as PrefixKeys<T["shape"], Prefix>;

	return z.object(newShape as unknown as ZodRawShape) as unknown as ZodObject<
		PrefixKeys<T["shape"], Prefix>
	>;
}
