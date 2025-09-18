import { createFileRoute } from "@tanstack/react-router";
import { PublicHeader } from "@/components/header/public";

export const Route = createFileRoute("/")({
	component: HomeComponent,
});

function HomeComponent() {
	return (
		<div>
			<PublicHeader className="mx-auto mt-2 max-w-3xl rounded-xl border p-2" />
		</div>
	);
}
