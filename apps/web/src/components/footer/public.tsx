import type React from "react";
import { cn } from "@/utils/cn";
import { LangToggle } from "../toggle/lang-toggle";
import { ThemeToggle } from "../toggle/theme-toggle";

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
