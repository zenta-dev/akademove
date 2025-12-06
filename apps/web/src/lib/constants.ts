import { m } from "@repo/i18n";

export const APP_NAME = "AkadeMove";

export const ROUTE_TITLES = Object.freeze({
	ADMINISTRATOR: `${APP_NAME} ${m.administrator()}`,
	OPERATOR: `${APP_NAME} ${m.operator()}`,
	MERCHANT: `${APP_NAME} ${m.merchant()}`,
	DRIVER: `${APP_NAME} ${m.driver()}`,
	USER: `${APP_NAME} ${m.user()}`,
} as const);

export const SUB_ROUTE_TITLES = Object.freeze({
	ADMIN: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		ANALYTICS: `${m.analytics()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		PRICING: `${m.pricing()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		DRIVERS: `${m.drivers()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		MERCHANTS: `${m.merchants()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		ORDERS: `${m.orders()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		USERS: `${m.users()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
		CONTACTS: `${m.contact_us()} - ${ROUTE_TITLES.ADMINISTRATOR}`,
	} as const,
	OPERATOR: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.OPERATOR}`,
		DRIVERS: `${m.drivers()} - ${ROUTE_TITLES.OPERATOR}`,
		MERCHANTS: `${m.merchants()} - ${ROUTE_TITLES.OPERATOR}`,
		ORDERS: `${m.orders()} - ${ROUTE_TITLES.OPERATOR}`,
		PRICING: `${m.pricing()} - ${ROUTE_TITLES.OPERATOR}`,
		COUPONS: `${m.coupons()} - ${ROUTE_TITLES.OPERATOR}`,
		REPORTS: `${m.reports()} - ${ROUTE_TITLES.OPERATOR}`,
		CONTACTS: `${m.contact_us()} - ${ROUTE_TITLES.OPERATOR}`,
		USERS: `${m.users()} - ${ROUTE_TITLES.OPERATOR}`,
	} as const,
	MERCHANT: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.MERCHANT}`,
		MENU: `${m.menu()} - ${ROUTE_TITLES.MERCHANT}`,
		ORDERS: `${m.orders()} - ${ROUTE_TITLES.MERCHANT}`,
		SALES: `${m.earnings()} - ${ROUTE_TITLES.MERCHANT}`,
		wallet: `${m.wallet()} - ${ROUTE_TITLES.MERCHANT}`,
		PROFILE: `${m.profile()} - ${ROUTE_TITLES.MERCHANT}`,
	} as const,
	DRIVER: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.DRIVER}`,
		QUIZ: `Quiz - ${ROUTE_TITLES.DRIVER}`,
		SCHEDULE: `${m.schedule()} - ${ROUTE_TITLES.DRIVER}`,
		ORDERS: `${m.orders()} - ${ROUTE_TITLES.DRIVER}`,
		EARNINGS: `${m.earnings()} - ${ROUTE_TITLES.DRIVER}`,
		RATINGS: `${m.ratings()} - ${ROUTE_TITLES.DRIVER}`,
		PROFILE: `${m.profile()} - ${ROUTE_TITLES.DRIVER}`,
	} as const,
	USER: {
		OVERVIEW: `${m.overview()} - ${ROUTE_TITLES.USER}`,
		BOOKINGS: `${m.bookings()} - ${ROUTE_TITLES.USER}`,
		HISTORY: `${m.history()} - ${ROUTE_TITLES.USER}`,
		wallet: `${m.wallet()} - ${ROUTE_TITLES.USER}`,
		PROFILE: `${m.profile()} - ${ROUTE_TITLES.USER}`,
	} as const,
} as const);
