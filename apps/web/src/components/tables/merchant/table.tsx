import { useQuery } from "@tanstack/react-query";
import { orpcQuery } from "@/lib/client/orpc";
import { DataTable } from "../data-table";
import { MERCHANT_COLUMNS } from "./columns";

export const MerchantTable = () => {
	const merchants = useQuery(
		orpcQuery.merchant.list.queryOptions({ input: { query: {} } }),
	);

	return (
		<DataTable
			columns={MERCHANT_COLUMNS}
			data={merchants.data?.body.data ?? []}
			isPending={merchants.isPending}
		/>
	);
};
