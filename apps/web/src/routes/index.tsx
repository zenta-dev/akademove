import { createFileRoute } from "@tanstack/react-router";
import { PublicFooter } from "@/components/footer/public";
import { PublicHeader } from "@/components/header/public";

export const Route = createFileRoute("/")({
	component: HomeComponent,
});

function HomeComponent() {
	return (
		<div className="h-full">
			<PublicHeader className="mx-auto mt-2 max-w-3xl rounded-xl border p-2" />
			<div className="flex grow" />
			<PublicFooter className="mx-auto mt-2 max-w-3xl rounded-xl border p-2" />
		</div>
	);
}
