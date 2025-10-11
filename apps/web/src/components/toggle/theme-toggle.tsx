import { m } from "@repo/i18n";
import { Moon, Sun } from "lucide-react";
import { useTheme } from "next-themes";
import { useCallback } from "react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { setThemeCookie } from "@/lib/actions";

export function ThemeToggle() {
	const { setTheme } = useTheme();

	const _setTheme = useCallback(
		(theme: "system" | "dark" | "light") => {
			setTheme(theme);
			setThemeCookie({ data: theme });
		},
		[setTheme],
	);

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" size="icon">
					<Sun className="dark:-rotate-90 h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:scale-0" />
					<Moon className="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
					<span className="sr-only">Toggle theme</span>
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				<DropdownMenuItem onClick={() => _setTheme("light")}>
					{m.light()}
				</DropdownMenuItem>
				<DropdownMenuItem onClick={() => _setTheme("dark")}>
					{m.dark()}
				</DropdownMenuItem>
				<DropdownMenuItem onClick={() => _setTheme("system")}>
					{m.system()}
				</DropdownMenuItem>
			</DropdownMenuContent>
		</DropdownMenu>
	);
}
