import type { QueryClient } from "@tanstack/react-query";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";
import {
	createRootRouteWithContext,
	HeadContent,
	Outlet,
	Scripts,
} from "@tanstack/react-router";
import { TanStackRouterDevtools } from "@tanstack/react-router-devtools";
import { Toaster } from "@/components/ui/sonner";
import { APP_NAME } from "@/lib/constants";
import appCss from "../index.css?url";

export type RouterAppContext = {
	locale: string;
	queryClient: QueryClient;
};

export const Route = createRootRouteWithContext<RouterAppContext>()({
	head: () => ({
		meta: [
			{
				charSet: "utf-8",
			},
			{
				name: "viewport",
				content: "width=device-width, initial-scale=1",
			},
			{
				title: APP_NAME,
			},
		],
		links: [
			{
				rel: "stylesheet",
				href: appCss,
			},
		],
	}),
	component: RootDocument,
});

function RootDocument() {
	return (
		<html lang="en" className="light">
			<head>
				<HeadContent />
			</head>
			<body className="h-svh w-svw">
				<div className="grid h-svh grid-rows-[auto_1fr] bg-muted/50 dark:bg-muted/10">
					<Outlet />
				</div>
				<Toaster richColors />
				<TanStackRouterDevtools position="bottom-left" />
				<ReactQueryDevtools />
				<Scripts />
			</body>
		</html>
	);
}
