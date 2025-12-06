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
import { CONTACT_COLUMNS } from "./columns";

type ContactSearchParams = TableProps["search"] & {
	statuses?: string[];
	priority?: string;
	dateRange?: DateRange;
};

interface Props extends Omit<TableProps, "search"> {
	search: ContactSearchParams;
	to: FileRouteTypes["to"];
	status?: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
}

export const ContactTable = ({ search, to, status }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [statuses, setStatuses] = useState<string[]>(
		status ? [status] : (search.statuses ?? []),
	);
	const [priority, setPriority] = useState<string | undefined>(search.priority);
	const [dateRange, setDateRange] = useState<DateRange | undefined>(
		search.dateRange,
	);

	const contacts = useQuery(
		orpcQuery.contact.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					statuses: statuses.length > 0 ? statuses : undefined,
					priority: priority || undefined,
					startDate: dateRange?.from,
					endDate: dateRange?.to,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		id: !isMobile,
		name: true,
		email: !isMobile,
		subject: !isMobile,
		status: true,
		priority: true,
		createdAt: !isMobile,
		respondedAt: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				email: false,
				subject: false,
				createdAt: false,
				respondedAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				email: true,
				subject: true,
				createdAt: true,
				respondedAt: true,
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
				priority,
				dateRange,
			},
		});
	}, [navigate, to, search, debouncedFilter, statuses, priority, dateRange]);

	const handleClearFilters = useCallback(() => {
		setStatuses([]);
		setPriority(undefined);
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
		(page: number): ContactSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			statuses: statuses.length > 0 ? statuses : undefined,
			priority,
			dateRange,
		}),
		[search, debouncedFilter, statuses, priority, dateRange],
	);

	const totalPages = useMemo(
		() => contacts.data?.body.data.pagination?.totalPages,
		[contacts.data?.body.data.pagination?.totalPages],
	);

	const hasActiveFilters = Boolean(
		statuses.length > 0 || priority || dateRange,
	);

	const statusOptions = [
		{ value: "PENDING", label: "Pending" },
		{ value: "REVIEWING", label: "Reviewing" },
		{ value: "RESOLVED", label: "Resolved" },
		{ value: "CLOSED", label: "Closed" },
	];

	const priorityOptions = [
		{ value: "LOW", label: "Low" },
		{ value: "MEDIUM", label: "Medium" },
		{ value: "HIGH", label: "High" },
		{ value: "URGENT", label: "Urgent" },
	];

	return (
		<>
			<div className="space-y-4 p-4">
				<div className="flex flex-wrap gap-2">
					<MultiSelectFilter
						options={statusOptions}
						selectedValues={statuses}
						onSelectionChange={setStatuses}
						placeholder="Status"
						variant="compact"
					/>

					<SingleSelectFilter
						options={priorityOptions}
						value={priority}
						onValueChange={setPriority}
						placeholder="Priority"
					/>

					<DateRangePicker
						value={dateRange}
						onChange={setDateRange}
						placeholder="Contact date range"
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
				data={contacts.data?.body.data.rows ?? []}
				isPending={contacts.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name,email,subject"
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
