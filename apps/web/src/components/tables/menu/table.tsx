import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { orpcQuery } from "@/lib/client/orpc";
import { DataTable } from "../data-table";
import { MERCHANT_MENU_COLUMNS } from "./columns";

export const MerchantMenuTable = ({ merchantId }: { merchantId: string }) => {
	const menus = useQuery(
		orpcQuery.merchant.menu.list.queryOptions({
			input: { params: { merchantId }, query: {} },
		}),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	return (
		<DataTable
			columns={MERCHANT_MENU_COLUMNS}
			data={menus.data?.body.data ?? []}
			isPending={menus.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKey={"name"}
		/>
	);
};
