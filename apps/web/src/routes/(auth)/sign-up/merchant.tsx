import { zodResolver } from "@hookform/resolvers/zod";
import { ORPCError } from "@orpc/client";
import { localizeHref, m } from "@repo/i18n";
import { type SignUpMerchant, SignUpMerchantSchema } from "@repo/schema/auth";
import { CONSTANTS } from "@repo/schema/constants";
import type { UserGender } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, Link, useRouter } from "@tanstack/react-router";
import { X } from "lucide-react";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { MapWrapper } from "@/components/misc/map-wrapper";
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
import { Checkbox } from "@/components/ui/checkbox";
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
import { Textarea } from "@/components/ui/textarea";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";
import { createPhotoPreviewUrl } from "@/utils/file";
import { scrollToField } from "@/utils/form";

export const Route = createFileRoute("/(auth)/sign-up/merchant")({
	component: RouteComponent,
});

function RouteComponent() {
	const [photoPreview, setPhotoPreview] = useState<string | undefined>();
	const [documentPreview, setDocumentPreview] = useState<string | undefined>();
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);
	const [copyPersonal, setCopyPersonal] = useState(false);

	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(SignUpMerchantSchema),
		defaultValues: {
			name: "",
			email: "",
			gender: "male" as UserGender,
			phone: "",
			password: "",
			confirmPassword: "",
			document: undefined,
			detail: {
				bank: { provider: "", number: "" },
				name: "",
				email: "",
				phone: "",
				address: "",
				type: "merchant",
				location: undefined,
			},
		},
	});

	const mutation = useMutation(
		orpcQuery.auth.signUpMerchant.mutationOptions({
			onSuccess: async () => {
				toast.success(m.success_placeholder({ action: m.merchant_sign_up() }));
				await Promise.all([
					router.invalidate(),
					queryClient.invalidateQueries(),
					// router.navigate({ to: localizeHref("/sign-in") }),
				]);
			},
			onError: (error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.merchant_sign_up().toLowerCase()),
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
		async (values: SignUpMerchant) => {
			console.error("FORM ERROR", form.formState.errors);
			await mutation.mutateAsync({ body: values });
		},
		[mutation.mutateAsync, form.formState.errors],
	);

	useEffect(() => {
		if (copyPersonal) {
			const subscription = form.watch((value, { name }) => {
				if (name === "email") {
					form.setValue("detail.email", value.email || "");
				}
				if (name === "phone") {
					form.setValue("detail.phone", value.phone || "");
				}
			});

			const values = form.getValues();
			form.setValue("detail.email", values.email);
			form.setValue("detail.phone", values.phone);

			return () => subscription.unsubscribe();
		}
	}, [copyPersonal, form]);

	return (
		<Card className="my-4 flex w-full max-w-3xl flex-col gap-2 p-0 pt-4">
			<CardHeader className="text-center">
				<CardTitle className="text-xl">{m.merchant_sign_up()}</CardTitle>
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
								<p className="font-medium text-md">{m.merchant_detail()}</p>
								<div className="flex items-center gap-2">
									<Checkbox
										checked={copyPersonal}
										className="cursor-pointer"
										onCheckedChange={(checked) => {
											return checked
												? setCopyPersonal(true)
												: setCopyPersonal(false);
										}}
									/>
									<button
										className="cursor-pointer text-sm"
										onClick={() => setCopyPersonal(!copyPersonal)}
										type="button"
									>
										{m.copy_from_personal_data()}
									</button>
								</div>
							</div>
							<FormField
								control={form.control}
								name="detail.name"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.name()}</FormLabel>
										<FormControl>
											<Input disabled={mutation.isPending} {...field} />
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.email"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.email()}</FormLabel>
										<FormControl>
											<Input
												disabled={copyPersonal ?? mutation.isPending}
												{...field}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.phone"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.phone()}</FormLabel>
										<FormControl>
											<Input
												disabled={copyPersonal ?? mutation.isPending}
												{...field}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.type"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.type()}</FormLabel>
										<Select
											onValueChange={field.onChange}
											defaultValue={field.value}
										>
											<FormControl>
												<SelectTrigger className="w-full">
													<SelectValue
														placeholder={m.select_your_bank_provider()}
													/>
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												{CONSTANTS.MERCHANT_TYPES.map((val) => (
													<SelectItem key={val} value={val}>
														{capitalizeFirstLetter(val)}
													</SelectItem>
												))}
											</SelectContent>
										</Select>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="document"
								render={({ field }) => (
									<FormItem className="md:col-span-2">
										<FormLabel>{m.government_document()}</FormLabel>
										<FormControl>
											<div className="relative mx-auto h-48 w-full overflow-hidden rounded-md">
												<Button
													type="button"
													variant="ghost"
													size="icon"
													className="absolute top-2 right-2 z-10"
													onClick={() => {
														field.onChange(undefined);
														setDocumentPreview(undefined);
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
																onSuccess: setDocumentPreview,
															});
															field.onChange(files[0]);
														}
													}}
													onError={(err) => {
														form.setError("document", {
															message: err.message,
														});
													}}
													src={field.value ? [field.value] : undefined}
													className={cn("relative z-0", field.value && "p-0")}
												>
													<DropzoneEmptyState />
													<DropzoneContent className="h-48 w-full">
														{documentPreview && (
															<div className="relative h-48 w-full">
																<img
																	alt="Preview"
																	src={documentPreview}
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
								name="detail.bank.provider"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.bank_provider()}</FormLabel>
										<Select
											onValueChange={field.onChange}
											defaultValue={field.value}
										>
											<FormControl>
												<SelectTrigger className="w-full">
													<SelectValue
														placeholder={m.select_your_bank_provider()}
													/>
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												{CONSTANTS.BANK_PROVIDERS.map((val) => (
													<SelectItem key={val} value={val}>
														{val}
													</SelectItem>
												))}
											</SelectContent>
										</Select>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.bank.number"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.bank_number()}</FormLabel>
										<FormControl>
											<Input disabled={mutation.isPending} {...field} />
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="detail.address"
								render={({ field }) => (
									<FormItem className="md:col-span-2">
										<FormLabel>{m.address()}</FormLabel>
										<FormControl>
											<Textarea disabled={mutation.isPending} {...field} />
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="detail.location"
								render={({ field }) => (
									<FormItem className="md:col-span-2">
										<FormLabel>{m.pin_point()}</FormLabel>
										<FormControl>
											<MapWrapper
												value={field.value}
												onLocationChange={field.onChange}
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
