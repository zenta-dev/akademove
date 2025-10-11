import { type Locale, m, setLocale } from "@repo/i18n";
import { GlobeIcon } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

const LANGS: { id: Locale; name: string }[] = [
	{
		id: "en",
		name: "English",
	},
	{
		id: "id",
		name: "Bahasa Indonesia",
	},
];

export function LangToggle() {
	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" size="icon">
					<GlobeIcon /> <span className="sr-only">{m.switch_language()}</span>
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end">
				{LANGS.map((v) => (
					<DropdownMenuItem key={v.id} onClick={() => setLocale(v.id)}>
						{v.name}
					</DropdownMenuItem>
				))}
			</DropdownMenuContent>
		</DropdownMenu>
	);
}
