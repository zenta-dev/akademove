import { authPermission } from "@repo/shared";
import { adminClient, inferAdditionalFields } from "better-auth/client/plugins";
import { createAuthClient } from "better-auth/react";
import { reactStartCookies } from "better-auth/react-start";

export const authClient = createAuthClient({
	baseURL: import.meta.env.VITE_SERVER_URL,
	basePath: "/auth",
	plugins: [
		inferAdditionalFields({
			user: {
				role: {
					type: "string",
				},
			},
		}),
		adminClient(authPermission),
		reactStartCookies(),
	],
});
