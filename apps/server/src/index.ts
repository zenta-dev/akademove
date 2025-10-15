import "./polyfill";

import { setupHonoRouter } from "@/core/router/hono";
import { setupOrpcRouter } from "./core/router/orpc";

const app = setupHonoRouter();
setupOrpcRouter(app);

export default app;
