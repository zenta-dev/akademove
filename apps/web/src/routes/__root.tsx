import type { QueryClient } from "@tanstack/react-query";
import { ReactQueryDevtools } from "@tanstack/react-query-devtools";
import {
	createRootRouteWithContext,
	HeadContent,
	Outlet,
	Scripts,
	useRouterState,
} from "@tanstack/react-router";
import { TanStackRouterDevtools } from "@tanstack/router-devtools";
import { ErrorBoundary } from "@/components/error-boundary";
import { ThemeProvider } from "@/components/providers/theme";
import { Toaster } from "@/components/ui/sonner";
import { getLocaleIsomorphic, getThemeCookie } from "@/lib/actions";
import { APP_NAME } from "@/lib/constants";
import { cn } from "@/utils/cn";
import appCss from "../index.css?url";

export type RouterAppContext = {
	queryClient: QueryClient;
};

export const Route = createRootRouteWithContext<RouterAppContext>()({
	loader: async () => {
		const theme = await getThemeCookie();
		return { theme };
	},
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
			{
				rel: "apple-touch-icon",
				sizes: "180x180",
				href: "/apple-touch-icon.png",
			},
			{
				rel: "icon",
				href: "/favicon.ico",
			},
			{
				rel: "icon",
				type: "image/png",
				sizes: "32x32",
				href: "/favicon-32x32.png",
			},
			{
				rel: "icon",
				type: "image/png",
				sizes: "16x16",
				href: "/favicon-16x16.png",
			},
			{
				rel: "manifest",
				href: "/site.webmanifest",
			},
		],
	}),
	component: RootDocument,
});

function RootDocument() {
	const routerState = useRouterState();
	const { theme } = Route.useLoaderData();

	return (
		<html
			lang={getLocaleIsomorphic()}
			className={theme}
			suppressHydrationWarning
		>
			<head>
				<HeadContent />
			</head>
			<body
				className={
					cn("h-screen", routerState.location.pathname.includes("dash"))
						? "w-full"
						: "w-[99.2vw]"
				}
			>
				<ErrorBoundary>
					<ThemeProvider
						attribute="class"
						defaultTheme="system"
						enableSystem
						disableTransitionOnChange
					>
						<Outlet />
						<Toaster richColors />
					</ThemeProvider>
					<TanStackRouterDevtools position="bottom-left" />
					<ReactQueryDevtools />
					<Scripts />
				</ErrorBoundary>
			</body>
		</html>
	);
}
