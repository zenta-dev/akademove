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
	SingleSelectFilter,
} from "@/components/tables/filters";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import type { TableProps } from "../type";
import { COUPON_COLUMNS } from "./columns";

type CouponSearchParams = TableProps["search"] & {
	isActive?: string;
	validityPeriod?: DateRange;
	merchantId?: string;
	minUsage?: number;
	maxUsage?: number;
};

interface Props extends Omit<TableProps, "search"> {
	search: CouponSearchParams;
	to: FileRouteTypes["to"];
}

export const CouponTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [isActive, setIsActive] = useState<string | undefined>(search.isActive);
	const [validityPeriod, setValidityPeriod] = useState<DateRange | undefined>(
		search.validityPeriod,
	);
	const [merchantId, setMerchantId] = useState<string | undefined>(
		search.merchantId,
	);
	const [minUsage, setMinUsage] = useState<number | undefined>(search.minUsage);
	const [maxUsage, setMaxUsage] = useState<number | undefined>(search.maxUsage);

	// Get merchants for dropdown
	const merchants = useQuery(
		orpcQuery.merchant.list.queryOptions({
			input: {
				query: { limit: 1000 }, // Get all merchants for dropdown
			},
		}),
	);

	const coupons = useQuery(
		orpcQuery.coupon.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					isActive:
						isActive === "true"
							? true
							: isActive === "false"
								? false
								: undefined,
					startDate: validityPeriod?.from,
					endDate: validityPeriod?.to,
					merchantId,
					minUsage,
					maxUsage,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		id: !isMobile,
		name: true,
		code: true,
		discountType: true,
		discountValue: true,
		minOrderAmount: !isMobile,
		isActive: true,
		periodStart: !isMobile,
		periodEnd: !isMobile,
		usedCount: !isMobile,
		usageLimit: !isMobile,
		merchantName: true,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				id: false,
				minOrderAmount: false,
				periodStart: false,
				periodEnd: false,
				usedCount: false,
				usageLimit: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				id: true,
				minOrderAmount: true,
				periodStart: true,
				periodEnd: true,
				usedCount: true,
				usageLimit: true,
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
				validityPeriod,
				merchantId,
				minUsage,
				maxUsage,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		isActive,
		validityPeriod,
		merchantId,
		minUsage,
		maxUsage,
	]);

	const handleClearFilters = useCallback(() => {
		setIsActive(undefined);
		setValidityPeriod(undefined);
		setMerchantId(undefined);
		setMinUsage(undefined);
		setMaxUsage(undefined);
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
		(page: number): CouponSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			isActive,
			validityPeriod,
			merchantId,
			minUsage,
			maxUsage,
		}),
		[
			search,
			debouncedFilter,
			isActive,
			validityPeriod,
			merchantId,
			minUsage,
			maxUsage,
		],
	);

	const totalPages = useMemo(
		() => coupons.data?.body.totalPages,
		[coupons.data?.body.totalPages],
	);

	const hasActiveFilters = Boolean(
		isActive ||
			validityPeriod ||
			merchantId ||
			minUsage !== undefined ||
			maxUsage !== undefined,
	);

	const activeOptions = [
		{ value: "true", label: "Active" },
		{ value: "false", label: "Inactive" },
	];

	const merchantOptions = merchants.data?.body.data.map((merchant) => ({
		value: merchant.id,
		label: merchant.name,
	})) ?? [{ value: "", label: "All Merchants" }];

	const usageOptions = Array.from({ length: 20 }, (_, i) => i * 5).map(
		(usage) => ({
			value: usage.toString(),
			label: `${usage}+ uses`,
		}),
	);

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

					<DateRangePicker
						value={validityPeriod}
						onChange={setValidityPeriod}
						placeholder="Validity period"
					/>

					<SingleSelectFilter
						options={merchantOptions}
						value={merchantId}
						onValueChange={setMerchantId}
						placeholder="Merchant"
					/>

					<SingleSelectFilter
						options={usageOptions}
						value={minUsage?.toString()}
						onValueChange={(value) =>
							setMinUsage(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Min Usage"
					/>

					<SingleSelectFilter
						options={usageOptions}
						value={maxUsage?.toString()}
						onValueChange={(value) =>
							setMaxUsage(value ? Number.parseInt(value, 10) : undefined)
						}
						placeholder="Max Usage"
					/>

					<FilterActions
						onApplyFilters={handleApplyFilters}
						onClearFilters={handleClearFilters}
						hasActiveFilters={hasActiveFilters}
					/>
				</div>
			</div>

			<DataTable
				columns={COUPON_COLUMNS}
				data={coupons.data?.body.data ?? []}
				isPending={coupons.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="name,code,merchantName"
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
