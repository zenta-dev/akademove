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
import { orpcClient, orpcQuery } from "@/lib/client/orpc";
import { BetterAuthClientError } from "@/lib/error";
import { Submitting } from "../submitting";
import { PasswordToggle } from "../toggle/password-toggle";
import { Button } from "../ui/button";
import {
	Dialog,
	DialogClose,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "../ui/dialog";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "../ui/form";
import { Input } from "../ui/input";

export const UpdateUserPasswordDialog = ({ userId }: { userId: string }) => {
	const [showPassword, setShowPassword] = useState(false);
	const [showConfirmPassword, setShowConfirmPassword] = useState(false);

	const [open, setOpen] = useState(false);
	const form = useForm<UpdateUserPassword>({
		resolver: zodResolver(UpdateUserPasswordSchema),
		defaultValues: { password: "", confirmPassword: "" },
	});

	const mutation = useMutation(
		orpcQuery.user.update.mutationOptions({
			mutationFn: async (data) => {
				const result = await orpcClient.user.update(data);
				if (result.status !== 200) {
					throw new BetterAuthClientError(result.body.message);
				}
				return result;
			},
			onSuccess: async () => {
				toast.success(
					m.success_placeholder({ action: m.update_user_password() }),
				);
				setOpen(false);
				form.setValue("password", "");
				form.setValue("confirmPassword", "");
				form.clearErrors();
			},
			onError: (error: BetterAuthClientError) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(
							m.update_user_password().toLowerCase(),
						),
					}),
					{
						description: error.message || m.an_unexpected_error_occured(),
					},
				);
				form.setError("password", { message: error.message });
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
