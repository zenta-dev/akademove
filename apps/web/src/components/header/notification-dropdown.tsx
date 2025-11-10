import { Bell } from "lucide-react";
import { useFCM } from "@/hooks/use-fcm";
import { Button } from "../ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuTrigger,
} from "../ui/dropdown-menu";
import { Skeleton } from "../ui/skeleton";

export const NotificationDropdown = () => {
	const fcm = useFCM();

	if (fcm.isLoading) {
		return <Skeleton className="size-6" />;
	}

	return (
		<DropdownMenu>
			<DropdownMenuTrigger asChild>
				<Button variant="ghost" size="icon">
					<Bell /> <span className="sr-only">Notification</span>
				</Button>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="end" />
		</DropdownMenu>
	);
};
