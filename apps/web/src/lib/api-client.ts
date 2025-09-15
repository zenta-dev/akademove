import { client } from "@/api/client.gen";

export async function setupApiClient() {
	if (typeof window !== "undefined") {
		client.setConfig({
			baseUrl: import.meta.env.VITE_SERVER_URL,
			auth: async () => {
				return `Bearer ${localStorage.getItem("bearer")}`;
			},
		});
	} else {
		const { getHeaders } = await import("@tanstack/react-start/server");
		client.setConfig({
			baseUrl: import.meta.env.VITE_SERVER_URL,
			headers: getHeaders(),
		});
	}
}
