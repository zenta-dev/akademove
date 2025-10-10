import { zodResolver } from "@hookform/resolvers/zod";
import { ORPCError } from "@orpc/client";
import { localizeHref, m } from "@repo/i18n";
import { type SignUpDriver, SignUpDriverSchema } from "@repo/schema/auth";
import type { UserGender } from "@repo/schema/user";
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
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { orpcQuery, queryClient } from "@/lib/client/orpc";
import { scrollToField } from "@/utils/form";

export const Route = createFileRoute("/{-$lang}/(auth)/sign-up/driver")({
	component: RouteComponent,
});

function RouteComponent() {
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(SignUpDriverSchema),
		defaultValues: {
			name: "",
			email: "",
			gender: "male" as UserGender,
			phone: "",
			password: "",
			confirmPassword: "",
			detail: {
				studentId: "",
				licenseNumber: "",
			},
			studentCard: undefined,
			driverLicense: undefined,
			vehicleCertificate: undefined,
		},
	});

	const mutation = useMutation(
		orpcQuery.auth.signUpDriver.mutationOptions({
			onSuccess: async () => {
				toast.success(m.success_placeholder({ action: m.driver_sign_up() }));
				await Promise.all([
					router.invalidate(),
					queryClient.invalidateQueries(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: (error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.driver_sign_up().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occured(),
					},
				);

				if (error instanceof ORPCError) {
					const fields = (error.data.fields ?? []) as string[];

					if (fields.includes("email")) {
						form.setError("email", { message: error.message });
						scrollToField("email");
					}

					if (fields.includes("phone")) {
						form.setError("phone", { message: error.message });
						scrollToField("phone");
					}
				}
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: SignUpDriver) => {
			await mutation.mutateAsync({ body: values });
		},
		[mutation.mutateAsync],
	);

	return (
		<Card className="my-4 flex w-full max-w-3xl flex-col gap-2 p-0 pt-4">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.driver_sign_up()}</CardTitle>
				<CardDescription>{m.sign_up_desc()}</CardDescription>
			</CardHeader>
			<CardContent className="p-0 px-4 pb-4">
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<div className="grid grid-cols-1 gap-6 rounded-lg border p-4 md:grid-cols-2">
							<div className="space-y-2 md:col-span-2">
								<p className="font-medium text-md">{m.personal_detail()}</p>
							</div>
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
								name="phone"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.phone()}</FormLabel>
										<FormControl>
											<Input
												placeholder="+6281222333444"
												autoComplete="tel"
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
								name="gender"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.gender()}</FormLabel>
										<Select
											onValueChange={field.onChange}
											defaultValue={field.value}
										>
											<FormControl>
												<SelectTrigger className="w-full">
													<SelectValue placeholder={m.select_your_gender()} />
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												<SelectItem value="male">{m.male()}</SelectItem>
												<SelectItem value="female">{m.female()}</SelectItem>
											</SelectContent>
										</Select>
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
						</div>
						<div className="grid grid-cols-1 gap-6 rounded-lg border p-4 md:grid-cols-2">
							<div className="space-y-2 md:col-span-2">
								<p className="font-medium text-md">{m.driver_detail()}</p>
							</div>
							<FormField
								control={form.control}
								name="detail.studentId"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Student ID</FormLabel>
										<FormControl>
											<Input disabled={mutation.isPending} {...field} />
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.licenseNumber"
								render={({ field }) => (
									<FormItem>
										<FormLabel>License Number</FormLabel>
										<FormControl>
											<Input disabled={mutation.isPending} {...field} />
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="studentCard"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.student_card()}</FormLabel>
										<FormControl>
											<Input
												type="file"
												disabled={mutation.isPending}
												onChange={(e) => {
													const file = e.target.files?.[0];
													field.onChange(file);
												}}
												onBlur={field.onBlur}
												name={field.name}
												ref={field.ref}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="driverLicense"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.driver_license()}</FormLabel>
										<FormControl>
											<Input
												type="file"
												disabled={mutation.isPending}
												onChange={(e) => {
													const file = e.target.files?.[0];
													field.onChange(file);
												}}
												onBlur={field.onBlur}
												name={field.name}
												ref={field.ref}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="vehicleCertificate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.vehicle_certificate()}</FormLabel>
										<FormControl>
											<Input
												type="file"
												disabled={mutation.isPending}
												onChange={(e) => {
													const file = e.target.files?.[0];
													field.onChange(file);
												}}
												onBlur={field.onBlur}
												name={field.name}
												ref={field.ref}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>
						<Button
							type="submit"
							className="w-full"
							disabled={mutation.isPending}
						>
							{mutation.isPending ? <Submitting /> : m.sign_up()}
						</Button>
					</form>
				</Form>
				<div className="mt-4 flex items-center justify-center gap-2 text-sm">
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
