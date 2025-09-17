import * as z from "zod";
import { DateSchema } from "./common.ts";

export const UserSchema = z
	.object({
		id: z.string(),
		name: z.string(),
		email: z.email(),
		emailVerified: z.boolean().default(false),
		image: z.url().nullable(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "User",
		ref: "User",
	});

export const InsertUserSchema = UserSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});

export const UpdateUserSchema = UserSchema.omit({
	id: true,
	createdAt: true,
	updatedAt: true,
});

export type User = z.infer<typeof UserSchema>;
export type InsertUser = z.infer<typeof InsertUserSchema>;
export type UpdateUser = z.infer<typeof UpdateUserSchema>;
