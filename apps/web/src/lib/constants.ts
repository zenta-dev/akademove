import { m } from "@repo/i18n";

export const APP_NAME = "AkadeMove";

export const ROUTE_TITLES = Object.freeze({
	ADMINISTRATOR: `${APP_NAME} ${m.administrator()}`,
	OPERATOR: `${APP_NAME} ${m.operator()}`,
	MERCHANT: `${APP_NAME} ${m.merchant()}`,
} as const);

export const SUB_ROUTE_TITLES = Object.freeze({
	ADMIN: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		ANALYTICS: `${m.analytics()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		CONFIGURATIONS: `${m.configurations()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		DRIVERS: `${m.drivers()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		MERCHANTS: `${m.merchants()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		ORDERS: `${m.orders()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		USERS: `${m.users()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
	} as const,
} as const);
