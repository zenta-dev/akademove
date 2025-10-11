import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { orpcQuery } from "@/lib/orpc";
import { COUPON_COLUMNS } from "./columns";

export const CouponTable = () => {
	const coupons = useQuery(
		orpcQuery.coupon.list.queryOptions({ input: { query: {} } }),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	return (
		<DataTable
			columns={COUPON_COLUMNS}
			data={coupons.data?.body.data ?? []}
			isPending={coupons.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
		/>
	);
};
