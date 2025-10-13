/** biome-ignore-all lint/suspicious/noArrayIndexKey: generated skeleton didnt have data */
import { m } from "@repo/i18n";
import {
	type ColumnDef,
	type ColumnFiltersState,
	flexRender,
	getCoreRowModel,
	getFilteredRowModel,
	getPaginationRowModel,
	getSortedRowModel,
	type SortingState,
	useReactTable,
	type VisibilityState,
} from "@tanstack/react-table";
import { type ReactNode, useState } from "react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuCheckboxItem,
	DropdownMenuContent,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Skeleton } from "@/components/ui/skeleton";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";

interface DataTableProps<TData, TValue> {
	columns: ColumnDef<TData, TValue>[];
	data: TData[];
	isPending?: boolean;
	columnVisibility?: VisibilityState;
	setColumnVisibility?: React.Dispatch<React.SetStateAction<VisibilityState>>;
	filterKey?: keyof TData;
	totalPages?: number;
	children?: ReactNode;
}

export function DataTable<TData, TValue>({
	columns,
	data,
	isPending = false,
	columnVisibility,
	setColumnVisibility,
	filterKey,
	totalPages,
	children,
}: DataTableProps<TData, TValue>) {
	const [sorting, setSorting] = useState<SortingState>([]);
	const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);

	const table = useReactTable({
		data,
		columns,
		getCoreRowModel: getCoreRowModel(),
		getPaginationRowModel: getPaginationRowModel(),
		onSortingChange: setSorting,
		getSortedRowModel: getSortedRowModel(),
		onColumnFiltersChange: setColumnFilters,
		getFilteredRowModel: getFilteredRowModel(),
		onColumnVisibilityChange: setColumnVisibility,
		state: { sorting, columnFilters, columnVisibility },
		pageCount: totalPages,
	});

	return (
		<div className="p-2">
			<div className="flex items-center">
				{filterKey && (
					<Input
						placeholder="Filter items..."
						value={
							filterKey
								? ((table
										.getColumn(String(filterKey))
										?.getFilterValue() as string) ?? "")
								: ""
						}
						onChange={(event) => {
							if (filterKey)
								table
									.getColumn(String(filterKey))
									?.setFilterValue(event.target.value);
						}}
						className="max-w-sm"
					/>
				)}
				<DropdownMenu>
					<DropdownMenuTrigger asChild>
						<Button variant="outline" size="sm" className="ml-auto">
							{m.columns()}
						</Button>
					</DropdownMenuTrigger>
					<DropdownMenuContent align="end">
						{table
							.getAllColumns()
							.filter((column) => column.getCanHide())
							.map((column) => {
								return (
									<DropdownMenuCheckboxItem
										key={column.id}
										className="capitalize"
										checked={column.getIsVisible()}
										onCheckedChange={(value) =>
											column.toggleVisibility(!!value)
										}
									>
										{column.id}
									</DropdownMenuCheckboxItem>
								);
							})}
					</DropdownMenuContent>
				</DropdownMenu>
			</div>
			<div className="my-2 overflow-hidden rounded-md border">
				<Table>
					<TableHeader>
						{table.getHeaderGroups().map((headerGroup) => (
							<TableRow key={headerGroup.id}>
								{headerGroup.headers.map((header) => {
									return (
										<TableHead key={header.id}>
											{header.isPlaceholder
												? null
												: flexRender(
														header.column.columnDef.header,
														header.getContext(),
													)}
										</TableHead>
									);
								})}
							</TableRow>
						))}
					</TableHeader>
					<TableBody>
						{isPending ? (
							Array.from({ length: 12 }).map((_, i) => (
								<TableRow key={i}>
									{Array.from({
										length: table.getVisibleFlatColumns().length,
									}).map((_, i) => (
										<TableCell key={i} className="h-8 text-center">
											<Skeleton className="h-8 w-full" />
										</TableCell>
									))}
								</TableRow>
							))
						) : table.getRowModel().rows?.length ? (
							table.getRowModel().rows.map((row) => (
								<TableRow
									key={row.id}
									data-state={row.getIsSelected() && "selected"}
								>
									{row.getVisibleCells().map((cell) => (
										<TableCell key={cell.id}>
											{flexRender(
												cell.column.columnDef.cell,
												cell.getContext(),
											)}
										</TableCell>
									))}
								</TableRow>
							))
						) : (
							<TableRow>
								<TableCell
									colSpan={columns.length}
									className="h-24 text-center"
								>
									{m.no_result_found()}.
								</TableCell>
							</TableRow>
						)}
					</TableBody>
				</Table>
			</div>
			{children}
		</div>
	);
}
