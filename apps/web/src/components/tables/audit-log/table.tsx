import { m } from "@repo/i18n";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { useQuery } from "@tanstack/react-query";
import { useNavigate } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import { format } from "date-fns";
import { CalendarIcon, FilterX } from "lucide-react";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { DefaultPagination } from "@/components/tables/default-pagination";
import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import { cn } from "@/utils/cn";
import { AUDIT_LOG_COLUMNS } from "./columns";

type AuditTableName =
	| "configurations"
	| "contact"
	| "coupon"
	| "report"
	| "user"
	| "wallet";

type AuditOperation = "INSERT" | "UPDATE" | "DELETE";

type AuditSearchParams = UnifiedPaginationQuery & {
	tableName?: AuditTableName;
	operation?: AuditOperation;
	startDate?: Date;
	endDate?: Date;
};

interface Props {
	search: AuditSearchParams;
	to: FileRouteTypes["to"];
}

export const AuditLogTable = ({ search, to }: Props) => {
	const navigate = useNavigate();
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const [tableName, setTableName] = useState<string | undefined>(
		search.tableName,
	);
	const [operation, setOperation] = useState<string | undefined>(
		search.operation,
	);
	const [startDate, setStartDate] = useState<Date | undefined>(
		search.startDate,
	);
	const [endDate, setEndDate] = useState<Date | undefined>(search.endDate);

	const auditLogs = useQuery(
		orpcQuery.audit.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					tableName: tableName as AuditTableName | undefined,
					operation: operation as AuditOperation | undefined,
					startDate,
					endDate,
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		tableName: true,
		operation: true,
		recordId: !isMobile,
		updatedById: !isMobile,
		ipAddress: false,
		reason: !isMobile,
		updatedAt: true,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				recordId: false,
				updatedById: false,
				ipAddress: false,
				reason: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				recordId: true,
				updatedById: true,
				reason: true,
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
				tableName: tableName as AuditTableName | undefined,
				operation: operation as AuditOperation | undefined,
				startDate,
				endDate,
			},
		});
	}, [
		navigate,
		to,
		search,
		debouncedFilter,
		tableName,
		operation,
		startDate,
		endDate,
	]);

	const handleClearFilters = useCallback(() => {
		setTableName(undefined);
		setOperation(undefined);
		setStartDate(undefined);
		setEndDate(undefined);
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
		(page: number): AuditSearchParams => ({
			...search,
			page,
			query: debouncedFilter,
			tableName: tableName as AuditTableName | undefined,
			operation: operation as AuditOperation | undefined,
			startDate,
			endDate,
		}),
		[search, debouncedFilter, tableName, operation, startDate, endDate],
	);

	const totalPages = useMemo(
		() => auditLogs.data?.body.totalPages,
		[auditLogs.data?.body.totalPages],
	);

	const hasActiveFilters = tableName ?? operation ?? startDate ?? endDate;

	return (
		<>
			<div className="space-y-4 p-4">
				<div className="flex flex-wrap gap-2">
					<Select
						value={tableName ?? ""}
						onValueChange={(value) => setTableName(value || undefined)}
					>
						<SelectTrigger className="w-[180px]">
							<SelectValue placeholder={m.table()} />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="">All Tables</SelectItem>
							<SelectItem value="configurations">Configurations</SelectItem>
							<SelectItem value="contact">Contact</SelectItem>
							<SelectItem value="coupon">Coupon</SelectItem>
							<SelectItem value="report">Report</SelectItem>
							<SelectItem value="user">User</SelectItem>
							<SelectItem value="wallet">Wallet</SelectItem>
						</SelectContent>
					</Select>

					<Select
						value={operation ?? ""}
						onValueChange={(value) => setOperation(value || undefined)}
					>
						<SelectTrigger className="w-[180px]">
							<SelectValue placeholder={m.operation()} />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="">All Operations</SelectItem>
							<SelectItem value="INSERT">INSERT</SelectItem>
							<SelectItem value="UPDATE">UPDATE</SelectItem>
							<SelectItem value="DELETE">DELETE</SelectItem>
						</SelectContent>
					</Select>

					<Popover>
						<PopoverTrigger asChild>
							<Button
								variant="outline"
								className={cn(
									"w-[180px] justify-start text-left font-normal",
									!startDate && "text-muted-foreground",
								)}
							>
								<CalendarIcon className="mr-2 h-4 w-4" />
								{startDate ? format(startDate, "PPP") : "Start date"}
							</Button>
						</PopoverTrigger>
						<PopoverContent className="w-auto p-0">
							<Calendar
								mode="single"
								selected={startDate}
								onSelect={setStartDate}
								initialFocus
							/>
						</PopoverContent>
					</Popover>

					<Popover>
						<PopoverTrigger asChild>
							<Button
								variant="outline"
								className={cn(
									"w-[180px] justify-start text-left font-normal",
									!endDate && "text-muted-foreground",
								)}
							>
								<CalendarIcon className="mr-2 h-4 w-4" />
								{endDate ? format(endDate, "PPP") : "End date"}
							</Button>
						</PopoverTrigger>
						<PopoverContent className="w-auto p-0">
							<Calendar
								mode="single"
								selected={endDate}
								onSelect={setEndDate}
								initialFocus
							/>
						</PopoverContent>
					</Popover>

					<Button onClick={handleApplyFilters}>Apply Filters</Button>
					{hasActiveFilters && (
						<Button variant="outline" onClick={handleClearFilters}>
							<FilterX className="mr-2 h-4 w-4" />
							Clear
						</Button>
					)}
				</div>
			</div>

			<DataTable
				columns={AUDIT_LOG_COLUMNS}
				data={auditLogs.data?.body.data ?? []}
				isPending={auditLogs.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys="recordId"
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
