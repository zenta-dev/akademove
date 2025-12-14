import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { DefaultPagination } from "@/components/tables/default-pagination";
import { FilterActions, SingleSelectFilter } from "@/components/tables/filters";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import type { TableProps } from "../type";
import { createEmergencyContactColumns } from "./columns";

type EmergencyContactSearchParams = TableProps["search"] & {
	isActive?: string;
};

interface Props extends Omit<TableProps, "search"> {
	search: EmergencyContactSearchParams;
	to: FileRouteTypes["to"];
}

export const EmergencyContactTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [isActive, setIsActive] = useState<string | undefined>(search.isActive);

	const contacts = useQuery(
		orpcQuery.emergencyContact.list.queryOptions({
			input: {
				query: {
					limit: search.limit,
					page: search.page,
					mode: search.mode,
					order: search.order,
					cursor: search.cursor,
					direction: search.direction,
					sortBy: search.sortBy,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					isActive:
						isActive === "true"
							? true
							: isActive === "false"
								? false
								: undefined,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		name: true,
		phone: true,
		description: !isMobile,
		priority: !isMobile,
		isActive: true,
		createdAt: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				description: false,
				priority: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				description: true,
				priority: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

	const handleApplyFilters = useCallback(() => {
		navigate({
			to,
			search: {
				...search,
				page: 1,
				query: debouncedFilter,
				isActive,
			},
		});
	}, [navigate, to, search, debouncedFilter, isActive]);

	const handleClearFilters = useCallback(() => {
		setIsActive(undefined);
		setFilter(undefined);
		navigate({
			to,
			search: {
				page: 1,
				limit: search.limit,
				mode: search.mode,
				order: search.order,
			},
		});
	}, [navigate, to, search.limit, search.mode, search.order]);

	const composeSearch = useCallback(
		(page: number): EmergencyContactSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			isActive,
		}),
		[search, debouncedFilter, isActive],
	);

	const totalPages = useMemo(
		() => contacts.data?.body.totalPages,
		[contacts.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(isActive);

	const activeOptions = [
		{ value: "true", label: "Active" },
		{ value: "false", label: "Inactive" },
	];

	const CONTACT_COLUMNS = useMemo(() => createEmergencyContactColumns(), []);

	return (
		<>
			<div className="space-y-4 p-4">
				<div className="flex flex-wrap gap-2">
					<SingleSelectFilter
						options={activeOptions}
						value={isActive}
						onValueChange={setIsActive}
						placeholder="Status"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={hasActiveFilters}
					/>
				</div>
			</div>

			<DataTable
				columns={CONTACT_COLUMNS}
				data={contacts.data?.body.data ?? []}
				isPending={contacts.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name"
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
		</>
	);
};
