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
import { Skeleton } from "@/components/ui/skeleton";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import type { TableProps } from "../type";
import { MERCHANT_MENU_COLUMNS } from "./columns";

type MenuSearchParams = TableProps["search"] & {
	categories?: string[];
	inStock?: string;
	minPrice?: number;
	maxPrice?: number;
};

interface Props extends Omit<TableProps, "search"> {
	search: MenuSearchParams;
	to: FileRouteTypes["to"];
	merchantId: string;
}

export const MerchantMenuTable = ({ merchantId, search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [categories, setCategories] = useState<string[]>(
		search.categories ?? [],
	);
	const [inStock, setInStock] = useState<string | undefined>(search.inStock);
	const [minPrice, setMinPrice] = useState<number | undefined>(search.minPrice);
	const [maxPrice, setMaxPrice] = useState<number | undefined>(search.maxPrice);

	const menus = useQuery(
		orpcQuery.merchant.menu.list.queryOptions({
			input: {
				params: { merchantId },
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					categories: categories.length > 0 ? categories : undefined,
					inStock:
						inStock === "true" ? true : inStock === "false" ? false : undefined,
					minPrice,
					maxPrice,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		id: !isMobile,
		name: true,
		category: true,
		price: true,
		stock: true,
		description: !isMobile,
		imageUrl: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				description: false,
				imageUrl: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				description: true,
				imageUrl: true,
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
				inStock,
				minPrice,
				maxPrice,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		categories,
		inStock,
		minPrice,
		maxPrice,
	]);

	const handleClearFilters = useCallback(() => {
		setCategories([]);
		setInStock(undefined);
		setMinPrice(undefined);
		setMaxPrice(undefined);
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
		(page: number): MenuSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			categories: categories.length > 0 ? categories : undefined,
			inStock,
			minPrice,
			maxPrice,
		}),
		[search, debouncedFilter, categories, inStock, minPrice, maxPrice],
	);

	const totalPages = useMemo(
		() => menus.data?.body.totalPages,
		[menus.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(
		categories.length > 0 ||
			inStock ||
			minPrice !== undefined ||
			maxPrice !== undefined,
	);

	// Common food categories
	const categoryOptions = [
		{ value: "Food", label: "Food" },
		{ value: "Beverage", label: "Beverage" },
		{ value: "Snack", label: "Snack" },
		{ value: "Dessert", label: "Dessert" },
		{ value: "Main Course", label: "Main Course" },
		{ value: "Appetizer", label: "Appetizer" },
		{ value: "Soup", label: "Soup" },
		{ value: "Salad", label: "Salad" },
	];

	const stockOptions = [
		{ value: "true", label: "In Stock" },
		{ value: "false", label: "Out of Stock" },
	];

	const priceOptions = [
		{ value: "10000", label: "Under 10K" },
		{ value: "25000", label: "Under 25K" },
		{ value: "50000", label: "Under 50K" },
		{ value: "75000", label: "Under 75K" },
		{ value: "100000", label: "Under 100K" },
	];

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
						options={stockOptions}
						value={inStock}
						onValueChange={setInStock}
						placeholder="Stock Status"
					/>

					<SingleSelectFilter
						options={priceOptions}
						value={minPrice?.toString()}
						onValueChange={(value) =>
							setMinPrice(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Min Price"
					/>

					<SingleSelectFilter
						options={priceOptions}
						value={maxPrice?.toString()}
						onValueChange={(value) =>
							setMaxPrice(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Max Price"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={hasActiveFilters}
					/>
				</div>
			</div>

			<DataTable
				columns={MERCHANT_MENU_COLUMNS}
				data={menus.data?.body.data ?? []}
				totalPages={menus.data?.body.totalPages}
				isPending={menus.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name,category,description"
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
		</>
	);
};
