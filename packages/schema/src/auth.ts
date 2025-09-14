import * as z from "zod";
import { DateSchema } from "./common.ts";

export const UserSchema = z
	.object({
		id: z.string(),
		name: z.string(),
		email: z.email(),
		emailVerified: z.boolean().default(false),
		image: z.url().optional(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "User",
		ref: "User",
	});

export const SessionSchema = z
	.object({
		id: z.string(),
		expiresAt: DateSchema,
		token: z.string(),
		ipAddress: z.string().optional(),
		userAgent: z.string().optional(),
		userId: z.string(),
		createdAt: DateSchema,
		updatedAt: DateSchema,
	})
	.meta({
		title: "Session",
		ref: "Session",
	});

export type User = z.infer<typeof UserSchema>;
export type Session = z.infer<typeof SessionSchema>;
