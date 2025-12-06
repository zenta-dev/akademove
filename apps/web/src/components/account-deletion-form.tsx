"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { useState } from "react";
import { useForm } from "react-hook-form";
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

// Validation schema
const deletionFormSchema = z.object({
	email: z.string().email("Please enter a valid email address"),
	phoneNumber: z
		.string()
		.min(10, "Phone number must be at least 10 digits")
		.max(15, "Phone number must not exceed 15 digits")
		.regex(/^\+?[0-9]+$/, "Please enter a valid phone number"),
	fullName: z
		.string()
		.min(3, "Full name must be at least 3 characters")
		.max(100, "Full name must not exceed 100 characters"),
	accountType: z.enum(["user", "driver", "merchant"], {
		message: "Please select your account type",
	}),
	reason: z
		.string()
		.max(500, "Reason must not exceed 500 characters")
		.optional(),
	confirmEmail: z.string().email("Please enter a valid email address"),
});

type DeletionFormValues = z.infer<typeof deletionFormSchema>;

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
			deletionFormSchema.refine((data) => data.email === data.confirmEmail, {
				message: "Email addresses do not match",
				path: ["confirmEmail"],
			}),
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
			// TODO: Replace with actual API call
			// const response = await fetch('/api/account-deletion', {
			//   method: 'POST',
			//   headers: { 'Content-Type': 'application/json' },
			//   body: JSON.stringify(formData),
			// });

			// Simulate API call
			await new Promise((resolve) => setTimeout(resolve, 2000));

			// For now, just send an email via mailto
			const subject = encodeURIComponent("Account Deletion Request");
			const body = encodeURIComponent(
				`Account Deletion Request

Full Name: ${formData.fullName}
Email: ${formData.email}
Phone Number: ${formData.phoneNumber}
Account Type: ${formData.accountType.toUpperCase()}
Reason: ${formData.reason || "Not provided"}

I request that my AkadeMove account be permanently deleted along with all associated personal data.

I understand that:
- This action is permanent and cannot be undone
- All wallet balance will be forfeited
- Order history and ratings will be removed
- Financial records may be retained for legal compliance (10 years)

Date: ${new Date().toLocaleDateString()}`,
			);

			// Open mailto link
			window.location.href = `mailto:privacy@akademove.com?subject=${subject}&body=${body}`;

			setIsSubmitting(false);
			setShowSuccessDialog(true);
			form.reset();
			onSuccess?.();
		} catch (error) {
			console.error("Deletion request failed:", error);
			setIsSubmitting(false);
			// Show error toast/notification
			alert(
				"Failed to submit deletion request. Please try again or contact support directly at privacy@akademove.com",
			);
		}
	};

	return (
		<>
			<Card className="border-2">
				<CardHeader>
					<CardTitle className="text-2xl">
						Submit Account Deletion Request
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
											Full Name <span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												placeholder="John Doe"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											Enter your full name as registered in your account
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
											Email Address <span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												type="email"
												placeholder="john@example.com"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											Enter the email address associated with your account
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
											Confirm Email Address{" "}
											<span className="text-red-500">*</span>
										</FormLabel>
										<FormControl>
											<Input
												type="email"
												placeholder="john@example.com"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											Re-enter your email address to confirm
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
											Phone Number <span className="text-red-500">*</span>
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
											Enter the phone number registered to your account (with
											country code)
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
											Account Type <span className="text-red-500">*</span>
										</FormLabel>
										<Select
											onValueChange={field.onChange}
											defaultValue={field.value}
											disabled={isSubmitting}
										>
											<FormControl>
												<SelectTrigger>
													<SelectValue placeholder="Select your account type" />
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												<SelectItem value="user">User (Passenger)</SelectItem>
												<SelectItem value="driver">
													Driver (Student Mitra)
												</SelectItem>
												<SelectItem value="merchant">
													Merchant (Business Owner)
												</SelectItem>
											</SelectContent>
										</Select>
										<FormDescription>
											Select the type of account you want to delete
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
										<FormLabel>Reason for Deletion (Optional)</FormLabel>
										<FormControl>
											<Textarea
												placeholder="Tell us why you're leaving (optional)..."
												className="min-h-[100px] resize-none"
												{...field}
												disabled={isSubmitting}
											/>
										</FormControl>
										<FormDescription>
											Your feedback helps us improve our service (maximum 500
											characters)
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>

							<Card className="border-orange-200 bg-orange-50 dark:border-orange-900 dark:bg-orange-950">
								<CardContent className="pt-6">
									<div className="space-y-2 text-orange-900 text-sm dark:text-orange-100">
										<p className="font-semibold">⚠️ Before you proceed:</p>
										<ul className="ml-2 list-inside list-disc space-y-1">
											<li>
												Account deletion is permanent and cannot be undone
											</li>
											<li>All wallet balance will be forfeited</li>
											<li>You will lose access to order history and ratings</li>
											<li>
												Financial records will be retained for 10 years (legal
												requirement)
											</li>
											<li>
												You cannot use the same email to register for 90 days
											</li>
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
									{isSubmitting ? "Submitting..." : "Request Account Deletion"}
								</Button>
								<Button
									type="button"
									variant="outline"
									onClick={() => form.reset()}
									disabled={isSubmitting}
								>
									Clear Form
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
							⚠️ Confirm Account Deletion Request
						</AlertDialogTitle>
						<AlertDialogDescription className="space-y-4">
							<p>
								You are about to submit a request to permanently delete your
								AkadeMove account.
							</p>
							<div className="space-y-2 rounded-lg bg-muted p-4 text-sm">
								<p className="font-semibold">Request Details:</p>
								<ul className="space-y-1">
									<li>
										<strong>Name:</strong> {formData?.fullName}
									</li>
									<li>
										<strong>Email:</strong> {formData?.email}
									</li>
									<li>
										<strong>Phone:</strong> {formData?.phoneNumber}
									</li>
									<li>
										<strong>Account Type:</strong>{" "}
										{formData?.accountType?.toUpperCase()}
									</li>
								</ul>
							</div>
							<p className="font-semibold text-red-600 dark:text-red-400">
								This action is permanent and cannot be undone. Are you
								absolutely sure?
							</p>
						</AlertDialogDescription>
					</AlertDialogHeader>
					<AlertDialogFooter>
						<AlertDialogCancel>Cancel</AlertDialogCancel>
						<AlertDialogAction
							onClick={handleConfirmedSubmit}
							className="bg-red-600 text-white hover:bg-red-700"
						>
							Yes, Delete My Account
						</AlertDialogAction>
					</AlertDialogFooter>
				</AlertDialogContent>
			</AlertDialog>

			{/* Success Dialog */}
			<AlertDialog open={showSuccessDialog} onOpenChange={setShowSuccessDialog}>
				<AlertDialogContent>
					<AlertDialogHeader>
						<AlertDialogTitle>
							✅ Request Submitted Successfully
						</AlertDialogTitle>
						<AlertDialogDescription className="space-y-4">
							<p>
								Your account deletion request has been submitted to our data
								protection team.
							</p>
							<div className="space-y-2 rounded-lg border border-blue-200 bg-blue-50 p-4 text-sm dark:border-blue-900 dark:bg-blue-950">
								<p className="font-semibold text-blue-900 dark:text-blue-100">
									What happens next:
								</p>
								<ul className="list-inside list-disc space-y-1 text-blue-900 dark:text-blue-100">
									<li>
										We will verify your identity (usually within 1-2 business
										days)
									</li>
									<li>
										You'll receive an email confirmation once verification is
										complete
									</li>
									<li>
										Your account will be permanently deleted within 3-5 business
										days
									</li>
									<li>A final confirmation email will be sent once complete</li>
								</ul>
							</div>
							<p className="text-muted-foreground text-sm">
								If you don't receive a confirmation email within 7 days, please
								contact us at{" "}
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
							Close
						</AlertDialogAction>
					</AlertDialogFooter>
				</AlertDialogContent>
			</AlertDialog>
		</>
	);
}
