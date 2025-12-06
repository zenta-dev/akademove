import type { Driver } from "@repo/schema/driver";
import { useQuery } from "@tanstack/react-query";
import { createContext, type ReactNode, useContext, useMemo } from "react";
import { orpcQuery } from "@/lib/orpc";

interface MyDriverContextValue {
	value: Driver | undefined;
	isLoading: boolean;
	isError: boolean;
	error: Error | null;
}

const MyDriverContext = createContext<MyDriverContextValue | null>(null);

export function useMyDriver() {
	const context = useContext(MyDriverContext);

	if (!context) {
		throw new Error("useMyDriver must be used within a MyDriverProvider");
	}

	return context;
}

interface MyDriverProviderProps {
	children: ReactNode;
}

export function MyDriverProvider({ children }: MyDriverProviderProps) {
	const { data, isLoading, isError, error } = useQuery(
		orpcQuery.driver.getMine.queryOptions(),
	);

	const value = useMemo<MyDriverContextValue>(
		() => ({
			value: data?.body.data,
			isLoading,
			isError,
			error,
		}),
		[data?.body.data, isLoading, isError, error],
	);

	return (
		<MyDriverContext.Provider value={value}>
			{children}
		</MyDriverContext.Provider>
	);
}
