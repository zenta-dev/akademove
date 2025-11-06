import { Link } from "@tanstack/react-router";
import type React from "react";
import { LangToggle } from "@/components/toggle/lang-toggle";
import { ThemeToggle } from "@/components/toggle/theme-toggle";
import { cn } from "@/utils/cn";
import { BrandLogo } from "../misc/brand";

export const PublicFooter = ({
	className,
	...props
}: React.ComponentProps<"footer">) => {
	return (
		<footer className={cn("flex w-full items-center", className)} {...props}>
			<div className="flex w-full items-center justify-between px-2">
				<Link to="/" className="flex items-center gap-4">
					<BrandLogo />
					<h1 className="font-semibold text-xl">
						<span className="hidden md:inline">AkadeMove</span>
					</h1>
				</Link>
				<div className="flex items-center gap-2">
					<LangToggle />
					<ThemeToggle />
				</div>
			</div>
		</footer>
	);
};
