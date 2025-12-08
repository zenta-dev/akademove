import type { UserListQuery } from "@repo/schema/pagination";
import type { FileRouteTypes } from "@/routeTree.gen";

export type TableProps = {
	search: UserListQuery;
	to: FileRouteTypes["to"];
	skeletonLength?: number;
};
