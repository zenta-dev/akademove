import { QueryCache, QueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { client } from "@/api/client.gen";

export function setupApiClient() {
	if (typeof window !== "undefined") {
		client.setConfig({
			baseUrl: import.meta.env.VITE_SERVER_URL,
			auth: () => {
				return (
					localStorage.getItem("bearer_token") ||
					localStorage.getItem("jwt") ||
					""
				);
			},
		});
	} else {
		import("@tanstack/react-start/server").then(({ getHeaders }) => {
			client.setConfig({
				baseUrl: import.meta.env.VITE_SERVER_URL,
				headers: getHeaders(),
			});
		});
	}
	return client;
}

export const queryClient = new QueryClient({
	queryCache: new QueryCache({
		onError: (error) => {
			toast.error(`Error: ${error.message}`, {
				action: {
					label: "retry",
					onClick: () => {
						queryClient.invalidateQueries();
					},
				},
			});
		},
	}),
});
