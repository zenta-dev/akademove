import { oc } from "@orpc/contract";
import {
	FraudEventListQuerySchema,
	FraudEventSchema,
	FraudStatsQuerySchema,
	FraudStatsSchema,
	ReviewFraudEventSchema,
	UserFraudProfileSchema,
} from "@repo/schema/fraud";
import * as z from "zod";
import { createSuccesSchema } from "@/core/constants";

// Add FRAUD to feature tags if not present
const FRAUD_TAG = "Fraud" as const;

export const FraudSpec = {
	// List fraud events
	listEvents: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/events",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: FraudEventListQuerySchema }))
		.output(
			createSuccesSchema(
				z.array(FraudEventSchema),
				"Successfully retrieved fraud events",
			),
		),

	// Get single fraud event
	getEvent: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/events/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				FraudEventSchema,
				"Successfully retrieved fraud event",
			),
		),

	// Review fraud event (update status)
	reviewEvent: oc
		.route({
			tags: [FRAUD_TAG],
			method: "POST",
			path: "/events/{id}/review",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: ReviewFraudEventSchema,
			}),
		)
		.output(
			createSuccesSchema(FraudEventSchema, "Fraud event reviewed successfully"),
		),

	// Get fraud statistics
	getStats: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/stats",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ query: FraudStatsQuerySchema.optional() }))
		.output(
			createSuccesSchema(
				FraudStatsSchema,
				"Successfully retrieved fraud statistics",
			),
		),

	// Get user fraud profile
	getUserProfile: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/users/{userId}/profile",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ userId: z.string() }) }))
		.output(
			createSuccesSchema(
				UserFraudProfileSchema.nullable(),
				"Successfully retrieved user fraud profile",
			),
		),

	// List high-risk users
	listHighRiskUsers: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/users/high-risk",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				query: z
					.object({
						page: z.coerce.number().int().min(1).optional(),
						limit: z.coerce.number().int().min(1).max(100).optional(),
					})
					.optional(),
			}),
		)
		.output(
			createSuccesSchema(
				z.array(UserFraudProfileSchema),
				"Successfully retrieved high-risk users",
			),
		),

	// Get fraud events for a specific user
	getUserEvents: oc
		.route({
			tags: [FRAUD_TAG],
			method: "GET",
			path: "/users/{userId}/events",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ userId: z.string() }),
				query: z
					.object({
						page: z.coerce.number().int().min(1).optional(),
						limit: z.coerce.number().int().min(1).max(100).optional(),
					})
					.optional(),
			}),
		)
		.output(
			createSuccesSchema(
				z.array(FraudEventSchema),
				"Successfully retrieved user fraud events",
			),
		),
};
