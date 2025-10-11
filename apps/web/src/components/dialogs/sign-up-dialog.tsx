import { m } from "@repo/i18n";
import { Link } from "@tanstack/react-router";
import { type FC, type ReactNode, useState } from "react";
import DriverChar from "@/assets/character/driver.svg?url";
import MerchantChar from "@/assets/character/merchant.svg?url";
import UserChar from "@/assets/character/user.svg?url";
import { Card, CardContent } from "@/components/ui/card";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import type { FileRouteTypes } from "@/routeTree.gen";

interface SignUpDialogProps {
	asChild?: boolean;
	children?: ReactNode;
}

const ROUTES: Array<{
	name: string;
	desc: string;
	image: string;
	path: FileRouteTypes["to"];
}> = [
	{
		name: m.user(),
		desc: m.sign_up_dialog_user_desc(),
		image: UserChar,
		path: "/sign-up/user",
	},
	{
		name: m.driver(),
		desc: m.sign_up_dialog_driver_desc(),
		image: DriverChar,
		path: "/sign-up/driver",
	},
	{
		name: m.merchant(),
		desc: m.sign_up_dialog_merchant_desc(),
		image: MerchantChar,
		path: "/sign-up/merchant",
	},
];

export const SignUpDialog: FC<SignUpDialogProps> = ({ asChild, children }) => {
	const [open, setOpen] = useState(false);
	return (
		<Dialog open={open} onOpenChange={setOpen}>
			<DialogTrigger asChild={asChild} className="cursor-pointer">
				{asChild ? children : "Sign Up"}
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.sign_up_dialog()}</DialogTitle>
					<DialogDescription>{m.sign_up_dialog_desc()}</DialogDescription>
				</DialogHeader>
				<div className="flex flex-col items-center gap-4">
					{ROUTES.map(({ name, desc, image: AssetImage, path }) => (
						<Link
							key={name}
							to={path}
							className="w-full"
							onClick={() => setOpen(false)}
						>
							<Card className="w-full transition-all hover:scale-105 hover:shadow-md">
								<CardContent className="flex w-full flex-col items-center gap-2">
									<img src={AssetImage} alt={name} className="size-20" />
									<div className="w-full">
										<p className="text-center font-medium text-;g">{name}</p>
										<p className="text-center text-muted-foreground text-sm">
											{desc}
										</p>
									</div>
								</CardContent>
							</Card>
						</Link>
					))}
				</div>
			</DialogContent>
		</Dialog>
	);
};
