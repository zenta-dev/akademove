import { oc } from "@orpc/contract";
import {
	EmergencySchema,
	InsertEmergencySchema,
	UpdateEmergencySchema,
} from "@repo/schema/emergency";
import * as z from "zod";
import { createSuccesSchema, FEATURE_TAGS } from "@/core/constants";

export const EmergencySpec = {
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
			createSuccesSchema(EmergencySchema, "Emergency triggered successfully"),
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
