import { QueryCache, QueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { createClient } from "../../../server/src/client";

export const client = createClient(import.meta.env.VITE_SERVER_URL, {
	init: { credentials: "include" },
});

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
