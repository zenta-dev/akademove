import * as z from "zod";

export const UpdatePricingSchema = z.object({
	price_per_km: z.number(),
	commission: z.number(),
});

export type UpdatePricing = z.infer<typeof UpdatePricingSchema>;
