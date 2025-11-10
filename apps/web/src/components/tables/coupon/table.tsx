import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useDebounce } from "@/hooks/use-debounce";
import { orpcQuery } from "@/lib/orpc";
import { DefaultPagination } from "../default-pagination";
import type { TableProps } from "../type";
import { COUPON_COLUMNS } from "./columns";

export const CouponTable = ({ search, to }: TableProps) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const coupons = useQuery(
		orpcQuery.coupon.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
				},
			},
		}),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	const composeSearch = useCallback(
		(page: number) => ({ ...search, page, query: debouncedFilter }),
		[search, debouncedFilter],
	);
	const totalPages = useMemo(
		() => coupons.data?.body.totalPages,
		[coupons.data?.body.totalPages],
	);

	return (
		<DataTable
			columns={COUPON_COLUMNS}
			data={coupons.data?.body.data ?? []}
			isPending={coupons.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKeys={m.name().toLowerCase()}
			filterValue={filter}
			onFilterChange={setFilter}
		>
			<DefaultPagination
				search={search}
				to={to}
				composeSearch={composeSearch}
				totalPages={totalPages}
			/>
		</DataTable>
	);
};
