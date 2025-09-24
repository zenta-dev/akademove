import { createMiddleware } from "@tanstack/react-start";
import {
  baseLocale,
  isLocale,
  type Locale,
  overwriteGetLocale,
  strategy as strategies,
} from "@repo/i18n/paraglide/runtime";
import { resolveLocale } from "./resolve-locale";

export const localeMiddleware = createMiddleware({ type: "function" })
  .client(async ({ router, next }) => {
    const standardLocale = await resolveLocale();
    return next({
      sendContext: {
        locale:
          extractLocaleFromStrategies(router.latestLocation.href) ??
          standardLocale,
      },
    });
  })
  .server(async ({ context: { locale }, next }) => {
    const {AsyncLocalStorage}=await import('node:async_hooks');
    const storage = new AsyncLocalStorage<Locale>();
    overwriteGetLocale(() => storage.getStore() ?? baseLocale);

    return storage.run(locale, next);
  });

function extractLocaleFromStrategies(url: string): Locale | undefined {
  for (const strategy of strategies) {
    if (strategy === "url") {
      const locale = extractLocaleFromUrl(url);
      if (locale) return locale;
    }
  }
}

function extractLocaleFromUrl(url: string): Locale | undefined {
  const urlObj = new URL(url, "http://dummy.com");
  const pathSegments = urlObj.pathname.split("/").filter(Boolean);
  if (pathSegments.length > 0) {
    const potentialLocale = pathSegments[0];
    if (isLocale(potentialLocale)) {
      return potentialLocale;
    }
  }
}