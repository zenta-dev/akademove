import { zodResolver } from "@hookform/resolvers/zod";
import { localizeHref, m } from "@repo/i18n";
import { type SignIn, SignInSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { useCallback, useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { SignUpDialog } from "@/components/dialogs/sign-up-dialog";
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
import { orpcQuery, queryClient } from "@/lib/client/orpc";

export const Route = createFileRoute("/{-$lang}/(auth)/sign-in")({
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const [showPassword, setShowPassword] = useState(false);

	const form = useForm<SignIn>({
		resolver: zodResolver(SignInSchema),
		defaultValues: { email: "", password: "" },
	});

	const mutation = useMutation(
		orpcQuery.auth.signIn.mutationOptions({
			onSuccess: async (data) => {
				toast.success(m.success_placeholder({ action: m.sign_in() }), {
					description: m.welcome_back_placeholder({
						name: data.body.data.user.name,
					}),
				});
				await Promise.all([
					router.invalidate(),
					queryClient.invalidateQueries(),
					router.navigate({ to: localizeHref("/") }),
				]);
			},
			onError: (error) => {
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
		}),
	);

	const onSubmit = useCallback(
		async (values: SignIn) => {
			await mutation.mutateAsync({ body: values });
		},
		[mutation.mutateAsync],
	);

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
											disabled={mutation.isPending}
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
											to="/{-$lang}/forgot-password"
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
												disabled={mutation.isPending}
												{...field}
											/>
											<PasswordToggle
												isVisible={showPassword}
												setIsVisible={setShowPassword}
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
							{mutation.isPending ? <Submitting /> : m.sign_in()}
						</Button>
					</form>
				</Form>
				<div className="mt-6 flex items-center justify-center gap-2 text-sm">
					<p className="text-muted-foreground">{m.dont_have_an_account()}</p>
					<SignUpDialog asChild>
						<p className="text-blue-500 hover:underline">
							{m.create_an_account()}
						</p>
					</SignUpDialog>
				</div>
			</CardContent>
		</Card>
	);
}
