import { useQuery } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import { getAllDriver } from "@/api";
import { getAllDriverOptions } from "@/api/@tanstack/react-query.gen";

export const Route = createFileRoute("/")({
	component: HomeComponent,
	loader: async () => {
		const { error, data } = await getAllDriver({
			query: { page: 1, limit: 10 },
		});
		if (!error && data.success) {
			return data.data;
		}
	},
});

const TITLE_TEXT = `
 ██████╗ ███████╗████████╗████████╗███████╗██████╗
 ██╔══██╗██╔════╝╚══██╔══╝╚══██╔══╝██╔════╝██╔══██╗
 ██████╔╝█████╗     ██║      ██║   █████╗  ██████╔╝
 ██╔══██╗██╔══╝     ██║      ██║   ██╔══╝  ██╔══██╗
 ██████╔╝███████╗   ██║      ██║   ███████╗██║  ██║
 ╚═════╝ ╚══════╝   ╚═╝      ╚═╝   ╚══════╝╚═╝  ╚═╝

 ████████╗    ███████╗████████╗ █████╗  ██████╗██╗  ██╗
 ╚══██╔══╝    ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║ ██╔╝
    ██║       ███████╗   ██║   ███████║██║     █████╔╝
    ██║       ╚════██║   ██║   ██╔══██║██║     ██╔═██╗
    ██║       ███████║   ██║   ██║  ██║╚██████╗██║  ██╗
    ╚═╝       ╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
 `;

function HomeComponent() {
	const drivers = Route.useLoaderData();
	const { client } = Route.useRouteContext();
	const drivers2 = useQuery(
		getAllDriverOptions({
			client,
			query: { page: 1, limit: 10 },
		}),
	);

	return (
		<div className="container mx-auto max-w-3xl px-4 py-2">
			<pre className="overflow-x-auto font-mono text-sm">{TITLE_TEXT}</pre>
			<div className="grid gap-6">
				<section className="rounded-lg border p-4">
					<h2 className="mb-2 font-medium">API Status</h2>
				</section>
			</div>
			<h3>Drivers</h3>
			{drivers?.map((e) => (
				<div key={e.id}>Driver {e.id}</div>
			))}
			<h3>Drivers 2</h3>
			{drivers2.isPending ? (
				<>Loading</>
			) : (
				<>
					{drivers2.data?.data.map((e) => (
						<div key={e.id}>Driver 2 {e.id}</div>
					))}
				</>
			)}
		</div>
	);
}
