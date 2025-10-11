import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { orpcQuery } from "@/lib/orpc";
import { DRIVER_COLUMNS } from "./columns";

export const DriverTable = () => {
	const drivers = useQuery(
		orpcQuery.driver.list.queryOptions({ input: { query: {} } }),
	);
	const [visibility, setVisibility] = useState<VisibilityState>({});

	return (
		<DataTable
			columns={DRIVER_COLUMNS}
			data={drivers.data?.body.data ?? []}
			isPending={drivers.isPending}
			columnVisibility={visibility}
			setColumnVisibility={setVisibility}
		/>
	);
};
