import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { FileRouteTypes } from "@/routeTree.gen";

export type TableProps = {
	search: UnifiedPaginationQuery;
	to: FileRouteTypes["to"];
};
