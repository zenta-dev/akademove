import * as z from "zod";

export const UserSchema = z.object({
	id: z.string(),
	name: z.string(),
	email: z.email(),
	emailVerified: z.boolean().default(false),
	image: z.url().optional(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export const SessionSchema = z.object({
	id: z.string(),
	expiresAt: z.date(),
	token: z.string(),
	ipAddress: z.string().optional(),
	userAgent: z.string().optional(),
	userId: z.string(),
	createdAt: z.date(),
	updatedAt: z.date(),
});

export type User = z.infer<typeof UserSchema>;
export type Session = z.infer<typeof SessionSchema>;
