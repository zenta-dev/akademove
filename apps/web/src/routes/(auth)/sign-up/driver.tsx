import { zodResolver } from "@hookform/resolvers/zod";
import { ORPCError } from "@orpc/client";
import { localizeHref, m } from "@repo/i18n";
import {
	type FlatSignUpDriver,
	FlatSignUpDriverSchema,
} from "@repo/schema/auth";
import type { UserGender } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { X } from "lucide-react";
import { useCallback, useState } from "react";
import { useForm } from "react-hook-form";
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

export const Route = createFileRoute("/(auth)/sign-up/driver")({
	component: RouteComponent,
});

function RouteComponent() {
	const [photoPreview, setPhotoPreview] = useState<string | undefined>();
	const [studentCardPreview, setStudentCardPreview] = useState<
		string | undefined
	>();
	const [driverLicensePreview, setDriverLicensePreview] = useState<
		string | undefined
	>();
	const [vehicleCertificatePreview, setvehicleCertificatePreview] = useState<
		string | undefined
	>();
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(FlatSignUpDriverSchema),
		defaultValues: {
			name: "",
			email: "",
			gender: "male" as UserGender,
			phone: "",
			password: "",
			confirmPassword: "",
			detail_studentId: "",
			detail_licenseNumber: "",
			detail_studentCard: undefined,
			detail_driverLicense: undefined,
			detail_vehicleCertificate: undefined,
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
						form.setError("phone", { message: error.message });
						scrollToField("phone");
					}
				}
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: FlatSignUpDriver) => {
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
								name="photo"
								render={({ field }) => (
									<FormItem className="md:col-span-2">
										<FormLabel className="mx-auto">{m.photo()}</FormLabel>
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
								name="detail_studentId"
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
								name="detail_licenseNumber"
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
								name="detail_studentCard"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.student_card()}</FormLabel>
										<FormControl>
											<div className="relative mx-auto h-48 w-full overflow-hidden rounded-md">
												<Button
													type="button"
													variant="ghost"
													size="icon"
													className="absolute top-2 right-2 z-10"
													onClick={() => {
														field.onChange(undefined);
														setStudentCardPreview(undefined);
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
																onSuccess: setStudentCardPreview,
															});
															field.onChange(files[0]);
														}
													}}
													onError={(err) => {
														form.setError("detail_studentCard", {
															message: err.message,
														});
													}}
													src={field.value ? [field.value] : undefined}
													className={cn("relative z-0", field.value && "p-0")}
												>
													<DropzoneEmptyState />
													<DropzoneContent className="h-48 w-full">
														{studentCardPreview && (
															<div className="relative h-48 w-full">
																<img
																	alt="Preview"
																	src={studentCardPreview}
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
								name="detail_driverLicense"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.driver_license()}</FormLabel>
										<FormControl>
											<div className="relative mx-auto h-48 w-full overflow-hidden rounded-md">
												<Button
													type="button"
													variant="ghost"
													size="icon"
													className="absolute top-2 right-2 z-10"
													onClick={() => {
														field.onChange(undefined);
														setDriverLicensePreview(undefined);
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
																onSuccess: setDriverLicensePreview,
															});
															field.onChange(files[0]);
														}
													}}
													onError={(err) => {
														form.setError("detail_driverLicense", {
															message: err.message,
														});
													}}
													src={field.value ? [field.value] : undefined}
													className={cn("relative z-0", field.value && "p-0")}
												>
													<DropzoneEmptyState />
													<DropzoneContent className="h-48 w-full">
														{driverLicensePreview && (
															<div className="relative h-48 w-full">
																<img
																	alt="Preview"
																	src={driverLicensePreview}
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
								name="detail_vehicleCertificate"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.vehicle_certificate()}</FormLabel>
										<FormControl>
											<div className="relative mx-auto h-48 w-full overflow-hidden rounded-md">
												<Button
													type="button"
													variant="ghost"
													size="icon"
													className="absolute top-2 right-2 z-10"
													onClick={() => {
														field.onChange(undefined);
														setvehicleCertificatePreview(undefined);
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
																onSuccess: setvehicleCertificatePreview,
															});
															field.onChange(files[0]);
														}
													}}
													onError={(err) => {
														form.setError("detail_vehicleCertificate", {
															message: err.message,
														});
													}}
													src={field.value ? [field.value] : undefined}
													className={cn("relative z-0", field.value && "p-0")}
												>
													<DropzoneEmptyState />
													<DropzoneContent className="h-48 w-full">
														{vehicleCertificatePreview && (
															<div className="relative h-48 w-full">
																<img
																	alt="Preview"
																	src={vehicleCertificatePreview}
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
