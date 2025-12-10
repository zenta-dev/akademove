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
import { BANNER_COLUMNS } from "./columns";

type BannerSearchParams = TableProps["search"] & {
	isActive?: string;
	placement?: string;
	targetAudience?: string;
};

interface Props extends Omit<TableProps, "search"> {
	search: BannerSearchParams;
	to: FileRouteTypes["to"];
}

export const BannerTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [isActive, setIsActive] = useState<string | undefined>(search.isActive);
	const [placement, setPlacement] = useState<string | undefined>(
		search.placement,
	);
	const [targetAudience, setTargetAudience] = useState<string | undefined>(
		search.targetAudience,
	);

	const banners = useQuery(
		orpcQuery.banner.list.queryOptions({
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
					placement:
						(placement as "USER_HOME" | "DRIVER_HOME" | "MERCHANT_HOME") ||
						undefined,
					targetAudience:
						(targetAudience as "ALL" | "USERS" | "DRIVERS" | "MERCHANTS") ||
						undefined,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		title: true,
		imageUrl: !isMobile,
		placement: true,
		targetAudience: !isMobile,
		priority: !isMobile,
		isActive: true,
		createdAt: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				imageUrl: false,
				targetAudience: false,
				priority: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				imageUrl: true,
				targetAudience: true,
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
				placement,
				targetAudience,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		isActive,
		placement,
		targetAudience,
	]);

	const handleClearFilters = useCallback(() => {
		setIsActive(undefined);
		setPlacement(undefined);
		setTargetAudience(undefined);
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
		(page: number): BannerSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			isActive,
			placement,
			targetAudience,
		}),
		[search, debouncedFilter, isActive, placement, targetAudience],
	);

	const totalPages = useMemo(
		() => banners.data?.body.totalPages,
		[banners.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(isActive || placement || targetAudience);

	const activeOptions = [
		{ value: "true", label: "Active" },
		{ value: "false", label: "Inactive" },
	];

	const placementOptions = [
		{ value: "USER_HOME", label: "User Home" },
		{ value: "DRIVER_HOME", label: "Driver Home" },
		{ value: "MERCHANT_HOME", label: "Merchant Home" },
	];

	const targetAudienceOptions = [
		{ value: "ALL", label: "All Users" },
		{ value: "USERS", label: "Users Only" },
		{ value: "DRIVERS", label: "Drivers Only" },
		{ value: "MERCHANTS", label: "Merchants Only" },
	];

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

					<SingleSelectFilter
						options={placementOptions}
						value={placement}
						onValueChange={setPlacement}
						placeholder="Placement"
					/>

					<SingleSelectFilter
						options={targetAudienceOptions}
						value={targetAudience}
						onValueChange={setTargetAudience}
						placeholder="Target Audience"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={hasActiveFilters}
					/>
				</div>
			</div>

			<DataTable
				columns={BANNER_COLUMNS}
				data={banners.data?.body.data ?? []}
				isPending={banners.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="title"
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
