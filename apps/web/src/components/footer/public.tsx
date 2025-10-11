import type React from "react";
import { LangToggle } from "@/components/toggle/lang-toggle";
import { ThemeToggle } from "@/components/toggle/theme-toggle";
import { cn } from "@/utils/cn";

export const PublicFooter = ({
	className,
	...props
}: React.ComponentProps<"footer">) => {
	return (
		<footer className={cn("flex w-full items-center", className)} {...props}>
			<div className="flex w-full items-center justify-between px-2">
				<h1 className="font-semibold text-xl">
					<span className="md:inline">AM</span>
				</h1>
				<div className="flex items-center gap-2">
					<LangToggle />
					<ThemeToggle />
				</div>
			</div>
		</footer>
	);
};
