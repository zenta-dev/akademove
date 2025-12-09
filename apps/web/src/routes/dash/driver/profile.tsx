import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { CONSTANTS } from "@repo/schema/constants";
import { type Driver, UpdateDriverSchema } from "@repo/schema/driver";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	BadgeCheck,
	Car,
	CreditCard,
	FileText,
	IdCard,
	Mail,
	Phone,
	User as UserIcon,
} from "lucide-react";
import { useCallback, useState } from "react";
import { useForm } from "react-hook-form";
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
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Skeleton } from "@/components/ui/skeleton";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { useMyDriver } from "@/providers/driver";

export const Route = createFileRoute("/dash/driver/profile")({
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.PROFILE }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["DRIVER"]);
		if (!ok) redirect({ to: "/", throw: true });

		// Check if driver has passed quiz
		try {
			const driverResult = await orpcClient.driver.getMine();
			if (driverResult.body.data.quizStatus !== "PASSED") {
				redirect({ to: "/quiz/driver", throw: true });
			}
		} catch (error) {
			console.error("Failed to check quiz status:", error);
			redirect({ to: "/", throw: true });
		}

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
	const driver = useMyDriver();
	const [isEditing, setIsEditing] = useState(false);

	const { data: sessionData } = useQuery(
		orpcQuery.auth.getSession.queryOptions({}),
	);

	if (!allowed) navigate({ to: "/" });

	if (driver.isLoading) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						Manage your driver profile and documents
					</p>
				</div>
				<Skeleton className="h-[600px] w-full" />
			</>
		);
	}

	if (driver.isError || !driver.value) {
		return (
			<>
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						Manage your driver profile and documents
					</p>
				</div>
				<Card>
					<CardContent className="p-8 text-center text-muted-foreground">
						Failed to load driver profile
					</CardContent>
				</Card>
			</>
		);
	}

	const user = sessionData?.body.data?.user
		? {
				name: sessionData.body.data.user.name,
				email: sessionData.body.data.user.email,
				phone: sessionData.body.data.user.phone
					? {
							countryCode: sessionData.body.data.user.phone
								.countryCode as string,
							number: sessionData.body.data.user.phone.number,
						}
					: undefined,
				image: sessionData.body.data.user.image,
				gender: sessionData.body.data.user.gender,
			}
		: undefined;

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.profile()}</h2>
					<p className="text-muted-foreground">
						Manage your driver profile and documents
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
				<EditDriverProfile
					driver={driver.value}
					onCancel={() => setIsEditing(false)}
					onSuccess={() => setIsEditing(false)}
				/>
			) : (
				<ViewDriverProfile driver={driver.value} user={user} />
			)}
		</>
	);
}

function ViewDriverProfile({
	driver,
	user,
}: {
	driver: Driver;
	user?: {
		name: string;
		email: string;
		phone?: { countryCode: string; number: number };
		image?: string;
		gender?: string;
	};
}) {
	const getStatusVariant = (
		status: string,
	): "default" | "secondary" | "destructive" | "outline" => {
		switch (status) {
			case "ACTIVE":
				return "default";
			case "PENDING":
				return "secondary";
			case "SUSPENDED":
				return "destructive";
			case "REJECTED":
				return "destructive";
			default:
				return "outline";
		}
	};

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
							<AvatarImage src={user?.image || ""} />
							<AvatarFallback>
								<UserIcon className="h-8 w-8" />
							</AvatarFallback>
						</Avatar>
						<div>
							<p className="font-medium text-lg">{user?.name}</p>
							<Badge variant={getStatusVariant(driver.status)}>
								{driver.status}
							</Badge>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<Mail className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.email()}</p>
							<p className="font-medium">{user?.email}</p>
						</div>
					</div>
					{user?.phone && (
						<div className="flex items-center gap-3">
							<Phone className="h-5 w-5 text-muted-foreground" />
							<div>
								<p className="text-muted-foreground text-sm">{m.phone()}</p>
								<p className="font-medium">
									+{user.phone.countryCode} {user.phone.number}
								</p>
							</div>
						</div>
					)}
					{user?.gender && (
						<div>
							<p className="text-muted-foreground text-sm">Gender</p>
							<p className="font-medium">
								{capitalizeFirstLetter(user.gender)}
							</p>
						</div>
					)}
				</CardContent>
			</Card>

			<Card>
				<CardHeader>
					<CardTitle>Driver Information</CardTitle>
					<CardDescription>Your driver credentials</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					<div className="flex items-center gap-3">
						<IdCard className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">{m.student_id()}</p>
							<p className="font-medium">{driver.studentId}</p>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<Car className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">
								{m.license_plate()}
							</p>
							<p className="font-medium">{driver.licensePlate}</p>
						</div>
					</div>
					<div className="flex items-center gap-3">
						<BadgeCheck className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">Rating</p>
							<p className="font-medium">{driver.rating.toFixed(1)} ⭐</p>
						</div>
					</div>
					<div className="flex items-center justify-between">
						<span className="text-muted-foreground text-sm">Online Status</span>
						<Badge variant={driver.isOnline ? "default" : "secondary"}>
							{driver.isOnline ? "Online" : "Offline"}
						</Badge>
					</div>
					<div className="flex items-center justify-between">
						<span className="text-muted-foreground text-sm">Taking Orders</span>
						<Badge variant={driver.isTakingOrder ? "default" : "secondary"}>
							{driver.isTakingOrder ? "Yes" : "No"}
						</Badge>
					</div>
				</CardContent>
			</Card>

			<Card>
				<CardHeader>
					<CardTitle>Bank Information</CardTitle>
					<CardDescription>Your payment details</CardDescription>
				</CardHeader>
				<CardContent className="space-y-4">
					<div className="flex items-center gap-3">
						<CreditCard className="h-5 w-5 text-muted-foreground" />
						<div>
							<p className="text-muted-foreground text-sm">
								{m.bank_provider()}
							</p>
							<p className="font-medium">{driver.bank.provider}</p>
						</div>
					</div>
					<div>
						<p className="text-muted-foreground text-sm">{m.bank_number()}</p>
						<p className="font-medium">{driver.bank.number}</p>
					</div>
				</CardContent>
			</Card>

			<Card>
				<CardHeader>
					<CardTitle>Documents</CardTitle>
					<CardDescription>
						Your uploaded verification documents
					</CardDescription>
				</CardHeader>
				<CardContent className="space-y-3">
					<div>
						<div className="flex items-center gap-2">
							<FileText className="h-4 w-4 text-muted-foreground" />
							<p className="text-muted-foreground text-sm">Student Card</p>
						</div>
						<a
							href={driver.studentCard}
							target="_blank"
							rel="noopener noreferrer"
							className="text-primary text-sm hover:underline"
						>
							View Document
						</a>
					</div>
					<div>
						<div className="flex items-center gap-2">
							<FileText className="h-4 w-4 text-muted-foreground" />
							<p className="text-muted-foreground text-sm">Driver License</p>
						</div>
						<a
							href={driver.driverLicense}
							target="_blank"
							rel="noopener noreferrer"
							className="text-primary text-sm hover:underline"
						>
							View Document
						</a>
					</div>
					<div>
						<div className="flex items-center gap-2">
							<FileText className="h-4 w-4 text-muted-foreground" />
							<p className="text-muted-foreground text-sm">
								Vehicle Certificate
							</p>
						</div>
						<a
							href={driver.vehicleCertificate}
							target="_blank"
							rel="noopener noreferrer"
							className="text-primary text-sm hover:underline"
						>
							View Document
						</a>
					</div>
				</CardContent>
			</Card>
		</div>
	);
}

function EditDriverProfile({
	driver,
	onCancel,
	onSuccess,
}: {
	driver: Driver;
	onCancel: () => void;
	onSuccess: () => void;
}) {
	const form = useForm({
		resolver: zodResolver(UpdateDriverSchema),
		defaultValues: {
			studentId: driver.studentId,
			licensePlate: driver.licensePlate || "",
			isTakingOrder: driver.isTakingOrder,
			bank: {
				provider: driver.bank?.provider || "BCA",
				number: driver.bank?.number || 0,
			},
		},
	});

	const mutation = useMutation(
		orpcQuery.driver.update.mutationOptions({
			onSuccess: async () => {
				queryClient.invalidateQueries();
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(m.update_profile().toLowerCase()),
					}),
				);
				onSuccess();
			},
			onError: (error: Error) => {
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
			const parsed = UpdateDriverSchema.safeParse(values);
			if (parsed.success) {
				await mutation.mutateAsync({
					params: { id: driver.id },
					body: parsed.data,
				});
			}
		},
		[mutation, driver.id],
	);

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
				<Card>
					<CardHeader>
						<CardTitle>{m.edit_profile()}</CardTitle>
						<CardDescription>Update your driver information</CardDescription>
					</CardHeader>
					<CardContent className="grid gap-6 md:grid-cols-2">
						<FormField
							control={form.control}
							name="studentId"
							render={({ field: { value, ...field } }) => (
								<FormItem>
									<FormLabel>{m.student_id()}</FormLabel>
									<FormControl>
										<Input
											type="number"
											placeholder="123456789"
											disabled={mutation.isPending}
											{...field}
											value={String(value ?? "")}
											onChange={(e) =>
												field.onChange(Number(e.target.value) || 0)
											}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<FormField
							control={form.control}
							name="licensePlate"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.license_plate()}</FormLabel>
									<FormControl>
										<Input
											placeholder="B 1234 XYZ"
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
							name="bank.provider"
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
							name="bank.number"
							render={({ field: { value, ...field } }) => (
								<FormItem>
									<FormLabel>{m.bank_number()}</FormLabel>
									<FormControl>
										<Input
											type="number"
											placeholder="1234567890"
											disabled={mutation.isPending}
											{...field}
											value={String(value ?? "")}
											onChange={(e) =>
												field.onChange(Number(e.target.value) || 0)
											}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<FormField
							control={form.control}
							name="isTakingOrder"
							render={({ field }) => (
								<FormItem className="md:col-span-2">
									<FormLabel>Taking Orders</FormLabel>
									<Select
										onValueChange={(val) => field.onChange(val === "true")}
										defaultValue={String(field.value)}
									>
										<FormControl>
											<SelectTrigger className="w-full">
												<SelectValue placeholder="Select availability" />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											<SelectItem value="true">
												Yes - Available for orders
											</SelectItem>
											<SelectItem value="false">No - Not available</SelectItem>
										</SelectContent>
									</Select>
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
