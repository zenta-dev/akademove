import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	type UpdateUserPassword,
	UpdateUserPasswordSchema,
} from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { PasswordToggle } from "@/components/toggle/password-toggle";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogClose,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { orpcQuery, queryClient } from "@/lib/orpc";

export const UpdateUserPasswordDialog = ({ userId }: { userId: string }) => {
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const [open, setOpen] = useState(false);
	const form = useForm({
		resolver: zodResolver(UpdateUserPasswordSchema),
		defaultValues: {
			oldPassword: "",
			newPassword: "",
			confirmNewPassword: "",
		},
	});

	const mutation = useMutation(
		orpcQuery.user.admin.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(
					m.success_placeholder({ action: m.update_user_password() }),
				);
				setOpen(false);
				form.setValue("oldPassword", "");
				form.setValue("newPassword", "");
				form.setValue("confirmNewPassword", "");
				form.clearErrors();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(
							m.update_user_password().toLowerCase(),
						),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
				form.setError("oldPassword", { message: error.message });
			},
		}),
	);

	const onSubmit = async (values: UpdateUserPassword) => {
		await mutation.mutateAsync({ params: { id: userId }, body: values });
	};

	return (
		<Dialog open={open} onOpenChange={() => setOpen(!open)}>
			<DialogTrigger asChild>
				<Button
					className="justify-start p-2 text-start font-normal"
					variant="ghost"
					size="sm"
				>
					{m.update_user_password()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.update_user_password()}</DialogTitle>
					<DialogDescription>{m.update_user_password_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="oldPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Current {m.password()}</FormLabel>
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
							name="newPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>New {m.password()}</FormLabel>
									<FormControl>
										<div className="relative">
											<Input
												placeholder="••••••••"
												autoComplete="new-password"
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
							name="confirmNewPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.confirm_password()}</FormLabel>
									<FormControl>
										<div className="relative">
											<Input
												placeholder="••••••••"
												autoComplete="new-password"
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
						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.update_user_password()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
