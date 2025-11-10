import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { Skeleton } from "@/components/ui/skeleton";
import { useDebounce } from "@/hooks/use-debounce";
import { orpcQuery } from "@/lib/orpc";
import { DefaultPagination } from "../default-pagination";
import type { TableProps } from "../type";
import { MERCHANT_MENU_COLUMNS } from "./columns";

interface Props extends TableProps {
	merchantId: string;
}

export const MerchantMenuTable = ({ merchantId, search, to }: Props) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const menus = useQuery(
		orpcQuery.merchant.menu.list.queryOptions({
			input: {
				params: { merchantId },
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
		() => menus.data?.body.totalPages,
		[menus.data?.body.totalPages],
	);

	return (
		<DataTable
			columns={MERCHANT_MENU_COLUMNS}
			data={menus.data?.body.data ?? []}
			totalPages={menus.data?.body.totalPages}
			isPending={menus.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKeys={m.name().toLowerCase()}
			filterValue={filter}
			onFilterChange={setFilter}
		>
			{menus.isPending ? (
				<div className="flex items-center justify-end space-x-2">
					<Skeleton className="h-8 w-9.5" />
					<Skeleton className="h-8 w-9.5" />
					<Skeleton className="h-5 w-19" />
					<Skeleton className="h-8 w-9.5" />
					<Skeleton className="h-8 w-9.5" />
				</div>
			) : (
				<DefaultPagination
					search={search}
					to={to}
					composeSearch={composeSearch}
					totalPages={totalPages}
				/>
			)}
		</DataTable>
	);
};
