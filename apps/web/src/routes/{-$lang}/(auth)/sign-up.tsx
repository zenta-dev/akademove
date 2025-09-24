import { zodResolver } from "@hookform/resolvers/zod";
import { localizeHref, m } from "@repo/i18n";
import { type SignUp, SignUpSchema } from "@repo/schema/auth";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { useCallback, useState } from "react";
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
import { authClient } from "@/lib/client/auth";
import { queryClient } from "@/lib/client/orpc";
import { BetterAuthClientError } from "@/lib/error";

export const Route = createFileRoute("/{-$lang}/(auth)/sign-up")({
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const form = useForm<SignUp>({
		resolver: zodResolver(SignUpSchema),
		defaultValues: { name: "", email: "", password: "", confirmPassword: "" },
	});

	const mutation = useMutation({
		mutationFn: async (credentials: SignUp) => {
			const { error, data } = await authClient.signUp.email({
				...credentials,
				role: "user",
			});
			if (error) throw new BetterAuthClientError(error.message, error);
			return data;
		},
		onSuccess: async () => {
			toast.success(m.success_placeholder({ action: m.sign_up() }));
			await Promise.all([
				router.invalidate(),
				queryClient.invalidateQueries(),
				router.navigate({ to: localizeHref("/sign-in") }),
			]);
		},
		onError: (error: BetterAuthClientError) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.sign_up().toLowerCase()),
				}),
				{
					description: error.message || m.an_unexpected_error_occured(),
				},
			);
			if (error.code === "USER_ALREADY_EXISTS_USE_ANOTHER_EMAIL") {
				form.setError("email", { message: error.message });
			} else {
				form.setError("confirmPassword", { message: error.message });
			}
		},
	});

	const onSubmit = useCallback(
		async (values: SignUp) => {
			await mutation.mutateAsync(values);
		},
		[mutation.mutateAsync],
	);

	return (
		<Card className="flex min-w-sm flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.sign_up()}</CardTitle>
				<CardDescription>{m.sign_up_desc()}</CardDescription>
			</CardHeader>
			<CardContent>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-6"
					>
						<FormField
							control={form.control}
							name="name"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.name()}</FormLabel>
									<FormControl>
										<Input
											placeholder="John Doe"
											autoComplete="name"
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
							name="email"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.email()}</FormLabel>
									<FormControl>
										<Input
											placeholder="johndoe@gmail.com"
											autoComplete="email"
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
									<FormLabel>{m.password()}</FormLabel>
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
							{mutation.isPending ? <Submitting /> : m.sign_up()}
						</Button>
					</form>
				</Form>
				<div className="mt-6 flex items-center justify-center gap-2 text-sm">
					<p className="text-muted-foreground">{m.already_have_an_account()}</p>
					<Link
						to={localizeHref("/sign-in")}
						className="text-blue-500 hover:underline"
					>
						{m.sign_in_here()}
					</Link>
				</div>
			</CardContent>
		</Card>
	);
}
