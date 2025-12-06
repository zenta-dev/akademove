import { CONSTANTS } from "@repo/schema/constants";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import type { DateRange } from "react-day-picker";
import { DataTable } from "@/components/tables/data-table";
import { DefaultPagination } from "@/components/tables/default-pagination";
import {
	DateRangePicker,
	FilterActions,
	MultiSelectFilter,
	SingleSelectFilter,
} from "@/components/tables/filters";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import type { TableProps } from "../type";
import { ORDER_COLUMNS } from "./columns";

type OrderSearchParams = TableProps["search"] & {
	statuses?: string[];
	type?: string;
	dateRange?: DateRange;
};

interface Props extends Omit<TableProps, "search"> {
	search: OrderSearchParams;
	to: FileRouteTypes["to"];
}

export const OrderTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [statuses, setStatuses] = useState<string[]>(search.statuses ?? []);
	const [type, setType] = useState<string | undefined>(search.type);
	const [dateRange, setDateRange] = useState<DateRange | undefined>(
		search.dateRange,
	);

	const orders = useQuery(
		orpcQuery.order.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					statuses: statuses.length > 0 ? statuses : undefined,
					type: type || undefined,
					startDate: dateRange?.from,
					endDate: dateRange?.to,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		id: !isMobile,
		userName: true,
		driverName: true,
		merchantName: true,
		type: true,
		status: true,
		totalPrice: !isMobile,
		requestedAt: true,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				totalPrice: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				totalPrice: true,
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
				statuses: statuses.length > 0 ? statuses : undefined,
				type,
				dateRange,
			},
		});
	}, [navigate, to, search, debouncedFilter, statuses, type, dateRange]);

	const handleClearFilters = useCallback(() => {
		setStatuses([]);
		setType(undefined);
		setDateRange(undefined);
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
		(page: number): OrderSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			statuses: statuses.length > 0 ? statuses : undefined,
			type,
			dateRange,
		}),
		[search, debouncedFilter, statuses, type, dateRange],
	);

	const totalPages = useMemo(
		() => orders.data?.body.totalPages,
		[orders.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(statuses.length > 0 || type || dateRange);

	const statusOptions = CONSTANTS.ORDER_STATUSES.map((status) => ({
		value: status,
		label: status.replace(/_/g, " "),
	}));

	const typeOptions = CONSTANTS.ORDER_TYPES.map((type) => ({
		value: type,
		label: type,
	}));

	return (
		<>
			<div className="space-y-4 p-4">
				<div className="flex flex-wrap gap-2">
					<MultiSelectFilter
						options={statusOptions}
						selectedValues={statuses}
						onSelectionChange={setStatuses}
						placeholder="Order Status"
						variant="compact"
					/>

					<SingleSelectFilter
						options={typeOptions}
						value={type}
						onValueChange={setType}
						placeholder="Order Type"
					/>

					<DateRangePicker
						value={dateRange}
						onChange={setDateRange}
						placeholder="Order date range"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={Boolean(hasActiveFilters)}
					/>
				</div>
			</div>

			<DataTable
				columns={ORDER_COLUMNS}
				data={orders.data?.body.data ?? []}
				isPending={orders.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="userName,driverName,merchantName"
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
