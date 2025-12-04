import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import { DefaultPagination } from "../default-pagination";
import type { TableProps } from "../type";
import { CONTACT_COLUMNS } from "./columns";

interface Props extends TableProps {
	status?: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
}

export const ContactTable = ({ search, to, status }: Props) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const contacts = useQuery(
		orpcQuery.contact.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
					status,
				},
			},
		}),
	);
	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		name: true,
		email: true,
		subject: !isMobile,
		status: true,
		createdAt: !isMobile,
		actions: true,
	});

	const composeSearch = useCallback(
		(page: number) => ({ ...search, page, query: debouncedFilter }),
		[search, debouncedFilter],
	);
	const totalPages = useMemo(
		() => contacts.data?.body.data.pagination?.totalPages,
		[contacts.data?.body.data.pagination?.totalPages],
	);

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				subject: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				subject: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

	return (
		<DataTable
			columns={CONTACT_COLUMNS}
			data={contacts.data?.body.data.rows ?? []}
			isPending={contacts.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKeys={m.name().toLowerCase()}
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
	);
};
