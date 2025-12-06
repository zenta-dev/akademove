import { zodResolver } from "@hookform/resolvers/zod";
import { ORPCError } from "@orpc/client";
import { m } from "@repo/i18n";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import { Mail, MailCheck } from "lucide-react";
import { useCallback } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { z } from "zod";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { orpcQuery, queryClient } from "@/lib/orpc";

const newsletterSchema = z.object({
	email: z.string().email("Invalid email address"),
});

type NewsletterForm = z.infer<typeof newsletterSchema>;

export const Route = createFileRoute("/(product)/newsletter")({
	component: NewsletterPage,
});

function NewsletterPage() {
	const form = useForm<NewsletterForm>({
		resolver: zodResolver(newsletterSchema),
		defaultValues: {
			email: "",
		},
	});

	const subscribeMutation = useMutation(
		orpcQuery.newsletter.subscribe.mutationOptions({
			mutationFn: async (data) => {
				const result = await orpcClient.newsletter.subscribe(data);
				if (result.status !== 201) {
					throw new ORPCError(result.body.message);
				}
				return result;
			},
			onSuccess: () => {
				toast.success(m.newsletter_subscribed_successfully());
				form.reset();
				queryClient.invalidateQueries({ queryKey: ["newsletter"] });
			},
			onError: (error) => {
				if (error instanceof ORPCError) {
					toast.error(error.message);
				} else {
					toast.error(m.an_unexpected_error_occurred());
				}
			},
		}),
	);

	const unsubscribeMutation = useMutation(
		orpcQuery.newsletter.unsubscribe.mutationOptions({
			mutationFn: async (data) => {
				const result = await orpcClient.newsletter.unsubscribe(data);
				if (result.status !== 200) {
					throw new ORPCError(result.body.message);
				}
				return result;
			},
			onSuccess: () => {
				toast.success(m.newsletter_unsubscribed_successfully());
				form.reset();
				queryClient.invalidateQueries({ queryKey: ["newsletter"] });
			},
			onError: (error) => {
				if (error instanceof ORPCError) {
					toast.error(error.message);
				} else {
					toast.error(m.an_unexpected_error_occurred());
				}
			},
		}),
	);

	const onSubscribe = useCallback(
		form.handleSubmit(async (data) => {
			subscribeMutation.mutate(data);
		}),
		[],
	);

	const onUnsubscribe = useCallback(
		form.handleSubmit(async (data) => {
			unsubscribeMutation.mutate(data);
		}),
		[],
	);

	return (
		<div className="container mx-auto py-8">
			<div className="mx-auto max-w-md space-y-6">
				<Card>
					<CardHeader className="text-center">
						<CardTitle className="flex items-center justify-center gap-2">
							<Mail className="h-6 w-6" />
							{m.newsletter_subscription()}
						</CardTitle>
						<CardDescription>
							{m.newsletter_subscription_description()}
						</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<Form {...form}>
							<FormField
								control={form.control}
								name="email"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.email()}</FormLabel>
										<FormControl>
											<Input
												type="email"
												placeholder={m.enter_your_email()}
												{...field}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<div className="flex flex-col gap-3 sm:flex-row">
								<Button
									type="button"
									onClick={onSubscribe}
									disabled={subscribeMutation.isPending}
									className="flex-1"
								>
									<Submitting
										isPending={subscribeMutation.isPending}
										text={m.subscribe()}
									>
										<MailCheck className="mr-2 h-4 w-4" />
										{m.subscribe()}
									</Submitting>
								</Button>

								<Button
									type="button"
									variant="outline"
									onClick={onUnsubscribe}
									disabled={unsubscribeMutation.isPending}
									className="flex-1"
								>
									<Submitting
										isPending={unsubscribeMutation.isPending}
										text={m.unsubscribe()}
									>
										<Mail className="mr-2 h-4 w-4" />
										{m.unsubscribe()}
									</Submitting>
								</Button>
							</div>
						</Form>
					</CardContent>
				</Card>
			</div>
		</div>
	);
}
