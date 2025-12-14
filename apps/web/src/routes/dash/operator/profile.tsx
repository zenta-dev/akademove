import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { CountryCode } from "@repo/schema/common";
import { FlatUpdateUserSchema, type User } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import { Mail, Phone, User as UserIcon, X } from "lucide-react";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { parsePhoneNumber } from "react-phone-number-input";
import { toast } from "sonner";
import { ChangePasswordDialog } from "@/components/dialogs/change-password";
import { Submitting } from "@/components/misc/submitting";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
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
	Dropzone,
	DropzoneContent,
	DropzoneEmptyState,
} from "@/components/ui/shadcn-io/dropzone";
import { Skeleton } from "@/components/ui/skeleton";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";
import { createPhotoPreviewUrl } from "@/utils/file";

export const Route = createFileRoute("/dash/operator/profile")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.USER.PROFILE }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["OPERATOR"]);
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
	const [isEditing, setIsEditing] = useState(false);

	const { data, isPending, isError } = useQuery(
		orpcQuery.auth.getSession.queryOptions(),
	);

	if (!allowed) navigate({ to: "/" });

	if (isPending) {
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

	if (isError || !data?.body.data) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						Manage your profile information
					</p>
				</div>
				<Card>
					<CardContent className="p-8 text-center text-muted-foreground">
						Failed to load profile
					</CardContent>
				</Card>
			</>
		);
	}

	const user = data.body.data.user;

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						Manage your profile information
					</p>
				</div>
				<div className="flex gap-2">
					<ChangePasswordDialog asChild>
						<Button variant="outline">{m.update_user_password()}</Button>
					</ChangePasswordDialog>
					<Button
						variant={isEditing ? "outline" : "default"}
						onClick={() => setIsEditing(!isEditing)}
					>
						{isEditing ? m.cancel() : m.edit_profile()}
					</Button>
				</div>
			</div>

			{isEditing ? (
				<EditUserProfile
					user={user}
					onCancel={() => setIsEditing(false)}
					onSuccess={() => setIsEditing(false)}
				/>
			) : (
				<ViewUserProfile user={user} />
			)}
		</>
	);
}

function ViewUserProfile({ user }: { user: User }) {
	return (
		<div className="grid gap-4 md:grid-cols-2">
			<Card>
				<CardHeader>
					<CardTitle>Personal Information</CardTitle>
					<CardDescription>Your account details</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					<div className="flex items-center gap-3">
						<Avatar className="h-16 w-16">
							<AvatarImage src={user.image || ""} />
							<AvatarFallback>
								<UserIcon className="h-8 w-8" />
							</AvatarFallback>
						</Avatar>
						<div>
							<p className="font-medium text-lg">{user.name}</p>
							<Badge variant="secondary">{user.role}</Badge>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<Mail className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.email()}</p>
							<p className="font-medium">{user.email}</p>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<Phone className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.phone()}</p>
							<p className="font-medium">
								+{user?.phone?.countryCode} {user?.phone?.number}
							</p>
						</div>
					</div>
					{user.gender && (
						<div>
							<p className="text-muted-foreground text-sm">Gender</p>
							<p className="font-medium">
								{capitalizeFirstLetter(user.gender)}
							</p>
						</div>
					)}
				</CardContent>
			</Card>

			{user.userBadges && user.userBadges.length > 0 && (
				<Card>
					<CardHeader>
						<CardTitle>Badges</CardTitle>
						<CardDescription>Your earned achievements</CardDescription>
					</CardHeader>
					<CardContent>
						<div className="grid grid-cols-2 gap-3">
							{user.userBadges.map((badge) => (
								<div
									key={badge.id}
									className="flex flex-col items-center gap-2 rounded-lg border p-3"
								>
									{badge.badge.icon && (
										<img
											src={badge.badge.icon}
											alt={badge.badge.name}
											className="h-16 w-16 object-contain"
										/>
									)}
									<p className="text-center font-medium text-sm">
										{badge.badge.name}
									</p>
									<p className="text-center text-muted-foreground text-xs">
										{badge.badge.description}
									</p>
								</div>
							))}
						</div>
					</CardContent>
				</Card>
			)}

			<Card>
				<CardHeader>
					<CardTitle>Account Status</CardTitle>
					<CardDescription>Your account information</CardDescription>
				</CardHeader>
				<CardContent className="space-y-3">
					<div className="flex items-center justify-between">
						<span className="text-muted-foreground text-sm">
							Email Verified
						</span>
						<Badge variant={user.emailVerified ? "default" : "destructive"}>
							{user.emailVerified ? "Verified" : "Not Verified"}
						</Badge>
					</div>
					<div className="flex items-center justify-between">
						<span className="text-muted-foreground text-sm">
							Account Status
						</span>
						<Badge variant={user.banned ? "destructive" : "default"}>
							{user.banned ? "Banned" : "Active"}
						</Badge>
					</div>
					{user.banned && user.banReason && (
						<div>
							<p className="text-muted-foreground text-sm">Ban Reason</p>
							<p className="text-sm">{user.banReason}</p>
						</div>
					)}
				</CardContent>
			</Card>
		</div>
	);
}

function EditUserProfile({
	user,
	onCancel,
	onSuccess,
}: {
	user: User;
	onCancel: () => void;
	onSuccess: () => void;
}) {
	const [imagePreview, setImagePreview] = useState<string | undefined>(
		user.image,
	);

	const form = useForm({
		resolver: zodResolver(FlatUpdateUserSchema),
		defaultValues: {
			name: user.name || "",
			email: user.email || "",
			phone_countryCode: (user.phone?.countryCode || "ID") as CountryCode,
			phone_number: user.phone?.number || 0,
			photo: undefined,
		},
	});

	const mutation = useMutation(
		orpcQuery.user.me.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
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
			const parsed = FlatUpdateUserSchema.safeParse(values);
			if (parsed.success) {
				await mutation.mutateAsync({ body: parsed.data });
			}
		},
		[mutation],
	);

	useEffect(() => {
		if (user.image) {
			setImagePreview(user.image);
		}
	}, [user.image]);

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
				<Card>
					<CardHeader>
						<CardTitle>{m.edit_profile()}</CardTitle>
						<CardDescription>Update your profile information</CardDescription>
					</CardHeader>
					<CardContent className="grid gap-6 md:grid-cols-2">
						<FormField
							control={form.control}
							name="photo"
							render={({ field }) => (
								<FormItem className="md:col-span-2">
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
													form.setError("photo", { message: err.message });
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
									<FormLabel>{m.name()}</FormLabel>
									<FormControl>
										<Input
											placeholder="John Doe"
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
											placeholder="john.doe@example.com"
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
								<FormItem className="md:col-span-2">
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
