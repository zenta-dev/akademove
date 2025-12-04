import { m } from "@repo/i18n";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { ContactTable } from "@/components/tables/contact/table";
import { Card, CardContent } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";

export const Route = createFileRoute("/dash/operator/contacts")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 12 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.CONTACTS }] }),
	beforeLoad: async () => {
		const ok = await hasAccess({
			contact: ["list", "get", "update", "respond"],
		});
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const search = Route.useSearch();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.contact_us()}</h2>
					<p className="text-muted-foreground">
						Manage and respond to incoming contact requests
					</p>
				</div>
			</div>
			<Tabs defaultValue="all" className="w-full">
				<TabsList className="grid w-full grid-cols-5">
					<TabsTrigger value="all">All</TabsTrigger>
					<TabsTrigger value="pending">Pending</TabsTrigger>
					<TabsTrigger value="reviewing">Reviewing</TabsTrigger>
					<TabsTrigger value="resolved">Resolved</TabsTrigger>
					<TabsTrigger value="closed">Closed</TabsTrigger>
				</TabsList>
				<TabsContent value="all">
					<Card className="p-0">
						<CardContent className="p-0">
							<ContactTable search={search} to="/dash/operator/contacts" />
						</CardContent>
					</Card>
				</TabsContent>
				<TabsContent value="pending">
					<Card className="p-0">
						<CardContent className="p-0">
							<ContactTable
								search={search}
								to="/dash/operator/contacts"
								status="PENDING"
							/>
						</CardContent>
					</Card>
				</TabsContent>
				<TabsContent value="reviewing">
					<Card className="p-0">
						<CardContent className="p-0">
							<ContactTable
								search={search}
								to="/dash/operator/contacts"
								status="REVIEWING"
							/>
						</CardContent>
					</Card>
				</TabsContent>
				<TabsContent value="resolved">
					<Card className="p-0">
						<CardContent className="p-0">
							<ContactTable
								search={search}
								to="/dash/operator/contacts"
								status="RESOLVED"
							/>
						</CardContent>
					</Card>
				</TabsContent>
				<TabsContent value="closed">
					<Card className="p-0">
						<CardContent className="p-0">
							<ContactTable
								search={search}
								to="/dash/operator/contacts"
								status="CLOSED"
							/>
						</CardContent>
					</Card>
				</TabsContent>
			</Tabs>
		</>
	);
}
