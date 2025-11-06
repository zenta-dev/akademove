import { createMiddleware } from "hono/factory";

export const honoWebsocketHeader = createMiddleware(async (c, next) => {
	const upgradeHeader = c.req.header("Upgrade");
	if (upgradeHeader !== "websocket") {
		return new Response("This route expected Upgrade: websocket", {
			status: 426,
		});
	}

	return await next();
});
