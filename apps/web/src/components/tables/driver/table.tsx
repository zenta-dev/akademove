import { useQuery } from "@tanstack/react-query";
import { orpcQuery } from "@/lib/client/orpc";
import { DataTable } from "../data-table";
import { DRIVER_COLUMNS } from "./columns";

export const DriverTable = () => {
	const drivers = useQuery(
		orpcQuery.driver.list.queryOptions({ input: { query: {} } }),
	);

	return (
		<DataTable
			columns={DRIVER_COLUMNS}
			data={drivers.data?.body.data ?? []}
			isPending={drivers.isPending}
		/>
	);
};
