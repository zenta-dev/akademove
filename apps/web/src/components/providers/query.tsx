import { QueryClientProvider } from "@tanstack/react-query";
import React from "react";
import { createQueryClient } from "@/lib/orpc";

export const QueryProvider = ({ children }: { children: React.ReactNode }) => {
	const [queryClient] = React.useState(createQueryClient);
	return (
		<QueryClientProvider client={queryClient}>{children}</QueryClientProvider>
	);
};
