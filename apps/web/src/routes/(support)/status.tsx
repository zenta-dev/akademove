import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/(support)/status")({
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/(support)/status"!</div>;
}
