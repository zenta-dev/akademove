import { createAuthClient } from "better-auth/react";

export const authClient = createAuthClient({
	baseURL: import.meta.env.VITE_SERVER_URL,
	basePath: "/auth",
	fetchOptions: {
		onSuccess: ({ response }) => {
			const jwt = response.headers.get("set-auth-jwt");
			if (jwt) localStorage.setItem("bearer", jwt);
		},
	},
});
