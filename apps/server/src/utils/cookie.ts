import { setCookie } from "@orpc/server/helpers";
import { AUTH_CONSTANTS } from "@repo/schema/constants";
import { isDev } from ".";

const PREFIX = isDev ? "" : "__Secure-";
const SESSION_TOKEN = `${PREFIX}${AUTH_CONSTANTS.SESSION_TOKEN}`;
export const setAuthCookie = ({
	headers,
	token,
}: {
	headers: Headers;
	token: string;
}) => {
	setCookie(headers, SESSION_TOKEN, token, {
		secure: !isDev,
	});
};
