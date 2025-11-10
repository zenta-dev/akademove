import { paraglideMiddleware } from "@repo/i18n";
import {
	createStartHandler,
	defaultRenderHandler,
} from "@tanstack/react-start/server";

const handler = {
	fetch: createStartHandler(defaultRenderHandler),
};

export default {
	fetch(req: Request): Promise<Response> {
		return paraglideMiddleware(req, ({ request }) => {
			return handler.fetch(request);
		});
	},
};
