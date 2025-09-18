import type { UserRole } from "@repo/schema/user";
import { redirect } from "@tanstack/react-router";
import { getSession } from "./actions";

export const requireRole = async (role: UserRole) => {
	const session = await getSession();
	if (!session || !session.user) {
		redirect({ to: "/sign-in", throw: true });
		return false;
	}
	if (session.user.role !== role) {
		redirect({ to: `/dash/${session.user.role}`, throw: true });
		return false;
	}
	return true;
};
