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
import { MERCHANT_COLUMNS } from "./columns";

type MerchantSearchParams = TableProps["search"] & {
	categories?: string[];
	isActive?: string;
	minRating?: number;
	maxRating?: number;
};

interface Props extends Omit<TableProps, "search"> {
	search: MerchantSearchParams;
	to: FileRouteTypes["to"];
}

export const MerchantTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [categories, setCategories] = useState<string[]>(
		search.categories ?? [],
	);
	const [isActive, setIsActive] = useState<string | undefined>(search.isActive);
	const [minRating, setMinRating] = useState<number | undefined>(
		search.minRating,
	);
	const [maxRating, setMaxRating] = useState<number | undefined>(
		search.maxRating,
	);

	const merchants = useQuery(
		orpcQuery.merchant.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					categories: categories.length > 0 ? categories : undefined,
					isActive:
						isActive === "true"
							? true
							: isActive === "false"
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
		category: true,
		isActive: true,
		status: true,
		rating: true,
		address: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				email: false,
				phone: false,
				address: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				email: true,
				phone: true,
				address: true,
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
				categories: categories.length > 0 ? categories : undefined,
				isActive,
				minRating,
				maxRating,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		categories,
		isActive,
		minRating,
		maxRating,
	]);

	const handleClearFilters = useCallback(() => {
		setCategories([]);
		setIsActive(undefined);
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
		(page: number): MerchantSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			categories: categories.length > 0 ? categories : undefined,
			isActive,
			minRating,
			maxRating,
		}),
		[search, debouncedFilter, categories, isActive, minRating, maxRating],
	);

	const totalPages = useMemo(
		() => merchants.data?.body.totalPages,
		[merchants.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(
		categories.length > 0 ||
			isActive ||
			minRating !== undefined ||
			maxRating !== undefined,
	);

	const categoryOptions = CONSTANTS.MERCHANT_CATEGORIES.map((category) => ({
		value: category,
		label: category,
	}));

	const activeOptions = [
		{ value: "true", label: "Active" },
		{ value: "false", label: "Inactive" },
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
						options={categoryOptions}
						selectedValues={categories}
						onSelectionChange={setCategories}
						placeholder="Categories"
						variant="compact"
					/>

					<SingleSelectFilter
						options={activeOptions}
						value={isActive}
						onValueChange={setIsActive}
						placeholder="Status"
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
				columns={MERCHANT_COLUMNS}
				data={merchants.data?.body.data ?? []}
				isPending={merchants.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name,email,phone,address"
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
