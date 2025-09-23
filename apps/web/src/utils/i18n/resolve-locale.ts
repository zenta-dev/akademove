import { createIsomorphicFn } from "@tanstack/react-start";
import { getWebRequest } from "@tanstack/react-start/server";
import {
  baseLocale,
  getLocale,
 type Locale,
  extractLocaleFromRequest,
} from "@repo/i18n/paraglide/runtime";

import { paraglideMiddleware } from "@repo/i18n/paraglide/server";

export const resolveLocale = createIsomorphicFn()
  .client(getLocale)
  .server(() => {
    const request = getWebRequest();

    if (!request) {
      return baseLocale;
    }

    return new Promise<Locale>(async (resolve) => {
      await paraglideMiddleware(request, ({ locale }) => {
        resolve(locale);
      });

      resolve(extractLocaleFromRequest(request));
    });
  });