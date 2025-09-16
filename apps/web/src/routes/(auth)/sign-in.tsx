import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type SignIn, SignInSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/submitting";
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
import { authClient } from "@/lib/auth-client";
import { BetterAuthClientError } from "@/lib/error";

export const Route = createFileRoute("/(auth)/sign-in")({
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const [showPassword, setShowPassword] = useState(false);

	const form = useForm<SignIn>({
		resolver: zodResolver(SignInSchema),
		defaultValues: { email: "", password: "" },
	});

	const signInMutation = useMutation({
		mutationFn: async (credentials: SignIn) => {
			const { error, data } = await authClient.signIn.email(credentials);
			if (error) throw new BetterAuthClientError(error.message, error);
			return data;
		},
		onSuccess: async (data) => {
			const result = await authClient.getSession();
			if (result.error || !result.data) {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.sign_in().toLowerCase()),
					}),
				);
				return;
			}
			toast.success(m.success_placeholder({ action: m.sign_in() }), {
				description: m.welcome_back_placeholder({
					name: result.data.user.name,
				}),
			});
			if (data?.redirect && data?.url) {
				await router.navigate({ to: data.url });
			} else {
				await router.navigate({ to: "/" });
			}
		},
		onError: (error: BetterAuthClientError) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.sign_in().toLowerCase()),
				}),
				{
					description: error.message || m.an_unexpected_error_occured(),
				},
			);
			form.setError("password", { message: error.message });
		},
	});

	const onSubmit = async (values: SignIn) => {
		await signInMutation.mutateAsync(values);
	};

	return (
		<Card className="flex min-w-sm flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.sign_in()}</CardTitle>
				<CardDescription>{m.sign_in_desc()}</CardDescription>
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
											disabled={signInMutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="password"
							render={({ field }) => (
								<FormItem>
									<div className="flex items-center justify-between">
										<FormLabel>{m.password()}</FormLabel>
										<Link
											to="/forgot-password"
											className="text-blue-500 text-sm hover:underline"
										>
											{m.forgot_password()}?
										</Link>
									</div>
									<FormControl>
										<div className="relative">
											<Input
												placeholder="••••••••"
												autoComplete="current-password"
												type={showPassword ? "text" : "password"}
												disabled={signInMutation.isPending}
												{...field}
											/>
											<PasswordToggle
												isVisible={showPassword}
												setIsVisible={setShowPassword}
												className="-translate-y-1/2 absolute top-1/2 right-0"
												disabled={signInMutation.isPending}
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
							disabled={signInMutation.isPending}
						>
							{signInMutation.isPending ? <Submitting /> : m.sign_in()}
						</Button>
					</form>
				</Form>
				<div className="mt-6 flex items-center justify-center gap-2 text-sm">
					<p className="text-muted-foreground">{m.dont_have_an_account()}</p>
					<Link to="/sign-up" className="text-blue-500 hover:underline">
						{m.create_an_account()}
					</Link>
				</div>
			</CardContent>
		</Card>
	);
}
