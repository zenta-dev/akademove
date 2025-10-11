import {
	overwriteGetLocale,
	overwriteGetUrlOrigin,
	paraglideMiddleware,
} from "@repo/i18n";
import { createMiddleware, createStart } from "@tanstack/react-start";

const localeMiddleware = createMiddleware().server(({ request, next }) => {
	paraglideMiddleware(request, ({ request, locale }) => {
		overwriteGetLocale(() => locale);
		overwriteGetUrlOrigin(() => new URL(request.url).origin);
	});
	return next();
});

export const startInstance = createStart(() => {
	return {
		requestMiddleware: [localeMiddleware],
	};
});
