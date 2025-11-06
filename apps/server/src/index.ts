import "./polyfill";

import { setupHonoRouter } from "@/core/router/hono";
import { setupOrpcRouter } from "./core/router/orpc";
import { setupWebsocketRouter } from "./features/ws";

const app = setupHonoRouter();
setupOrpcRouter(app);
setupWebsocketRouter(app);

export default app;
export * from "./features/ws";
