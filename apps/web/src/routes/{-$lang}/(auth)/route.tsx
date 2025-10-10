import { createFileRoute, Outlet } from "@tanstack/react-router";
import { PublicFooter } from "@/components/footer/public";
import { PublicHeader } from "@/components/header/public";

export const Route = createFileRoute("/{-$lang}/(auth)")({
	component: RouteComponent,
});

function RouteComponent() {
	return (
		<div className="mx-auto flex h-full max-w-3xl flex-col items-center justify-between">
			<PublicHeader className="mt-2 rounded-xl border p-2" />
			<div className="flex grow" />
			<Outlet />
			<div className="flex grow" />
			<PublicFooter className="mb-2 rounded-xl border p-2" />
		</div>
	);
}
