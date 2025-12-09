import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { UpdateUserPasswordSchema } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { KeyRound } from "lucide-react";
import { useCallback } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
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

type ChangePasswordDialogProps = {
	children?: React.ReactNode;
	asChild?: boolean;
};

export const ChangePasswordDialog = ({
	children,
	asChild,
}: ChangePasswordDialogProps) => {
	const form = useForm({
		resolver: zodResolver(UpdateUserPasswordSchema),
		defaultValues: {
			oldPassword: "",
			newPassword: "",
			confirmNewPassword: "",
		},
	});

	const mutation = useMutation(
		orpcQuery.user.me.changePassword.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(
					m.success_placeholder({
						action: capitalizeFirstLetter(
							m.update_user_password().toLowerCase(),
						),
					}),
				);
				form.reset();
			},
			onError: (error) => {
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
			},
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			const parsed = UpdateUserPasswordSchema.safeParse(values);
			if (parsed.success) {
				await mutation.mutateAsync({ body: parsed.data });
			}
		},
		[mutation],
	);

	return (
		<Dialog>
			<DialogTrigger asChild={asChild}>
				{children || (
					<Button variant="outline">
						<KeyRound className="mr-2 h-4 w-4" />
						{m.update_user_password()}
					</Button>
				)}
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.update_user_password()}</DialogTitle>
					<DialogDescription>{m.update_user_password_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
						<FormField
							control={form.control}
							name="oldPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Current {m.password()}</FormLabel>
									<FormControl>
										<Input
											type="password"
											placeholder="Enter your current password"
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
							name="newPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.new_password()}</FormLabel>
									<FormControl>
										<Input
											type="password"
											placeholder="Enter your new password"
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
							name="confirmNewPassword"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.confirm_password()}</FormLabel>
									<FormControl>
										<Input
											type="password"
											placeholder="Confirm your new password"
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<div className="flex gap-2 pt-2">
							<Button
								type="submit"
								disabled={mutation.isPending}
								className="w-full"
							>
								{mutation.isPending ? <Submitting /> : m.update_user_password()}
							</Button>
						</div>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
