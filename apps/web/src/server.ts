import { overwriteGetLocale } from "@repo/i18n/paraglide/runtime";
import { paraglideMiddleware } from "@repo/i18n/paraglide/server";
import {
	createStartHandler,
	defaultStreamHandler,
	getWebRequest,
} from "@tanstack/react-start/server";
import { router } from "./router";

import "./global-middleware";

export default createStartHandler({
	createRouter: () => router,
})((event) =>
	paraglideMiddleware(getWebRequest(), ({ locale }) => {
		overwriteGetLocale(() => locale);
		return defaultStreamHandler(event);
	}),
);
