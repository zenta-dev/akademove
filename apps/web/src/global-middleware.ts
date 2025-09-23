import { registerGlobalMiddleware } from "@tanstack/react-start";
import { localeMiddleware } from "./utils/i18n/locale-middleware";

registerGlobalMiddleware({
	middleware: [localeMiddleware],
});
