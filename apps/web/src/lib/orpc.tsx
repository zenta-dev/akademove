import { type ClientContext, createORPCClient, onError } from "@orpc/client";
import { RPCLink } from "@orpc/client/fetch";
import { BatchLinkPlugin } from "@orpc/client/plugins";
import { createTanstackQueryUtils } from "@orpc/tanstack-query";
import { QueryCache, QueryClient } from "@tanstack/react-query";
import { RefreshCwIcon } from "lucide-react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import { log } from "@/utils/logger";
import type { ServerSpecClient } from "../../../server/src/features/index";

export const queryClient = new QueryClient({
	defaultOptions: { queries: { staleTime: 60 * 1000 } },
	queryCache: new QueryCache({
		onError: (error) => {
			if (error.message.toLowerCase().includes("session")) return;
			if (error.message.toLowerCase().includes("token")) return;
			toast.error(`Error: ${error.message}`, {
				action: {
					label: (
						<Button variant="ghost" size="icon">
							<RefreshCwIcon />
						</Button>
					),
					onClick: () => {
						queryClient.invalidateQueries();
					},
				},
			});
		},
	}),
});

interface MyContext extends ClientContext {
	headers?: Headers;
}

export const link = new RPCLink<MyContext>({
	url: `${import.meta.env.VITE_SERVER_URL}/rpc`,
	plugins: [
		new BatchLinkPlugin({
			groups: [
				{
					condition: () => true,
					context: {},
				},
			],
		}),
	],
	method: ({ context }, path) => {
		if (path.includes("hasPermission")) return "POST";
		if (context?.cache) {
			return "GET";
		}
		if (typeof window === "undefined") {
			return "GET";
		}
		if (path.at(-1)?.match(/^(?:get|find|list|search)(?:[A-Z].*)?$/)) {
			return "GET";
		}
		if (path.at(-1)?.toLowerCase().includes("get")) {
			return "GET";
		}
		return "POST";
	},
	fetch(request, options, { context }) {
		return fetch(request, {
			...options,
			credentials: "include",
			cache: context?.cache,
		});
	},
	headers(options) {
		if (options.context.headers) return options.context.headers;
		return new Headers();
	},
	adapterInterceptors: [
		async (c) => {
			c.request.headers.set("X-Client-Agent", "web");
			return await c.next();
		},
		onError((error) => {
			log.error({ error }, "RPC ERROR");
		}),
	],
});
export const orpcClient: ServerSpecClient = createORPCClient(link);
export const orpcQuery = createTanstackQueryUtils(orpcClient);
