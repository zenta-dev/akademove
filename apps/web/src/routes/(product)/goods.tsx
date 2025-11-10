import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/(product)/goods")({
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/(product)/goods"!</div>;
}
