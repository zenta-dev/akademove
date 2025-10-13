import { Hono } from "hono";
import type { HonoContext } from "./interface";

export const createHono = () => new Hono<HonoContext>();
