import { createRouter as createTanStackRouter } from "@tanstack/react-router";
import "./index.css";
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "./lib/client/orpc";
import { routeTree } from "./routeTree.gen";

export const router = createTanStackRouter({
	routeTree,
	defaultPreload: "intent",
	scrollRestoration: true,
	defaultPreloadStaleTime: 0,
	context: { locale: "en", queryClient },
	defaultNotFoundComponent: () => <div>Not Found</div>,
	Wrap: ({ children }) => (
		<QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
	),
});

declare module "@tanstack/react-router" {
	interface Register {
		router: typeof router;
	}
}
