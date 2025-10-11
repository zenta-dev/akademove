import {
	overwriteGetLocale,
	overwriteGetUrlOrigin,
	paraglideMiddleware,
} from "@repo/i18n";
import handler from "@tanstack/react-start/server-entry";

export default {
	fetch(req: Request): Promise<Response> {
		return paraglideMiddleware(req, ({ request, locale }) => {
			overwriteGetLocale(() => locale);
			overwriteGetUrlOrigin(() => new URL(request.url).origin);
			return handler.fetch(request);
		});
	},
};
