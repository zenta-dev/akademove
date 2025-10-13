import { m } from "@repo/i18n";
import type { MerchantMenu } from "@repo/schema/merchant";
import type { ColumnDef } from "@tanstack/react-table";
import { NoImageIcon } from "@/components/misc/no-image-icon";
import { ImageZoom } from "@/components/ui/shadcn-io/image-zoom";
import { MerchantMenuActionTable } from "./action";

export const MERCHANT_MENU_COLUMNS = [
	{
		id: "image",
		accessorKey: "image",
		header: m.image(),
		cell: ({ row }) => {
			const { name, image, updatedAt } = row.original;

			if (!image)
				return (
					<NoImageIcon
						size="xs"
						className="text-destructive sm:size-12 md:size-14 lg:size-16 xl:size-18"
					/>
				);

			return (
				<ImageZoom
					src={`${image}?v=${updatedAt.getTime() ?? Date.now()}`}
					layout="constrained"
					width={72}
					height={72}
					background="auto"
					alt={name}
					className="sm:size-12 md:size-14 lg:size-16 xl:size-18"
				/>
			);
		},
	},
	{
		id: "name",
		accessorKey: "name",
		enableHiding: false,
		header: m.name(),
	},
	{
		id: "category",
		accessorKey: "category",
		enableHiding: false,
		header: m.category(),
	},
	{
		id: "price",
		accessorKey: "price",
		enableHiding: false,
		header: m.price(),
	},
	{
		id: "stock",
		accessorKey: "stock",
		enableHiding: false,
		header: m.stock(),
	},
	{
		id: "createdAt",
		accessorKey: "createdAt",
		header: m.created_at(),
		cell: ({ row }) => {
			const date = new Date(row.getValue("createdAt"));

			return (
				<div className="text-start font-medium">
					{date.toLocaleDateString("id-ID", {
						day: "numeric",
						month: "short",
						year: "numeric",
					})}
				</div>
			);
		},
	},
	{
		id: "actions",
		enableHiding: false,
		header: m.actions(),
		cell: ({ row }) => {
			return <MerchantMenuActionTable val={row.original} />;
		},
	},
] as const satisfies ColumnDef<MerchantMenu>[];
