import { m } from "@repo/i18n";
import type { OffsetPaginationQuery } from "@repo/schema/pagination";
import { useQuery } from "@tanstack/react-query";
import { Link } from "@tanstack/react-router";
import type { VisibilityState } from "@tanstack/react-table";
import {
	ChevronFirstIcon,
	ChevronLastIcon,
	ChevronLeft,
	ChevronRight,
} from "lucide-react";
import { useCallback, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { Button } from "@/components/ui/button";
import { Skeleton } from "@/components/ui/skeleton";
import { orpcQuery } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import { MERCHANT_MENU_COLUMNS } from "./columns";

export const MerchantMenuTable = ({
	merchantId,
	search,
	to,
}: {
	merchantId: string;
	search: OffsetPaginationQuery;
	to: FileRouteTypes["to"];
}) => {
	const menus = useQuery(
		orpcQuery.merchant.menu.list.queryOptions({
			input: { params: { merchantId }, query: search },
		}),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	const composeSearch = useCallback(
		(page: number) => ({ ...search, page }),
		[search],
	);
	const totalPages = useMemo(
		() => menus.data?.body.totalPages,
		[menus.data?.body.totalPages],
	);

	return (
		<DataTable
			columns={MERCHANT_MENU_COLUMNS}
			data={menus.data?.body.data ?? []}
			totalPages={menus.data?.body.totalPages}
			isPending={menus.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
			filterKey={"name"}
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
				<div className="flex items-center justify-end space-x-2">
					<Button
						variant="outline"
						size="sm"
						disabled={search?.page === 1}
						asChild
					>
						<Link to={to} search={composeSearch(1)}>
							<ChevronFirstIcon />
							<span className="sr-only">{m.first_page()}</span>
						</Link>
					</Button>
					<Button
						variant="outline"
						size="sm"
						disabled={search?.page === 1}
						asChild
					>
						<Link to={to} search={composeSearch(search.page - 1)}>
							<ChevronLeft />
							<span className="sr-only">{m.previous()}</span>
						</Link>
					</Button>
					<span className="text-muted-foreground text-sm">
						{m.pagination_desc({
							page: search.page,
							totalPages: totalPages ?? 0,
						})}
					</span>
					<Button
						variant="outline"
						size="sm"
						disabled={search?.page === totalPages}
						asChild
					>
						<Link to={to} search={composeSearch(search.page + 1)}>
							<ChevronRight />
							<span className="sr-only">{m.next()}</span>
						</Link>
					</Button>
					<Button
						variant="outline"
						size="sm"
						disabled={search?.page === totalPages}
						asChild
					>
						<Link to={to} search={composeSearch(totalPages ?? 1)}>
							<ChevronLastIcon />
							<span className="sr-only">{m.last_page()}</span>
						</Link>
					</Button>
				</div>
			)}
		</DataTable>
	);
};
