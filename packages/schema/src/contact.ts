import * as z from "zod";
import { DateSchema, type SchemaRegistries } from "./common.js";
import { extractSchemaKeysAsEnum } from "./enum.helper.js";

export const ContactStatusSchema = z.enum([
	"PENDING",
	"REVIEWING",
	"RESOLVED",
	"CLOSED",
] as const);
export type ContactStatus = z.infer<typeof ContactStatusSchema>;

export const ContactSchema = z.object({
	id: z.uuid(),
	name: z.string().min(1).max(255),
	email: z.string().email({ message: "Invalid email address" }),
	subject: z.string().min(1).max(500),
	message: z.string().min(1).max(5000),
	status: ContactStatusSchema,
	userId: z.uuid().optional(),
	respondedById: z.uuid().optional(),
	response: z.string().optional(),
	createdAt: DateSchema,
	updatedAt: DateSchema,
	respondedAt: DateSchema.optional(),
});
export type Contact = z.infer<typeof ContactSchema>;

export const ContactKeySchema = extractSchemaKeysAsEnum(ContactSchema);

export const InsertContactSchema = ContactSchema.omit({
	id: true,
	status: true,
	respondedById: true,
	response: true,
	createdAt: true,
	updatedAt: true,
	respondedAt: true,
}).extend({
	userId: z.uuid().optional(),
});
export type InsertContact = z.infer<typeof InsertContactSchema>;

export const UpdateContactSchema = ContactSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
	respondedAt: true,
}).partial();
export type UpdateContact = z.infer<typeof UpdateContactSchema>;

export const ContactSchemaRegistries = {
	ContactStatus: { schema: ContactStatusSchema, strategy: "output" },
	Contact: { schema: ContactSchema, strategy: "output" },
	InsertContact: { schema: InsertContactSchema, strategy: "input" },
	UpdateContact: { schema: UpdateContactSchema, strategy: "input" },
	ContactKey: { schema: ContactKeySchema, strategy: "input" },
} satisfies SchemaRegistries;
