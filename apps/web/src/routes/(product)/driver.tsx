import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/(product)/driver")({
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/(product)/driver"!</div>;
}
