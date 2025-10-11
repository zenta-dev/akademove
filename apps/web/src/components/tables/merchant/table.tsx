import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { orpcQuery } from "@/lib/orpc";
import { MERCHANT_COLUMNS } from "./columns";

export const MerchantTable = () => {
	const merchants = useQuery(
		orpcQuery.merchant.list.queryOptions({ input: { query: {} } }),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	return (
		<DataTable
			columns={MERCHANT_COLUMNS}
			data={merchants.data?.body.data ?? []}
			isPending={merchants.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
		/>
	);
};
