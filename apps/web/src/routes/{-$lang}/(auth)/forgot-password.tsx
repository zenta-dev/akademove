import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type ForgotPassword, ForgotPasswordSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute } from "@tanstack/react-router";
import { useCallback } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/submitting";
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
import { orpcQuery } from "@/lib/client/orpc";
import type { BetterAuthClientError } from "@/lib/error";

export const Route = createFileRoute("/{-$lang}/(auth)/forgot-password")({
	component: RouteComponent,
});

function RouteComponent() {
	const form = useForm<ForgotPassword>({
		resolver: zodResolver(ForgotPasswordSchema),
		defaultValues: { email: "" },
	});

	const mutation = useMutation(
		orpcQuery.auth.forgotPassword.mutationOptions({
			onSuccess: async () => {
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.forgot_password().toLowerCase()),
					}),
					{
						description: m.please_check_your_email(),
					},
				);
			},
			onError: (error: BetterAuthClientError) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.forgot_password().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occured(),
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
		[mutation.mutateAsync],
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
