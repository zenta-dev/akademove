import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useEffect, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import { USER_COLUMNS } from "./columns";

export const UserTable = () => {
	const users = useQuery(
		orpcQuery.user.list.queryOptions({ input: { query: {} } }),
	);
	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		name: true,
		email: true,
		role: true,
		emailVerified: !isMobile,
		createdAt: !isMobile,
		actions: true,
	});

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				emailVerified: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				emailVerified: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

	return (
		<DataTable
			columns={USER_COLUMNS}
			data={users.data?.body.data ?? []}
			isPending={users.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
		/>
	);
};
