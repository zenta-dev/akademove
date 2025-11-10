import { m } from "@repo/i18n";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { Link } from "@tanstack/react-router";
import {
	ChevronFirstIcon,
	ChevronLastIcon,
	ChevronLeft,
	ChevronRight,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import type { TableProps } from "./type";

interface Props extends TableProps {
	composeSearch: (page: number) => UnifiedPaginationQuery;
	totalPages?: number;
}

export const DefaultPagination = ({
	search,
	to,
	totalPages,
	composeSearch,
}: Props) => {
	return (
		<div className="flex items-center justify-end space-x-2">
			<Button variant="outline" size="sm" disabled={search?.page === 1} asChild>
				<Link to={to} search={composeSearch(1)}>
					<ChevronFirstIcon />
					<span className="sr-only">{m.first_page()}</span>
				</Link>
			</Button>
			<Button variant="outline" size="sm" disabled={search?.page === 1} asChild>
				<Link to={to} search={composeSearch((search?.page ?? 1) - 1)}>
					<ChevronLeft />
					<span className="sr-only">{m.previous()}</span>
				</Link>
			</Button>
			<span className="text-muted-foreground text-sm">
				{m.pagination_desc({
					page: search?.page ?? 1,
					totalPages: totalPages ?? 0,
				})}
			</span>
			<Button
				variant="outline"
				size="sm"
				disabled={search?.page === totalPages}
				asChild
			>
				<Link to={to} search={composeSearch((search?.page ?? 0) + 1)}>
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
	);
};
