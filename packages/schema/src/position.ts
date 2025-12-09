import * as z from "zod";
import type { SchemaRegistries } from "./common.js";

export const LocationSchema = z.object({
	lat: z.coerce.number(),
	lng: z.coerce.number(),
});
export type Location = z.infer<typeof LocationSchema>;

export const CoordinateSchema = z.object({
	x: z.coerce
		.number()
		.min(-180, "Longitude must be >= -180")
		.max(180, "Longitude must be <= 180")
		.describe("Longitude (X-axis, East-West)"),
	y: z.coerce
		.number()
		.min(-90, "Latitude must be >= -90")
		.max(90, "Latitude must be <= 90")
		.describe("Latitude (Y-axis, North-South)"),
});
export type Coordinate = z.infer<typeof CoordinateSchema>;

// Coordinate with mock location metadata (for fraud detection)
export const CoordinateWithMetaSchema = CoordinateSchema.extend({
	isMockLocation: z
		.boolean()
		.optional()
		.describe("Whether the location is from a mock provider (Android only)"),
});
export type CoordinateWithMeta = z.infer<typeof CoordinateWithMetaSchema>;

export function toLocation(coord: Coordinate): Location {
	return { lat: coord.y, lng: coord.x };
}
export function toCoordinate(loc: Location): Coordinate {
	return { x: loc.lng, y: loc.lat };
}

export const PositionSchemaRegistries = {
	Location: { schema: LocationSchema, strategy: "output" },
	Coordinate: { schema: CoordinateSchema, strategy: "output" },
	CoordinateWithMeta: { schema: CoordinateWithMetaSchema, strategy: "input" },
} satisfies SchemaRegistries;
