import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { orpcQuery } from "@/lib/client/orpc";
import { DataTable } from "../data-table";
import { ORDER_COLUMNS } from "./columns";

export const OrderTable = () => {
	const orders = useQuery(
		orpcQuery.order.list.queryOptions({ input: { query: {} } }),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	return (
		<DataTable
			columns={ORDER_COLUMNS}
			data={orders.data?.body.data ?? []}
			isPending={orders.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
		/>
	);
};
