import { CONSTANTS } from "@repo/schema/constants";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { DefaultPagination } from "@/components/tables/default-pagination";
import {
	FilterActions,
	MultiSelectFilter,
	SingleSelectFilter,
} from "@/components/tables/filters";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import type { TableProps } from "../type";
import { DRIVER_COLUMNS } from "./columns";

type DriverSearchParams = TableProps["search"] & {
	statuses?: string[];
	isOnline?: string;
	minRating?: number;
	maxRating?: number;
};

interface Props extends Omit<TableProps, "search"> {
	search: DriverSearchParams;
	to: FileRouteTypes["to"];
}

export const DriverTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [statuses, setStatuses] = useState<string[]>(search.statuses ?? []);
	const [isOnline, setIsOnline] = useState<string | undefined>(search.isOnline);
	const [minRating, setMinRating] = useState<number | undefined>(
		search.minRating,
	);
	const [maxRating, setMaxRating] = useState<number | undefined>(
		search.maxRating,
	);

	const drivers = useQuery(
		orpcQuery.driver.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					statuses: statuses.length > 0 ? statuses : undefined,
					isOnline:
						isOnline === "true"
							? true
							: isOnline === "false"
								? false
								: undefined,
					minRating,
					maxRating,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		id: !isMobile,
		name: true,
		email: !isMobile,
		phone: !isMobile,
		status: true,
		isOnline: true,
		rating: true,
		vehicleType: true,
		plateNumber: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				email: false,
				phone: false,
				plateNumber: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				email: true,
				phone: true,
				plateNumber: true,
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
				isOnline,
				minRating,
				maxRating,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		statuses,
		isOnline,
		minRating,
		maxRating,
	]);

	const handleClearFilters = useCallback(() => {
		setStatuses([]);
		setIsOnline(undefined);
		setMinRating(undefined);
		setMaxRating(undefined);
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
		(page: number): DriverSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			statuses: statuses.length > 0 ? statuses : undefined,
			isOnline,
			minRating,
			maxRating,
		}),
		[search, debouncedFilter, statuses, isOnline, minRating, maxRating],
	);

	const totalPages = useMemo(
		() => drivers.data?.body.totalPages,
		[drivers.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(
		statuses.length > 0 ||
			isOnline ||
			minRating !== undefined ||
			maxRating !== undefined,
	);

	const statusOptions = CONSTANTS.DRIVER_STATUSES.map((status) => ({
		value: status,
		label: status,
	}));

	const onlineOptions = [
		{ value: "true", label: "Online" },
		{ value: "false", label: "Offline" },
	];

	const ratingOptions = Array.from({ length: 5 }, (_, i) => i + 1).map(
		(rating) => ({
			value: rating.toString(),
			label: `${rating}+ Stars`,
		}),
	);

	return (
		<>
			<div className="space-y-4 p-4">
				<div className="flex flex-wrap gap-2">
					<MultiSelectFilter
						options={statusOptions}
						selectedValues={statuses}
						onSelectionChange={setStatuses}
						placeholder="Driver Status"
						variant="compact"
					/>

					<SingleSelectFilter
						options={onlineOptions}
						value={isOnline}
						onValueChange={setIsOnline}
						placeholder="Online Status"
					/>

					<SingleSelectFilter
						options={ratingOptions}
						value={minRating?.toString()}
						onValueChange={(value) =>
							setMinRating(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Min Rating"
					/>

					<SingleSelectFilter
						options={ratingOptions}
						value={maxRating?.toString()}
						onValueChange={(value) =>
							setMaxRating(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Max Rating"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={hasActiveFilters}
					/>
				</div>
			</div>

			<DataTable
				columns={DRIVER_COLUMNS}
				data={drivers.data?.body.data ?? []}
				isPending={drivers.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name,email,phone"
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
