import { useQuery } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import { Button } from "@/components/ui/button";
import { client } from "@/lib/api-client";

export const Route = createFileRoute("/")({
	component: HomeComponent,
	loader: async () => {
		const s = await client.drivers.$get({
			query: { page: "1", limit: "10" },
		});
		console.log(await s.json());
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
	const drivers2 = useQuery({
		queryKey: [client.drivers.$url().toString()],
		queryFn: async () => {
			const response = await client.drivers.$get({
				query: { page: "1", limit: "10" },
			});
			const result = await response.json();
			if (result.success) {
				return result.data;
			} else {
				return [];
			}
		},
	});

	async function shit() {
		const response = await client.drivers.$get({
			query: { page: "1", limit: "10" },
		});
		const result = await response.json();
		console.log("SHIT", shit);
		if (result.success) {
			return result.data;
		} else {
			return [];
		}
	}

	return (
		<div className="container mx-auto max-w-3xl px-4 py-2">
			<pre className="overflow-x-auto font-mono text-sm">{TITLE_TEXT}</pre>
			<div className="grid gap-6">
				<section className="rounded-lg border p-4">
					<h2 className="mb-2 font-medium">API Status</h2>
				</section>
			</div>
			<Button onClick={shit}>asdf</Button>

			<h3>Drivers 2</h3>
			{drivers2.isPending ? (
				<>Loading</>
			) : (
				<>
					{drivers2.data?.map((e) => (
						<div key={e.id}>Driver 2 {e.id}</div>
					))}
				</>
			)}
		</div>
	);
}
