import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useEffect, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import type { TableProps } from "../type";
import { AUDIT_LOG_COLUMNS } from "./columns";

interface Props extends TableProps {
	tableName?:
		| "configurations"
		| "contact"
		| "coupon"
		| "report"
		| "user"
		| "wallet";
	recordId?: string;
	operation?: "INSERT" | "UPDATE" | "DELETE";
	updatedById?: string;
	startDate?: Date;
	endDate?: Date;
}

export const AuditLogTable = ({
	search,
	to,
	tableName,
	recordId,
	operation,
	updatedById,
	startDate,
	endDate,
}: Props) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const auditLogs = useQuery(
		orpcQuery.audit.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					tableName,
					recordId,
					operation,
					updatedById,
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

	return (
		<DataTable
			columns={AUDIT_LOG_COLUMNS}
			data={auditLogs.data?.body.data ?? []}
			isPending={auditLogs.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKeys="recordId"
			filterValue={filter}
			onFilterChange={setFilter}
		/>
	);
};
