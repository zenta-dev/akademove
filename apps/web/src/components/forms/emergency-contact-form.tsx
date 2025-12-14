import { zodResolver } from "@hookform/resolvers/zod";
import {
	type EmergencyContact,
	InsertEmergencyContactSchema,
	UpdateEmergencyContactSchema,
} from "@repo/schema/emergency-contact";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";

import { useCallback, useMemo } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
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
import { Textarea } from "@/components/ui/textarea";
import { orpcQuery, queryClient } from "@/lib/orpc";

export const EmergencyContactForm = ({
	kind,
	contact,
	onSuccess,
}: {
	kind: "new" | "edit";
	contact?: EmergencyContact;
	onSuccess?: () => Promise<void>;
}) => {
	const form = useForm({
		resolver: zodResolver(
			kind === "new"
				? InsertEmergencyContactSchema
				: UpdateEmergencyContactSchema,
		),
		defaultValues:
			kind === "edit" && contact
				? {
						name: contact.name,
						phone: contact.phone,
						description: contact.description ?? "",
						isActive: contact.isActive,
						priority: contact.priority,
					}
				: {
						name: "",
						phone: "",
						description: "",
						isActive: true,
						priority: 0,
					},
	});

	const _onSuccess = useCallback(
		async (kind: "insert" | "update") => {
			await queryClient.invalidateQueries();
			toast.success(
				`${capitalizeFirstLetter(kind === "insert" ? "Create" : "Update")} emergency contact successful`,
			);
			form.reset();
			await onSuccess?.();
		},
		[form, onSuccess],
	);

	const onError = useCallback((kind: "insert" | "update", error: Error) => {
		toast.error(
			`Failed to ${kind === "insert" ? "create" : "update"} emergency contact`,
			{
				description: error.message || "An unexpected error occurred",
			},
		);
	}, []);

	const insertMutation = useMutation(
		orpcQuery.emergencyContact.create.mutationOptions({
			onSuccess: () => _onSuccess("insert"),
			onError: (error: Error) => onError("insert", error),
		}),
	);

	const updateMutation = useMutation(
		orpcQuery.emergencyContact.update.mutationOptions({
			onSuccess: () => _onSuccess("update"),
			onError: (error: Error) => onError("update", error),
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			if (kind === "new") {
				const parse = InsertEmergencyContactSchema.safeParse(values);
				if (parse.success) {
					await insertMutation.mutateAsync({ body: parse.data });
				} else {
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
				}
			}

			if (kind === "edit" && contact) {
				const parse = UpdateEmergencyContactSchema.safeParse(values);
				if (parse.success) {
					await updateMutation.mutateAsync({
						params: { id: contact.id },
						body: parse.data,
					});
				} else {
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
				}
			}
		},
		[contact, insertMutation, updateMutation, kind],
	);

	const isLoading = useMemo(
		() =>
			kind === "new" ? insertMutation.isPending : updateMutation.isPending,
		[kind, insertMutation.isPending, updateMutation.isPending],
	);

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit(onSubmit)}
				className="grid grid-cols-1 gap-4 md:grid-cols-2"
			>
				<FormField
					control={form.control}
					name="name"
					render={({ field }) => (
						<FormItem>
							<FormLabel>Contact Name</FormLabel>
							<FormControl>
								<Input
									placeholder="e.g., Campus Security"
									disabled={isLoading}
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
							<FormLabel>Phone Number</FormLabel>
							<FormControl>
								<Input
									placeholder="+6281234567890"
									disabled={isLoading}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<FormField
					control={form.control}
					name="description"
					render={({ field }) => (
						<FormItem className="md:col-span-2">
							<FormLabel>Description (Optional)</FormLabel>
							<FormControl>
								<Textarea
									placeholder="Optional description for this contact"
									disabled={isLoading}
									{...field}
									value={field.value ?? ""}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<FormField
					control={form.control}
					name="priority"
					render={({ field }) => (
						<FormItem>
							<FormLabel>Priority</FormLabel>
							<FormControl>
								<Input
									type="number"
									placeholder="0"
									disabled={isLoading}
									name={field.name}
									ref={field.ref}
									onBlur={field.onBlur}
									value={(field.value as number) ?? ""}
									onChange={(e) => field.onChange(Number(e.target.value))}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<FormField
					control={form.control}
					name="isActive"
					render={({ field }) => (
						<FormItem className="md:col-span-2">
							<FormLabel>Active Status</FormLabel>
							<FormControl>
								<div className="flex items-center gap-2">
									<Checkbox
										checked={field.value ?? false}
										onCheckedChange={field.onChange}
										disabled={isLoading}
									/>
									<p className="text-muted-foreground text-sm">
										Make this contact available for emergency situations
									</p>
								</div>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<Button
					type="submit"
					disabled={isLoading}
					className="w-full md:col-span-2"
				>
					{isLoading ? (
						<Submitting />
					) : kind === "new" ? (
						"Create Emergency Contact"
					) : (
						"Update Emergency Contact"
					)}
				</Button>
			</form>
		</Form>
	);
};
