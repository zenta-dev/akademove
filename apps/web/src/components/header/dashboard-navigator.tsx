import { localizeHref } from "@repo/i18n";
import type { UserRole } from "@repo/schema/user";
import { Link } from "@tanstack/react-router";
import { GripIcon } from "lucide-react";
import { useMemo } from "react";
import { buttonVariants } from "../ui/button";

export const DashboardNavigator = ({ role }: { role: UserRole }) => {
	const route = useMemo(() => {
		return localizeHref(`/dash/${role}`);
	}, [role]);

	if (role === "user") return;

	return (
		<Link
			to={route}
			className={buttonVariants({ variant: "ghost", size: "icon" })}
		>
			<GripIcon />
		</Link>
	);
};
