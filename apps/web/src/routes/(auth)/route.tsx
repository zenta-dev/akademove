import { createFileRoute, Outlet } from "@tanstack/react-router";
import { PublicFooter } from "@/components/footer/public";
import { PublicHeader } from "@/components/header/public";

export const Route = createFileRoute("/(auth)")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="flex min-h-svh flex-col items-center justify-center">
			<PublicHeader className="mx-auto mt-2 max-w-3xl rounded-xl border p-2" />
			<div className="flex grow" />
			<Outlet />
			<div className="flex grow" />
			<PublicFooter className="mb-2 max-w-3xl rounded-xl border p-2" />
		</div>
	);
}
