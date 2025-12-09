import { zodResolver } from "@hookform/resolvers/zod";
import { localizeHref, m } from "@repo/i18n";
import { type ForgotPassword, ForgotPasswordSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, useRouter } from "@tanstack/react-router";
import { useCallback } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
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
import type { BetterAuthClientError } from "@/lib/error";
import { orpcQuery } from "@/lib/orpc";

export const Route = createFileRoute("/(auth)/forgot-password")({
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(ForgotPasswordSchema),
		defaultValues: { email: "" },
	});

	const mutation = useMutation(
		orpcQuery.auth.forgotPassword.mutationOptions({
			onSuccess: async (_data, variables) => {
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.forgot_password().toLowerCase()),
					}),
					{
						description: m.please_check_your_email(),
					},
				);
				// Navigate to reset-password page with email
				await router.navigate({
					to: localizeHref("/reset-password"),
					search: { email: variables.body.email },
				});
			},
			onError: (error: BetterAuthClientError) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.forgot_password().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
				form.setError("email", { message: error.message });
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: ForgotPassword) => {
			await mutation.mutateAsync({ body: values });
		},
		[mutation],
	);

	return (
		<Card className="flex min-w-sm flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.forgot_password()}</CardTitle>
				<CardDescription>{m.forgot_password_desc()}</CardDescription>
			</CardHeader>
			<CardContent>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-6"
					>
						<FormField
							control={form.control}
							name="email"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.email()}</FormLabel>
									<FormControl>
										<Input
											placeholder="johndoe@gmail.com"
											autoComplete="email"
											type="email"
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<Button
							type="submit"
							className="w-full"
							disabled={mutation.isPending}
						>
							{mutation.isPending ? <Submitting /> : m.forgot_password()}
						</Button>
					</form>
				</Form>
			</CardContent>
		</Card>
	);
}
