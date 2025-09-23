// import type { User, UserRole } from "@repo/schema/user";
// import { redirect } from "@tanstack/react-router";

// export const requireRole = async (role: UserRole, user?: User) => {
// 	if (!user) {
// 		redirect({ to: "/{-$lang}", throw: true });
// 		return false;
// 	}
// 	if (user.role !== role) {
// 		redirect({ to: `/dash/${user.role}`, throw: true });
// 		return false;
// 	}
// 	return true;
// };
