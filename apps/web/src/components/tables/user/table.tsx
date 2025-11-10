import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import { DefaultPagination } from "../default-pagination";
import type { TableProps } from "../type";
import { USER_COLUMNS } from "./columns";

interface Props extends TableProps {}

export const UserTable = ({ search, to }: Props) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const users = useQuery(
		orpcQuery.user.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
				},
			},
		}),
	);
	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		name: true,
		email: true,
		role: true,
		emailVerified: !isMobile,
		createdAt: !isMobile,
		actions: true,
	});

	const composeSearch = useCallback(
		(page: number) => ({ ...search, page, query: debouncedFilter }),
		[search, debouncedFilter],
	);
	const totalPages = useMemo(
		() => users.data?.body.totalPages,
		[users.data?.body.totalPages],
	);

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				emailVerified: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				emailVerified: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

	return (
		<DataTable
			columns={USER_COLUMNS}
			data={users.data?.body.data ?? []}
			isPending={users.isPending}
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
