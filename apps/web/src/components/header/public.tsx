import { Link } from "@tanstack/react-router";
import { UserDropdwon } from "@/components/header/user-dropdown";
import { cn } from "@/utils/cn";
import { BrandLogo } from "../misc/brand";

export const PublicHeader = ({
	className,
	...props
}: React.ComponentProps<"header">) => {
	return (
		<header
			className={cn(
				"sticky top-0 z-50 flex w-full items-center bg-background/50 backdrop-blur-2xl",
				className,
			)}
			{...props}
		>
			<div className="flex h-(--header-height) w-full items-center justify-between px-2">
				<Link to="/" className="flex h-(--header-height) items-center gap-4">
					<BrandLogo />
					<h1 className="font-semibold text-xl">
						<span className="hidden md:inline">AkadeMove</span>
					</h1>
				</Link>
				<div className="flex items-center gap-2">
					<UserDropdwon />
				</div>
			</div>
		</header>
	);
};
