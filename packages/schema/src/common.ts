import type { StandardSchemaV1 } from "@standard-schema/spec";
import type { ZodObject, ZodRawShape } from "zod";
import * as z from "zod";
import { CONSTANTS } from "./constants.js";

export const TimeSchema = z.object({
	h: z.coerce.number(),
	m: z.coerce.number(),
});
export type Time = z.infer<typeof TimeSchema>;

export const BankProviderSchema = z.enum(CONSTANTS.BANK_PROVIDERS);
export type BankProvider = z.infer<typeof BankProviderSchema>;

export const BankSchema = z.object({
	provider: BankProviderSchema,
	number: z.coerce.number(),
	accountName: z.string().optional(),
});
export type Bank = z.infer<typeof BankSchema>;

export const CountryCodeSchema = z.enum(["ID"]);
export type CountryCode = z.infer<typeof CountryCodeSchema>;

export const PhoneSchema = z.object({
	countryCode: CountryCodeSchema,
	number: z.coerce.number<number>().int().min(0),
});
export type Phone = z.infer<typeof PhoneSchema>;

export const DateSchema = z.coerce.date();

export const DayOfWeekSchema = z.enum(CONSTANTS.DAY_OF_WEEK);
export type DayOfWeek = z.infer<typeof DayOfWeekSchema>;

export const EmptySchema = z.null();

export const ClientAgentSchema = z.enum(["unknown", "mobile", "web"]);
export type ClientAgent = z.infer<typeof ClientAgentSchema>;

export const WeightSizeSchema = z.enum(["SMALL", "MEDIUM", "LARGE"]);
export type WeightSize = z.infer<typeof WeightSizeSchema>;

// export const MoneyAmountSchema = z.object({
// 	currency: z.string(),
// 	amount: z.coerce.number(),
// });

export const UUIDParamSchema = z.object({ id: z.uuid() });

export const StringParamSchema = z.object({ id: z.string() });

export const GetQuerySchema = z.object({
	fromCache: z.preprocess((v) => {
		return v === "true" || v === true;
	}, z.boolean().default(false)),
});

export const FailedResponseSchema = z.object({
	message: z.string(),
	code: z.string(),
});
export type FailedResponse = z.infer<typeof FailedResponseSchema>;

export const CommonSchemaRegistries = {
	BankProvider: { schema: BankProviderSchema, strategy: "output" },
	Time: { schema: TimeSchema, strategy: "output" },
	Bank: { schema: BankSchema, strategy: "output" },
	CountryCode: { schema: CountryCodeSchema, strategy: "output" },
	Phone: { schema: PhoneSchema, strategy: "output" },
	DayOfWeek: { schema: DayOfWeekSchema, strategy: "output" },
	WeightSize: { schema: WeightSizeSchema, strategy: "output" },
} satisfies SchemaRegistries;

export const createSuccessResponseSchema = <T>(schema: T) =>
	z.object({
		message: z.string(),
		data: schema,
	});
export type SuccessResponse<T> = z.infer<
	ReturnType<typeof createSuccessResponseSchema<T>>
>;

export const listifySchema = <T extends z.core.SomeType>(schema: T) =>
	z.array(schema);

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
export type SchemaRegistries = {
	[key: string]: {
		strategy?: "input" | "output";
		schema: StandardSchemaV1<unknown, unknown>;
	};
};
