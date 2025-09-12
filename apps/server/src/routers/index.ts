import { describeResponse } from "hono-openapi";
import { createHono } from "@/lib/hono";
import { OAPISpecs } from "./oapi";

export const router = createHono();

router.get(
	"/health",
	OAPISpecs.index.route,
	describeResponse(async (c) => {
		return c.json({ success: true, message: "Server is running" }, 200);
	}, OAPISpecs.index.responses),
);
