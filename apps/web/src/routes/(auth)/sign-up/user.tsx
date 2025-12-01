import { zodResolver } from "@hookform/resolvers/zod";
import { ORPCError } from "@orpc/client";
import { localizeHref, m } from "@repo/i18n";
import { type FlatSignUp, FlatSignUpSchema } from "@repo/schema/auth";
import type { CountryCode } from "@repo/schema/common";
import type { UserGender } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { X } from "lucide-react";
import { useCallback, useState } from "react";
import { useForm } from "react-hook-form";
import { parsePhoneNumber } from "react-phone-number-input";
import { toast } from "sonner";
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
import { PhoneInput } from "@/components/ui/phone-input";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import {
	Dropzone,
	DropzoneContent,
	DropzoneEmptyState,
} from "@/components/ui/shadcn-io/dropzone";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";
import { createPhotoPreviewUrl } from "@/utils/file";
import { scrollToField } from "@/utils/form";

export const Route = createFileRoute("/(auth)/sign-up/user")({
	component: RouteComponent,
});

function RouteComponent() {
	const [photoPreview, setPhotoPreview] = useState<string | undefined>();
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);
	const router = useRouter();

	const mutation = useMutation(
		orpcQuery.auth.signUpUser.mutationOptions({
			onSuccess: async () => {
				toast.success(m.success_placeholder({ action: m.customer_sign_up() }));
				await Promise.all([
					router.invalidate(),
					queryClient.invalidateQueries(),
					router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: (error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.customer_sign_up().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);

				if (error instanceof ORPCError) {
					const fields = (error.data.fields ?? []) as string[];

					if (fields.includes("email")) {
						form.setError("email", { message: error.message });
						scrollToField("email");
					}

					if (fields.includes("phone")) {
						form.setError("phone_number", { message: error.message });
						scrollToField("phone");
					}
				}
			},
		}),
	);

	const form = useForm({
		disabled: mutation.isPending,
		resolver: zodResolver(FlatSignUpSchema),
		defaultValues: {
			name: "",
			email: "",
			gender: "MALE",
			phone_countryCode: "ID",
			phone_number: 0,
			password: "",
			confirmPassword: "",
		},
	});

	const onSubmit = useCallback(
		async (values: FlatSignUp) => {
			await mutation.mutateAsync({ body: values });
		},
		[mutation.mutateAsync],
	);

	return (
		<Card className="my-4 flex w-full max-w-md flex-col gap-2">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.customer_sign_up()}</CardTitle>
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
							name="photo"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.photo()}</FormLabel>
									<FormControl>
										<div className="relative mx-auto h-48 w-48 overflow-hidden rounded-md">
											<Button
												type="button"
												variant="ghost"
												size="icon"
												className="absolute top-2 right-2 z-10"
												onClick={() => {
													field.onChange(undefined);
													setPhotoPreview(undefined);
												}}
											>
												<X />
												<span className="sr-only">{m.remove_file()}</span>
											</Button>

											<Dropzone
												accept={{
													"image/jpeg": [".jpeg", ".jpg"],
													"image/png": [".png"],
												}}
												onDrop={(files) => {
													if (files.length > 0) {
														createPhotoPreviewUrl(files, {
															onSuccess: setPhotoPreview,
														});
														field.onChange(files[0]);
													}
												}}
												onError={(err) => {
													form.setError("photo", { message: err.message });
												}}
												src={field.value ? [field.value] : undefined}
												className={cn("relative z-0", field.value && "p-0")}
											>
												<DropzoneEmptyState />
												<DropzoneContent className="h-48 w-48">
													{photoPreview && (
														<div className="relative h-48 w-48">
															<img
																alt="Preview"
																src={photoPreview}
																className="absolute inset-0 h-full w-full object-cover"
															/>
														</div>
													)}
												</DropzoneContent>
											</Dropzone>
										</div>
									</FormControl>

									<FormMessage />
								</FormItem>
							)}
						/>
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
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="phone_number"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.phone()}</FormLabel>
									<FormControl>
										<PhoneInput
											countries={["ID"]}
											defaultCountry={"ID"}
											name={field.name}
											disabled={field.disabled}
											onCountryChange={(val) => {
												if (val)
													form.setValue(
														"phone_countryCode",
														val as CountryCode,
													);
											}}
											onChange={(val) => {
												const parse = parsePhoneNumber(val);
												if (parse) {
													form.setValue(
														"phone_number",
														Number(parse.nationalNumber),
													);
													if (parse.country)
														form.setValue(
															"phone_countryCode",
															parse.country as CountryCode,
														);
												}
											}}
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
											<SelectItem value="MALE">{m.male()}</SelectItem>
											<SelectItem value="FEMALE">{m.female()}</SelectItem>
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

						<Button type="submit" className="w-full">
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
