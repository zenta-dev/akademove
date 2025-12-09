import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { CountryCode } from "@repo/schema/common";
import { CONSTANTS } from "@repo/schema/constants";
import { FlatUpdateMerchantSchema, type Merchant } from "@repo/schema/merchant";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Mail, MapPin, Phone, Store, X } from "lucide-react";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { parsePhoneNumber } from "react-phone-number-input";
import { toast } from "sonner";
import { MapWrapper } from "@/components/misc/map-wrapper";
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
import { Skeleton } from "@/components/ui/skeleton";
import { Textarea } from "@/components/ui/textarea";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { useMyMerchant } from "@/providers/merchant";
import { cn } from "@/utils/cn";
import { createPhotoPreviewUrl } from "@/utils/file";

export const Route = createFileRoute("/dash/merchant/profile")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.MERCHANT.PROFILE }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["MERCHANT"]);
		if (!ok) redirect({ to: "/", throw: true });
		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	const merchant = useMyMerchant();
	const [isEditing, setIsEditing] = useState(false);

	if (!allowed) navigate({ to: "/" });

	if (merchant.isLoading) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						{m.manage_your_merchant_profile()}
					</p>
				</div>
				<Skeleton className="h-[600px] w-full" />
			</>
		);
	}

	if (merchant.isError || !merchant.value) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						{m.manage_your_merchant_profile()}
					</p>
				</div>
				<Card>
					<CardContent className="p-8 text-center text-muted-foreground">
						{m.failed_to_load_merchant_profile()}
					</CardContent>
				</Card>
			</>
		);
	}

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						{m.manage_your_merchant_profile()}
					</p>
				</div>
				<Button
					variant={isEditing ? "outline" : "default"}
					onClick={() => setIsEditing(!isEditing)}
				>
					{isEditing ? m.cancel() : m.edit_profile()}
				</Button>
			</div>

			{isEditing ? (
				<EditMerchantProfile
					merchant={merchant.value}
					onCancel={() => setIsEditing(false)}
					onSuccess={() => setIsEditing(false)}
				/>
			) : (
				<ViewMerchantProfile merchant={merchant.value} />
			)}
		</>
	);
}

function ViewMerchantProfile({ merchant }: { merchant: Merchant }) {
	return (
		<div className="grid gap-4 md:grid-cols-2">
			<Card>
				<CardHeader>
					<CardTitle>{m.business_information()}</CardTitle>
					<CardDescription>{m.your_merchant_details()}</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					<div className="flex items-center gap-3">
						<Store className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">
								{m.business_name()}
							</p>
							<p className="font-medium">{merchant.name}</p>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<Mail className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.email()}</p>
							<p className="font-medium">{merchant.email}</p>
						</div>
					</div>
					{merchant.phone && (
						<div className="flex items-center gap-3">
							<Phone className="h-5 w-5 text-muted-foreground" />
							<div>
								<p className="text-muted-foreground text-sm">{m.phone()}</p>
								<p className="font-medium">
									+{merchant.phone.countryCode} {merchant.phone.number}
								</p>
							</div>
						</div>
					)}
					<div className="flex items-center gap-3">
						<MapPin className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.address()}</p>
							<p className="font-medium">{merchant.address}</p>
						</div>
					</div>
					<div>
						<p className="text-muted-foreground text-sm">{m.category()}</p>
						<p className="font-medium">
							{capitalizeFirstLetter(merchant.category)}
						</p>
					</div>
				</CardContent>
			</Card>

			<Card>
				<CardHeader>
					<CardTitle>{m.bank_information()}</CardTitle>
					<CardDescription>{m.your_payment_details()}</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					<div>
						<p className="text-muted-foreground text-sm">{m.bank_provider()}</p>
						<p className="font-medium">{merchant.bank.provider}</p>
					</div>
					<div>
						<p className="text-muted-foreground text-sm">{m.bank_number()}</p>
						<p className="font-medium">{merchant.bank.number}</p>
					</div>
				</CardContent>
			</Card>

			{merchant.image && (
				<Card>
					<CardHeader>
						<CardTitle>{m.merchant_photo()}</CardTitle>
					</CardHeader>
					<CardContent>
						<img
							src={merchant.image}
							alt={merchant.name}
							className="h-48 w-48 rounded-lg object-cover"
						/>
					</CardContent>
				</Card>
			)}

			{merchant.location && (
				<Card>
					<CardHeader>
						<CardTitle>{m.location()}</CardTitle>
					</CardHeader>
					<CardContent>
						<MapWrapper
							value={{
								lat: merchant.location.y,
								lng: merchant.location.x,
							}}
							onLocationChange={() => {}}
						/>
					</CardContent>
				</Card>
			)}
		</div>
	);
}

function EditMerchantProfile({
	merchant,
	onCancel,
	onSuccess,
}: {
	merchant: Merchant;
	onCancel: () => void;
	onSuccess: () => void;
}) {
	const [imagePreview, setImagePreview] = useState<string | undefined>(
		merchant.image,
	);

	const form = useForm({
		resolver: zodResolver(FlatUpdateMerchantSchema),
		defaultValues: {
			name: merchant.name || "",
			email: merchant.email || "",
			phone_countryCode: (merchant.phone?.countryCode || "ID") as CountryCode,
			phone_number: merchant.phone?.number || 0,
			address: merchant.address || "",
			location_x: merchant.location?.x || 0,
			location_y: merchant.location?.y || 0,
			category: merchant.category || "FOOD",
			bank_provider: merchant.bank?.provider || "BCA",
			bank_number: merchant.bank?.number || 0,
			image: undefined,
		},
	});

	const mutation = useMutation(
		orpcQuery.merchant.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries(
					// 	{
					// 	queryKey: orpcQuery.merchant.getMine.queryKey(),
					// }
				);
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.update_profile().toLowerCase()),
					}),
				);
				onSuccess();
			},
			onError: (error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.update_profile().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			const parsed = FlatUpdateMerchantSchema.safeParse(values);
			if (parsed.success) {
				await mutation.mutateAsync({
					params: { id: merchant.id },
					body: parsed.data,
				});
			}
		},
		[mutation, merchant.id],
	);

	useEffect(() => {
		if (merchant.image) {
			setImagePreview(merchant.image);
		}
	}, [merchant.image]);

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
				<Card>
					<CardHeader>
						<CardTitle>{m.edit_profile()}</CardTitle>
						<CardDescription>
							{m.update_your_merchant_information()}
						</CardDescription>
					</CardHeader>
					<CardContent className="grid gap-6 md:grid-cols-2">
						<FormField
							control={form.control}
							name="image"
							render={({ field }) => (
								<FormItem className="md:col-span-2">
									<FormLabel>{m.merchant_photo()}</FormLabel>
									<FormControl>
										<div className="relative mx-auto h-48 w-48 overflow-hidden rounded-md">
											<Button
												type="button"
												variant="ghost"
												size="icon"
												className="absolute top-2 right-2 z-10"
												onClick={() => {
													field.onChange(undefined);
													setImagePreview(undefined);
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
															onSuccess: setImagePreview,
														});
														field.onChange(files[0]);
													}
												}}
												onError={(err) => {
													form.setError("image", { message: err.message });
												}}
												src={field.value ? [field.value] : undefined}
												className={cn("relative z-0", field.value && "p-0")}
											>
												<DropzoneEmptyState />
												<DropzoneContent className="h-48 w-48">
													{imagePreview && (
														<div className="relative h-48 w-48">
															<img
																alt="Preview"
																src={imagePreview}
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
									<FormLabel>{m.business_name()}</FormLabel>
									<FormControl>
										<Input
											placeholder="Warung Makan Berkah"
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
											placeholder="merchant@example.com"
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
							name="phone_number"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.phone()}</FormLabel>
									<FormControl>
										<PhoneInput
											countries={["ID"]}
											defaultCountry={"ID"}
											name={field.name}
											disabled={mutation.isPending}
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
							name="category"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.category()}</FormLabel>
									<Select
										onValueChange={field.onChange}
										defaultValue={field.value}
									>
										<FormControl>
											<SelectTrigger className="w-full">
												<SelectValue placeholder={m.select_category()} />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											{CONSTANTS.MERCHANT_CATEGORIES.map((val) => (
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
							name="address"
							render={({ field }) => (
								<FormItem className="md:col-span-2">
									<FormLabel>{m.address()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Jl. Kampus No. 123"
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
							name="location_y"
							render={() => (
								<FormItem className="md:col-span-2">
									<FormLabel>{m.location()}</FormLabel>
									<FormControl>
										<MapWrapper
											value={{
												lat: Number(form.getValues("location_y")) || 0,
												lng: Number(form.getValues("location_x")) || 0,
											}}
											onLocationChange={({ lat, lng }) => {
												form.setValue("location_y", lat);
												form.setValue("location_x", lng);
											}}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<FormField
							control={form.control}
							name="bank_provider"
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
							name="bank_number"
							render={({ field: { value, ...field } }) => (
								<FormItem>
									<FormLabel>{m.bank_number()}</FormLabel>
									<FormControl>
										<Input
											placeholder="1234567890"
											disabled={mutation.isPending}
											{...field}
											value={String(value ?? "")}
											onChange={(e) => field.onChange(e.target.value)}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
					</CardContent>
				</Card>

				<div className="flex gap-2">
					<Button
						type="button"
						variant="outline"
						onClick={() => {
							if (mutation.isPending) return;
							onCancel();
						}}
						disabled={mutation.isPending}
						className="w-[49.8%]"
					>
						{m.cancel()}
					</Button>
					<Button
						type="submit"
						disabled={mutation.isPending}
						className="w-[49.8%]"
					>
						{mutation.isPending ? <Submitting /> : m.save_changes()}
					</Button>
				</div>
			</form>
		</Form>
	);
}
