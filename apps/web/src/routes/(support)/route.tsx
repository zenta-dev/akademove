import { createFileRoute, Outlet } from "@tanstack/react-router";
import { LandingFooter } from "@/components/footer/landing-footer";
import { PublicHeader } from "@/components/header/public";

export const Route = createFileRoute("/(support)")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="flex min-h-screen flex-1 flex-col items-center justify-center">
			<PublicHeader className="fixed top-0 right-0 left-0 z-50 m-auto mt-2 w-full max-w-3xl rounded-xl border p-4" />
			<div className="mb-12 w-full px-4">
				<Outlet />
			</div>
			<LandingFooter className="w-full" />
		</div>
	);
}
