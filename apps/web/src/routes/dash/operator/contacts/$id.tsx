import { m } from "@repo/i18n";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { ArrowLeft, Mail, Send, User } from "lucide-react";
import { useState } from "react";
import { toast } from "sonner";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { hasAccess } from "@/lib/actions";
import { APP_NAME } from "@/lib/constants";
import { orpcClient, orpcQuery } from "@/lib/orpc";
import { cn } from "@/utils/cn";

export const Route = createFileRoute("/dash/operator/contacts/$id")({
	head: () => ({ meta: [{ title: `${m.contact_us()} - ${APP_NAME}` }] }),
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
	const queryClient = useQueryClient();

	const [response, setResponse] = useState("");
	const [status, setStatus] = useState<
		"PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED"
	>("RESOLVED");

	const contact = useQuery(
		orpcQuery.contact.getById.queryOptions({
			input: { params: { id } },
		}),
	);

	const respondMutation = useMutation(
		orpcQuery.contact.respond.mutationOptions({
			mutationFn: async (input: {
				params: { id: string };
				body: {
					response: string;
					status?: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
				};
			}) => {
				const result = await orpcClient.contact.respond(input);
				if (result.status !== 200) {
					throw new Error(result.body.message || "Failed to send response");
				}
				return result;
			},
			onSuccess: () => {
				queryClient.invalidateQueries();
				toast.success("Response sent and email delivered to user");
				setResponse("");
				navigate({
					to: "/dash/operator/contacts",
					search: { page: 1, limit: 12, order: "desc", mode: "offset" },
				});
			},
			onError: (error: Error) => {
				toast.error(error.message || "Failed to send response");
			},
		}),
	);

	if (!allowed) {
		navigate({ to: "/" });
		return null;
	}

	const handleSubmit = (e: React.FormEvent) => {
		e.preventDefault();
		if (!response.trim()) {
			toast.error("Please enter a response");
			return;
		}
		respondMutation.mutate({
			params: { id },
			body: { response: response.trim(), status },
		});
	};

	const contactData = contact.data?.body.data;

	return (
		<div className="space-y-6">
			{/* Header */}
			<div className="flex items-center justify-between">
				<Button
					variant="ghost"
					size="sm"
					onClick={() =>
						navigate({
							to: "/dash/operator/contacts",
							search: { page: 1, limit: 12, order: "desc", mode: "offset" },
						})
					}
				>
					<ArrowLeft className="mr-2 h-4 w-4" />
					Back
				</Button>
			</div>

			{contact.isPending && (
				<div className="flex items-center justify-center py-12">
					<div className="text-muted-foreground">Loading...</div>
				</div>
			)}

			{contact.isError && (
				<Card>
					<CardContent className="py-12 text-center">
						<p className="text-muted-foreground">
							Failed to load contact. Please try again.
						</p>
					</CardContent>
				</Card>
			)}

			{contactData && (
				<div className="grid gap-6 lg:grid-cols-3">
					{/* Contact Details */}
					<Card className="lg:col-span-2">
						<CardHeader>
							<div className="flex items-center justify-between">
								<CardTitle>{contactData.subject}</CardTitle>
								<Badge
									variant="secondary"
									className={cn(
										"bg-yellow-500/10 text-yellow-500 dark:bg-yellow-600/10 dark:text-yellow-600",
										contactData.status === "REVIEWING" &&
											"bg-blue-500/10 text-blue-500 dark:bg-blue-600/10 dark:text-blue-600",
										contactData.status === "RESOLVED" &&
											"bg-green-500/10 text-green-500 dark:bg-green-600/10 dark:text-green-600",
										contactData.status === "CLOSED" &&
											"bg-gray-500/10 text-gray-500 dark:bg-gray-600/10 dark:text-gray-600",
									)}
								>
									{contactData.status}
								</Badge>
							</div>
						</CardHeader>
						<CardContent className="space-y-6">
							<div>
								<Label className="text-muted-foreground text-sm">Message</Label>
								<div className="mt-2 whitespace-pre-wrap rounded-lg bg-muted p-4">
									{contactData.message}
								</div>
							</div>

							{contactData.response && (
								<div>
									<Label className="text-muted-foreground text-sm">
										Your Response
									</Label>
									<div className="mt-2 whitespace-pre-wrap rounded-lg border border-primary/20 bg-primary/5 p-4">
										{contactData.response}
									</div>
									{contactData.respondedAt && (
										<p className="mt-2 text-muted-foreground text-xs">
											Responded on{" "}
											{new Date(contactData.respondedAt).toLocaleDateString(
												"id-ID",
												{
													day: "numeric",
													month: "long",
													year: "numeric",
													hour: "2-digit",
													minute: "2-digit",
												},
											)}
										</p>
									)}
								</div>
							)}

							{/* Response Form */}
							<form onSubmit={handleSubmit} className="space-y-4">
								<Alert className="border-blue-200 bg-blue-50 dark:border-blue-900 dark:bg-blue-950">
									<Mail className="h-4 w-4 text-blue-600 dark:text-blue-400" />
									<AlertDescription className="text-blue-700 dark:text-blue-300">
										Your response will be sent via email to{" "}
										<strong>{contactData.email}</strong>
									</AlertDescription>
								</Alert>

								<div className="space-y-2">
									<Label htmlFor="response">
										{contactData.response
											? "Add Another Response"
											: "Your Response"}
									</Label>
									<Textarea
										id="response"
										rows={6}
										value={response}
										onChange={(e) => setResponse(e.target.value)}
										placeholder="Type your response here..."
										className="resize-none"
									/>
								</div>

								<div className="space-y-2">
									<Label htmlFor="status">{m.status()}</Label>
									<Select
										value={status}
										onValueChange={(v) =>
											setStatus(
												v as "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED",
											)
										}
									>
										<SelectTrigger>
											<SelectValue />
										</SelectTrigger>
										<SelectContent>
											<SelectItem value="PENDING">Pending</SelectItem>
											<SelectItem value="REVIEWING">Reviewing</SelectItem>
											<SelectItem value="RESOLVED">Resolved</SelectItem>
											<SelectItem value="CLOSED">Closed</SelectItem>
										</SelectContent>
									</Select>
								</div>

								<Button
									type="submit"
									className="w-full"
									disabled={respondMutation.isPending || !response.trim()}
								>
									<Send className="mr-2 h-4 w-4" />
									{respondMutation.isPending
										? "Sending..."
										: "Send Response via Email"}
								</Button>
							</form>
						</CardContent>
					</Card>

					{/* Contact Info Sidebar */}
					<div className="space-y-4">
						<Card>
							<CardHeader>
								<CardTitle className="text-base">Contact Information</CardTitle>
							</CardHeader>
							<CardContent className="space-y-4">
								<div className="flex items-start gap-3">
									<User className="mt-1 h-5 w-5 text-muted-foreground" />
									<div>
										<Label className="text-muted-foreground text-sm">
											Name
										</Label>
										<p className="font-medium">{contactData.name}</p>
									</div>
								</div>

								<div className="flex items-start gap-3">
									<Mail className="mt-1 h-5 w-5 text-muted-foreground" />
									<div>
										<Label className="text-muted-foreground text-sm">
											Email
										</Label>
										<p className="break-all font-medium">{contactData.email}</p>
									</div>
								</div>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle className="text-base">Submission Details</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								<div>
									<Label className="text-muted-foreground text-sm">
										Submitted
									</Label>
									<p className="font-medium">
										{new Date(contactData.createdAt).toLocaleDateString(
											"id-ID",
											{
												day: "numeric",
												month: "long",
												year: "numeric",
												hour: "2-digit",
												minute: "2-digit",
											},
										)}
									</p>
								</div>

								{contactData.userId && (
									<div>
										<Label className="text-muted-foreground text-sm">
											User ID
										</Label>
										<p className="break-all font-medium font-mono text-xs">
											{contactData.userId}
										</p>
									</div>
								)}
							</CardContent>
						</Card>
					</div>
				</div>
			)}
		</div>
	);
}
