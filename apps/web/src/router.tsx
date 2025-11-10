import { createRouter as createTanStackRouter } from "@tanstack/react-router";
import "./index.css";
import { deLocalizeUrl, localizeUrl } from "@repo/i18n";
import { QueryProvider } from "./components/providers/query";
import { queryClient } from "./lib/orpc";
import { routeTree } from "./routeTree.gen";

export const getRouter = () =>
	createTanStackRouter({
		routeTree,
		defaultPreload: "intent",
		scrollRestoration: true,
		defaultPreloadStaleTime: 0,
		context: { queryClient },
		defaultNotFoundComponent: () => <div>Not Found</div>,
		Wrap: ({ children }) => <QueryProvider>{children}</QueryProvider>,
		rewrite: {
			input: ({ url }) => deLocalizeUrl(url),
			output: ({ url }) => localizeUrl(url),
		},
		trailingSlash: "never",
	});

declare module "@tanstack/react-router" {
	interface Register {
		router: ReturnType<typeof getRouter>;
	}
}
