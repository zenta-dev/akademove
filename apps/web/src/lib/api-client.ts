import { QueryCache, QueryClient } from "@tanstack/react-query";
import { toast } from "sonner";
import { getServerHeaders } from "@/lib/actions";
import { createClient } from "../../../server/src/client";

export const client = createClient(import.meta.env.VITE_SERVER_URL, {
	headers: async () => {
		const headers: Record<string, string> = {};
		if (typeof window !== "undefined") {
			const token = localStorage.getItem("jwt") || "";
			headers.Authorization = `Bearer ${token}`;
			return headers;
		} else {
			const serverHeaders = await getServerHeaders();
			for (const [k, v] of Object.entries(serverHeaders)) {
				if (v) headers[k] = v;
			}
			return headers;
		}
	},
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
