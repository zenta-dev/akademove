import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { orpcQuery } from "@/lib/client/orpc";
import { DataTable } from "../data-table";
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
