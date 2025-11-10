import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/(product)/transport")({
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/(product)/transport"!</div>;
}
