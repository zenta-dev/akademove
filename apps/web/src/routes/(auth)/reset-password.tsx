import { zodResolver } from "@hookform/resolvers/zod";
import { localizeHref, m } from "@repo/i18n";
import { type ResetPassword, ResetPasswordSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, redirect, useRouter } from "@tanstack/react-router";
import { zodValidator } from "@tanstack/zod-adapter";
import { useCallback, useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import * as z from "zod";
import { Submitting } from "@/components/misc/submitting";
import { PasswordToggle } from "@/components/toggle/password-toggle";
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
import { orpcQuery, queryClient } from "@/lib/orpc";

export const Route = createFileRoute("/(auth)/reset-password")({
	validateSearch: zodValidator(
		z
			.object({
				token: z.string(),
			})
			.partial(),
	),
	component: RouteComponent,
	beforeLoad: ({ search }) => {
		return search;
	},
	loaderDeps: (c) => {
		return c.search;
	},
});

function RouteComponent() {
	const router = useRouter();
	const { token } = Route.useLoaderDeps();
	const [showNewPassword, setShowNewPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const form = useForm<ResetPassword>({
		resolver: zodResolver(ResetPasswordSchema),
		defaultValues: { newPassword: "", confirmPassword: "", token },
	});

	const mutation = useMutation(
		orpcQuery.auth.resetPassword.mutationOptions({
			onSuccess: async () => {
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.reset_password().toLowerCase()),
					}),
				);
				await Promise.all([
					router.invalidate(),
					queryClient.invalidateQueries(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: (error: BetterAuthClientError) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.reset_password().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occured(),
					},
				);
				form.setError("confirmPassword", { message: error.message });
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: ResetPassword) => {
			await mutation.mutateAsync({ body: values });
		},
		[mutation.mutateAsync],
	);

	if (!token) {
		return redirect({ to: localizeHref("/forgot-password"), throw: true });
	}

	return (
		<Card className="flex min-w-sm flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.reset_password()}</CardTitle>
				<CardDescription>{m.reset_password_desc()}</CardDescription>
			</CardHeader>
			<CardContent>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-6"
					>
						<FormField
							control={form.control}
							name="token"
							render={({ field }) => (
								<FormItem>
									<FormControl>
										<input {...field} className="hidden" />
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="newPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.new_password()}</FormLabel>
									<FormControl>
										<div className="relative">
											<Input
												placeholder="••••••••"
												autoComplete="current-password"
												type={showNewPassword ? "text" : "password"}
												disabled={mutation.isPending}
												{...field}
											/>
											<PasswordToggle
												isVisible={showNewPassword}
												setIsVisible={setShowNewPassword}
												className="-translate-y-1/2 absolute top-1/2 right-0"
												disabled={mutation.isPending}
											/>
										</div>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="confirmPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.confirm_password()}</FormLabel>
									<FormControl>
										<div className="relative">
											<Input
												placeholder="••••••••"
												autoComplete="current-password"
												type={showConfirmPassword ? "text" : "password"}
												disabled={mutation.isPending}
												{...field}
											/>
											<PasswordToggle
												isVisible={showConfirmPassword}
												setIsVisible={setShowConfirmPassword}
												className="-translate-y-1/2 absolute top-1/2 right-0"
												disabled={mutation.isPending}
											/>
										</div>
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
							{mutation.isPending ? <Submitting /> : m.reset_password()}
						</Button>
					</form>
				</Form>
			</CardContent>
		</Card>
	);
}
