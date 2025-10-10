import { overwriteGetLocale } from "@repo/i18n/paraglide/runtime";
import { paraglideMiddleware } from "@repo/i18n/paraglide/server";
import {
	createStartHandler,
	defaultStreamHandler,
	defineHandlerCallback,
	getRequest,
} from "@tanstack/react-start/server";

const customHandler = defineHandlerCallback((ctx) => {
	return paraglideMiddleware(getRequest(), ({ locale }) => {
		overwriteGetLocale(() => locale);
		return defaultStreamHandler(ctx);
	});
});

const fetch = createStartHandler(customHandler);

export default {
	fetch,
};
