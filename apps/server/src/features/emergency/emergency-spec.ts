import { oc } from "@orpc/contract";
import {
	EmergencySchema,
	InsertEmergencySchema,
	LogEmergencySchema,
	UpdateEmergencySchema,
} from "@repo/schema/emergency";
import { EmergencyWithContactSchema } from "@repo/schema/emergency-contact";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const EmergencySpec = {
	// Simplified log endpoint - only logs emergency event for WhatsApp redirect
	log: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "POST",
			path: "/log",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: LogEmergencySchema }))
		.output(
			createSuccesSchema(
				z.object({ logged: z.boolean() }),
				"Emergency event logged successfully",
			),
		),

	trigger: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "POST",
			path: "/",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ body: InsertEmergencySchema }))
		.output(
			createSuccesSchema(
				EmergencyWithContactSchema,
				"Emergency triggered successfully",
			),
		),
	listByOrder: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "GET",
			path: "/order/{orderId}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ orderId: z.uuid() }) }))
		.output(
			createSuccesSchema(
				z.array(EmergencySchema),
				"Successfully retrieved emergencies for order",
			),
		),
	get: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "GET",
			path: "/{id}",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(z.object({ params: z.object({ id: z.uuid() }) }))
		.output(
			createSuccesSchema(
				EmergencySchema,
				"Successfully retrieved emergency data",
			),
		),
	updateStatus: oc
		.route({
			tags: [FEATURE_TAGS.EMERGENCY],
			method: "PATCH",
			path: "/{id}/status",
			inputStructure: "detailed",
			outputStructure: "detailed",
		})
		.input(
			z.object({
				params: z.object({ id: z.uuid() }),
				body: UpdateEmergencySchema.pick({
					status: true,
					resolution: true,
					respondedById: true,
				}),
			}),
		)
		.output(
			createSuccesSchema(
				EmergencySchema,
				"Emergency status updated successfully",
			),
		),
};
