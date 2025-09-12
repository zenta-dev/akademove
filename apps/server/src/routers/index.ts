import { Hono } from "hono";
import { describeResponse } from "hono-openapi";
import type { HonoContext } from "@/lib/context";
import { OAPISpecs } from "./oapi";

export const router = new Hono<HonoContext>();

router.get(
	"/health",
	OAPISpecs.index.route,
	describeResponse(async (c) => {
		return c.json({ success: true, message: "Server is running" }, 200);
	}, OAPISpecs.index.responses),
);
