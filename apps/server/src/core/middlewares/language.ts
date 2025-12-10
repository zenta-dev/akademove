import { AsyncLocalStorage } from "node:async_hooks";
import {
	type Locale,
	locales,
	overwriteServerAsyncLocalStorage,
} from "@repo/i18n";
import { createMiddleware } from "hono/factory";
import { logger } from "@/utils/logger";
import type { HonoContext } from "../interface";

export const localeMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		const asyncStorage = new AsyncLocalStorage<{
			locale?: Locale;
			origin?: string;
			messageCalls?: Set<string>;
		}>();

		overwriteServerAsyncLocalStorage({
			getStore: asyncStorage.getStore.bind(asyncStorage),
			run: asyncStorage.run.bind(asyncStorage),
		});

		const acceptLanguage = c.req.header("Accept-Language");

		if (acceptLanguage) {
			const locale = locales.find((l) => acceptLanguage.includes(l));
			c.set("locale", locale ?? "en");
			return asyncStorage.run(
				{ locale: locale ?? "en", messageCalls: new Set() },
				() => next(),
			);
		}

		return next();
	},
);
