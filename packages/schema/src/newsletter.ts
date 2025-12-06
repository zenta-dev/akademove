import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const NewsletterStatusSchema = z.enum([
	"ACTIVE",
	"UNSUBSCRIBED",
] as const);
export type NewsletterStatus = z.infer<typeof NewsletterStatusSchema>;

export const NewsletterSchema = z.object({
	id: z.uuid(),
	email: z.email({ message: "Invalid email address" }),
	status: NewsletterStatusSchema,
	userId: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
});
export type Newsletter = z.infer<typeof NewsletterSchema>;

export const NewsletterKeySchema = extractSchemaKeysAsEnum(NewsletterSchema);

export const InsertNewsletterSchema = NewsletterSchema.omit({
	id: true,
	status: true,
	createdAt: true,
	updatedAt: true,
}).extend({
	userId: z.uuid().optional(),
});
export type InsertNewsletter = z.infer<typeof InsertNewsletterSchema>;

export const UpdateNewsletterSchema = NewsletterSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
}).partial();
export type UpdateNewsletter = z.infer<typeof UpdateNewsletterSchema>;

export const NewsletterSchemaRegistries = {
	NewsletterStatus: { schema: NewsletterStatusSchema, strategy: "output" },
	Newsletter: { schema: NewsletterSchema, strategy: "output" },
	InsertNewsletter: { schema: InsertNewsletterSchema, strategy: "input" },
	UpdateNewsletter: { schema: UpdateNewsletterSchema, strategy: "input" },
	NewsletterKey: { schema: NewsletterKeySchema, strategy: "input" },
} satisfies SchemaRegistries;
