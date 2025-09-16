import { type ClientRequestOptions, hc } from "hono/client";
import type { AppHandlerRoutes } from "./features/handler";

export const createClient = (url: string, opts?: ClientRequestOptions) =>
	hc<AppHandlerRoutes>(url, opts);
