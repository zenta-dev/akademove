import { setupOrpcRouter } from "./core/router/orpc";
import "./polyfill";
import { setupHonoRouter } from "@/core/router/hono";

const app = setupHonoRouter();
setupOrpcRouter(app);

export default app;
