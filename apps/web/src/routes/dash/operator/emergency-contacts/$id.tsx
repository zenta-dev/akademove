import { useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Loader2 } from "lucide-react";
import { EmergencyContactForm } from "@/components/forms/emergency-contact-form";
import { Card, CardContent } from "@/components/ui/card";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/dash/operator/emergency-contacts/$id")({
	head: () => ({
		meta: [{ title: SUB_ROUTE_TITLES.OPERATOR.EMERGENCY_CONTACTS }],
	}),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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
	const { id } = Route.useParams();
	const navigate = useNavigate();

	if (!allowed) navigate({ to: "/" });

	const contact = useQuery(
		orpcQuery.emergencyContact.get.queryOptions({
			input: { params: { id } },
		}),
	);

	if (contact.isPending) {
		return (
			<div className="flex h-64 items-center justify-center">
				<Loader2 className="h-8 w-8 animate-spin" />
			</div>
		);
	}

	if (contact.isError || !contact.data?.body.data) {
		return (
			<div className="text-center text-red-600">
				An unexpected error occurred
			</div>
		);
	}

	return (
		<div className="mx-auto w-full max-w-3xl">
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">Edit Emergency Contact</h2>
					<p className="text-muted-foreground">
						Update emergency contact details
					</p>
				</div>
			</div>
			<Card className="mt-4">
				<CardContent>
					<EmergencyContactForm
						kind="edit"
						contact={contact.data.body.data}
						onSuccess={async () => {
							navigate({
								to: "/dash/operator/emergency-contacts",
								search: { order: "desc", mode: "offset", limit: 10 },
							});
						}}
					/>
				</CardContent>
			</Card>
		</div>
	);
}
