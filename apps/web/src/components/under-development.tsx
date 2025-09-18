import { Settings } from "lucide-react";
import { Card, CardContent } from "./ui/card";

export const UnderDevelopment = () => {
	return (
		<Card className="p-0">
			<CardContent className="flex flex-col items-center p-8">
				<div className="rounded-full bg-muted-foreground/10 p-6">
					<Settings className="size-20 text-muted-foreground/70" />
				</div>
				<p className="mt-8 font-semibold text-2xl">Under Development</p>
				<p className="mt-2 text-muted-foreground">
					This module is in heavy development stage, please be patient
				</p>
			</CardContent>
		</Card>
	);
};
