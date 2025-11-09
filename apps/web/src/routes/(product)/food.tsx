import { createFileRoute } from "@tanstack/react-router";

export const Route = createFileRoute("/(product)/food")({
	component: RouteComponent,
});

function RouteComponent() {
	return <div>Hello "/(product)/food"!</div>;
}
