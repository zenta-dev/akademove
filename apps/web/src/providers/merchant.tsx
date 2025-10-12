import type { Merchant } from "@repo/schema/merchant";
import { useQuery } from "@tanstack/react-query";
import { createContext, type ReactNode, useContext, useMemo } from "react";
import { orpcQuery } from "@/lib/orpc";

interface MyMerchantContextValue {
	value: Merchant | undefined;
	isLoading: boolean;
	isError: boolean;
	error: Error | null;
}

const MyMerchantContext = createContext<MyMerchantContextValue | null>(null);

export function useMyMerchant() {
	const context = useContext(MyMerchantContext);

	if (!context) {
		throw new Error("useMyMerchant must be used within a MyMerchantProvider");
	}

	return context;
}

interface MyMerchantProviderProps {
	children: ReactNode;
}

export function MyMerchantProvider({ children }: MyMerchantProviderProps) {
	const { data, isLoading, isError, error } = useQuery(
		orpcQuery.merchant.getMine.queryOptions(),
	);

	const value = useMemo<MyMerchantContextValue>(
		() => ({
			value: data?.body.data,
			isLoading,
			isError,
			error,
		}),
		[data?.body.data, isLoading, isError, error],
	);

	return (
		<MyMerchantContext.Provider value={value}>
			{children}
		</MyMerchantContext.Provider>
	);
}
