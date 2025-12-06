"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { z } from "zod";
import {
	AlertDialog,
	AlertDialogAction,
	AlertDialogCancel,
	AlertDialogContent,
	AlertDialogDescription,
	AlertDialogFooter,
	AlertDialogHeader,
	AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
	Form,
	FormControl,
	FormDescription,
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
import { Textarea } from "@/components/ui/textarea";
import { orpcClient } from "@/lib/orpc";

// Create validation schema with i18n messages
const createDeletionFormSchema = () =>
	z.object({
		email: z.email(m.account_deletion_email_validation()),
		phoneNumber: z
			.string()
			.min(10, m.account_deletion_phone_min())
			.max(20, m.account_deletion_phone_max())
			.regex(/^\+?[0-9]+$/, m.account_deletion_phone_validation()),
		fullName: z
			.string()
			.min(2, m.account_deletion_fullname_min())
			.max(255, m.account_deletion_fullname_max()),
		accountType: z.enum(["user", "driver", "merchant"], {
			message: m.account_deletion_account_type_required(),
		}),
		reason: z.string().max(1000, m.account_deletion_reason_max()).optional(),
		confirmEmail: z.email(m.account_deletion_email_validation()),
	});

type DeletionFormValues = z.infer<ReturnType<typeof createDeletionFormSchema>>;

interface AccountDeletionFormProps {
	onSuccess?: () => void;
}

export function AccountDeletionForm({ onSuccess }: AccountDeletionFormProps) {
	const [isSubmitting, setIsSubmitting] = useState(false);
	const [showConfirmDialog, setShowConfirmDialog] = useState(false);
	const [showSuccessDialog, setShowSuccessDialog] = useState(false);
	const [formData, setFormData] = useState<DeletionFormValues | null>(null);

	const form = useForm<DeletionFormValues>({
		resolver: zodResolver(
			createDeletionFormSchema().refine(
				(data) => data.email === data.confirmEmail,
				{
					message: m.account_deletion_email_match(),
					path: ["confirmEmail"],
				},
			),
		),
		defaultValues: {
			email: "",
			phoneNumber: "",
			fullName: "",
			accountType: undefined,
			reason: "",
			confirmEmail: "",
		},
	});

	const handleFormSubmit = (values: DeletionFormValues) => {
		// Store form data and show confirmation dialog
		setFormData(values);
		setShowConfirmDialog(true);
	};

	const handleConfirmedSubmit = async () => {
		if (!formData) return;

		setIsSubmitting(true);
		setShowConfirmDialog(false);

		try {
			// Call the API
			const response = await orpcClient.accountDeletion.submit({
				body: {
					accountType: formData.accountType.toUpperCase() as
						| "USER"
						| "DRIVER"
						| "MERCHANT",
					reason: "OTHER",
					additionalInfo: formData.reason || undefined,
					email: formData.email,
					phone: formData.phoneNumber,
					fullName: formData.fullName,
				},
			});

			if (response.status === 201) {
				setIsSubmitting(false);
				setShowSuccessDialog(true);
				form.reset();
				onSuccess?.();
				toast.success(m.account_deletion_success());
			} else {
				throw new Error("Failed to submit deletion request");
			}
		} catch (error) {
			console.error("Deletion request failed:", error);
			setIsSubmitting(false);
			toast.error(m.account_deletion_error());
		}
	};

	return (
		<>
			<Card className="border-2">
				<CardHeader>
					<CardTitle className="text-2xl">
						{m.account_deletion_title()}
					</CardTitle>
				</CardHeader>
				<CardContent>
					<Form {...form}>
						<form
							onSubmit={form.handleSubmit(handleFormSubmit)}
							className="space-y-6"
						>
							<FormField
								control={form.control}
								name="fullName"
								render={({ field }) => (
									<FormItem>
										<FormLabel>
											{m.account_deletion_full_name()}{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												placeholder={m.account_deletion_full_name_placeholder()}
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											{m.account_deletion_full_name_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="email"
								render={({ field }) => (
									<FormItem>
										<FormLabel>
											{m.account_deletion_confirm_email()}{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												type="email"
												placeholder={m.account_deletion_confirm_email_placeholder()}
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											{m.account_deletion_confirm_email_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="confirmEmail"
								render={({ field }) => (
									<FormItem>
										<FormLabel>
											{m.account_deletion_phone_label()}{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												type="tel"
												placeholder={m.account_deletion_phone_placeholder()}
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											{m.account_deletion_phone_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="phoneNumber"
								render={({ field }) => (
									<FormItem>
										<FormLabel>
											{m.account_deletion_full_name()}{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												type="tel"
												placeholder="+62 812 3456 7890"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											{m.account_deletion_full_name_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="accountType"
								render={({ field }) => (
									<FormItem>
										<FormLabel>
											{m.account_deletion_account_type_label()}{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<Select
											onValueChange={field.onChange}
											defaultValue={field.value}
											disabled={isSubmitting}
										>
											<FormControl>
												<SelectTrigger>
													<SelectValue
														placeholder={m.account_deletion_account_type_placeholder()}
													/>
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												<SelectItem value="user">
													{m.account_deletion_account_type_user()}
												</SelectItem>
												<SelectItem value="driver">
													{m.account_deletion_account_type_driver()}
												</SelectItem>
												<SelectItem value="merchant">
													{m.account_deletion_account_type_merchant()}
												</SelectItem>
											</SelectContent>
										</Select>
										<FormDescription>
											{m.account_deletion_account_type_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<FormField
								control={form.control}
								name="reason"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.account_deletion_reason_label()}</FormLabel>
										<FormControl>
											<Textarea
												placeholder={m.account_deletion_reason_placeholder()}
												className="min-h-[100px] resize-none"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											{m.account_deletion_reason_desc()}
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<Card className="border-orange-200 bg-orange-50 dark:border-orange-900 dark:bg-orange-950">
								<CardContent className="pt-6">
									<div className="space-y-2 text-orange-900 text-sm dark:text-orange-100">
										<p className="font-semibold">
											{m.account_deletion_warning_title()}
										</p>
										<ul className="ml-2 list-inside list-disc space-y-1">
											<li>{m.account_deletion_warning_1()}</li>
											<li>{m.account_deletion_warning_2()}</li>
											<li>{m.account_deletion_warning_3()}</li>
											<li>{m.account_deletion_warning_4()}</li>
											<li>{m.account_deletion_warning_5()}</li>
										</ul>
									</div>
								</CardContent>
							</Card>

							<div className="flex gap-4">
								<Button
									type="submit"
									variant="destructive"
									className="flex-1"
									disabled={isSubmitting}
								>
									{isSubmitting
										? m.submitting()
										: m.account_deletion_request_button()}
								</Button>
								<Button
									type="button"
									variant="outline"
									onClick={() => form.reset()}
									disabled={isSubmitting}
								>
									{m.clear()}
								</Button>
							</div>
						</form>
					</Form>
				</CardContent>
			</Card>

			{/* Confirmation Dialog */}
			<AlertDialog open={showConfirmDialog} onOpenChange={setShowConfirmDialog}>
				<AlertDialogContent>
					<AlertDialogHeader>
						<AlertDialogTitle>
							{m.account_deletion_confirm_title()}
						</AlertDialogTitle>
						<AlertDialogDescription className="space-y-4">
							<p>{m.account_deletion_confirm_desc()}</p>
							<div className="space-y-2 rounded-lg bg-muted p-4 text-sm">
								<p className="font-semibold">
									{m.account_deletion_confirm_details()}
								</p>
								<ul className="space-y-1">
									<li>
										<strong>{m.account_deletion_confirm_name()}:</strong>{" "}
										{formData?.fullName}
									</li>
									<li>
										<strong>{m.account_deletion_confirm_email()}:</strong>{" "}
										{formData?.email}
									</li>
									<li>
										<strong>{m.account_deletion_confirm_phone()}:</strong>{" "}
										{formData?.phoneNumber}
									</li>
									<li>
										<strong>{m.account_deletion_confirm_type()}:</strong>{" "}
										{formData?.accountType?.toUpperCase()}
									</li>
								</ul>
							</div>
							<p className="font-semibold text-red-600 dark:text-red-400">
								{m.account_deletion_confirm_warning()}
							</p>
						</AlertDialogDescription>
					</AlertDialogHeader>
					<AlertDialogFooter>
						<AlertDialogCancel>{m.cancel()}</AlertDialogCancel>
						<AlertDialogAction
							onClick={handleConfirmedSubmit}
							className="bg-red-600 text-white hover:bg-red-700"
						>
							{m.account_deletion_confirm_yes()}
						</AlertDialogAction>
					</AlertDialogFooter>
				</AlertDialogContent>
			</AlertDialog>

			{/* Success Dialog */}
			<AlertDialog open={showSuccessDialog} onOpenChange={setShowSuccessDialog}>
				<AlertDialogContent>
					<AlertDialogHeader>
						<AlertDialogTitle>
							{m.account_deletion_success_title()}
						</AlertDialogTitle>
						<AlertDialogDescription className="space-y-4">
							<p>{m.account_deletion_success_desc()}</p>
							<div className="space-y-2 rounded-lg border border-blue-200 bg-blue-50 p-4 text-sm dark:border-blue-900 dark:bg-blue-950">
								<p className="font-semibold text-blue-900 dark:text-blue-100">
									{m.account_deletion_success_next()}
								</p>
								<ul className="list-inside list-disc space-y-1 text-blue-900 dark:text-blue-100">
									<li>{m.account_deletion_success_step_1()}</li>
									<li>{m.account_deletion_success_step_2()}</li>
									<li>{m.account_deletion_success_step_3()}</li>
									<li>{m.account_deletion_success_step_4()}</li>
								</ul>
							</div>
							<p className="text-muted-foreground text-sm">
								{m.account_deletion_success_step_5()}{" "}
								<a
									href="mailto:privacy@akademove.com"
									className="text-primary hover:underline"
								>
									privacy@akademove.com
								</a>
							</p>
						</AlertDialogDescription>
					</AlertDialogHeader>
					<AlertDialogFooter>
						<AlertDialogAction onClick={() => setShowSuccessDialog(false)}>
							{m.close()}
						</AlertDialogAction>
					</AlertDialogFooter>
				</AlertDialogContent>
			</AlertDialog>
		</>
	);
}
