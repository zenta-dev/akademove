import { zodResolver } from "@hookform/resolvers/zod";
import { localizeHref } from "@repo/i18n";
import { type VerifyEmail, VerifyEmailSchema } from "@repo/schema/auth";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, useRouter, useSearch } from "@tanstack/react-router";
import { zodValidator } from "@tanstack/zod-adapter";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import * as z from "zod";
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
import {
	InputOTP,
	InputOTPGroup,
	InputOTPSlot,
} from "@/components/ui/input-otp";
import { orpcQuery, queryClient } from "@/lib/orpc";

const searchSchema = z.object({
	email: z.string().email().optional(),
});

export const Route = createFileRoute("/(auth)/verify-email")({
	validateSearch: zodValidator(searchSchema),
	component: RouteComponent,
});

function RouteComponent() {
	const router = useRouter();
	const { email } = useSearch({ from: "/(auth)/verify-email" });
	const [countdown, setCountdown] = useState(0);

	// Redirect if no email provided
	useEffect(() => {
		if (!email) {
			router.navigate({ to: localizeHref("/sign-in") });
		}
	}, [email, router]);

	// Countdown timer for resend
	useEffect(() => {
		if (countdown > 0) {
			const timer = setTimeout(() => setCountdown(countdown - 1), 1000);
			return () => clearTimeout(timer);
		}
	}, [countdown]);

	const form = useForm({
		resolver: zodResolver(VerifyEmailSchema),
		defaultValues: {
			email: email ?? "",
			code: "",
		},
	});

	// Update email when search param changes
	useEffect(() => {
		if (email) {
			form.setValue("email", email);
		}
	}, [email, form]);

	const verifyMutation = useMutation(
		orpcQuery.auth.verifyEmail.mutationOptions({
			onSuccess: async (body) => {
				toast.success("Email verified successfully!");
				const tasks: Promise<unknown>[] = [
					router.invalidate(),
					queryClient.invalidateQueries(),
				];
				const token = body.body.data.token;
				if (token) {
					tasks.push(router.navigate({ to: "/" }));
				} else {
					tasks.push(router.navigate({ to: localizeHref("/sign-in") }));
				}
				await Promise.all(tasks);
			},
			onError: (error) => {
				toast.error("Verification failed", {
					description: error.message || "Invalid or expired code",
				});
				form.setError("code", { message: error.message });
			},
		}),
	);

	const resendMutation = useMutation(
		orpcQuery.auth.sendEmailVerification.mutationOptions({
			onSuccess: () => {
				toast.success("Verification code sent!", {
					description: "Please check your email for the new code",
				});
				setCountdown(60); // 60 seconds cooldown
				form.setValue("code", ""); // Clear the code field
			},
			onError: (error) => {
				toast.error("Failed to resend code", {
					description: error.message || "Please try again later",
				});
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: VerifyEmail) => {
			await verifyMutation.mutateAsync({ body: values });
		},
		[verifyMutation],
	);

	const handleResend = useCallback(async () => {
		if (!email || countdown > 0) return;
		await resendMutation.mutateAsync({ body: { email } });
	}, [email, countdown, resendMutation]);

	if (!email) {
		return null;
	}

	const isPending = verifyMutation.isPending || resendMutation.isPending;

	return (
		<Card className="flex w-full max-w-md flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">Verify Your Email</CardTitle>
				<CardDescription>
					We've sent a 6-digit verification code to{" "}
					<span className="font-medium text-foreground">{email}</span>
				</CardDescription>
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
									<FormControl>
										<input type="hidden" {...field} />
									</FormControl>
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="code"
							render={({ field }) => (
								<FormItem className="flex flex-col items-center">
									<FormLabel>Verification Code</FormLabel>
									<FormControl>
										<InputOTP
											maxLength={6}
											value={field.value}
											onChange={field.onChange}
											disabled={isPending}
										>
											<InputOTPGroup>
												<InputOTPSlot index={0} />
												<InputOTPSlot index={1} />
												<InputOTPSlot index={2} />
												<InputOTPSlot index={3} />
												<InputOTPSlot index={4} />
												<InputOTPSlot index={5} />
											</InputOTPGroup>
										</InputOTP>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<Button
							type="submit"
							className="w-full"
							disabled={isPending || form.watch("code").length !== 6}
						>
							{verifyMutation.isPending ? <Submitting /> : "Verify Email"}
						</Button>
					</form>
				</Form>

				<div className="mt-6 flex flex-col items-center gap-2 text-sm">
					<p className="text-muted-foreground">Didn't receive the code?</p>
					<Button
						variant="link"
						onClick={handleResend}
						disabled={countdown > 0 || resendMutation.isPending}
						className="h-auto p-0"
					>
						{resendMutation.isPending ? (
							<Submitting />
						) : countdown > 0 ? (
							`Resend code in ${countdown}s`
						) : (
							"Resend code"
						)}
					</Button>
				</div>

				<p className="mt-4 text-center text-muted-foreground text-xs">
					The code will expire in 15 minutes
				</p>
			</CardContent>
		</Card>
	);
}
