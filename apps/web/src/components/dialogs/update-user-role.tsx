import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type UpdateUserRole, UpdateUserRoleSchema } from "@repo/schema/user";
import { capitalizeFirstLetter, ROLES_TYPED } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
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
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { orpcQuery, queryClient } from "@/lib/orpc";

export const UpdateUserRoleDialog = ({ userId }: { userId: string }) => {
	const [open, setOpen] = useState(false);
	const form = useForm<UpdateUserRole>({
		// biome-ignore lint/suspicious/noExplicitAny: Required for zodResolver type compatibility with z.coerce
		resolver: zodResolver(UpdateUserRoleSchema) as any,
		defaultValues: { role: "USER" },
	});

	const mutation = useMutation(
		orpcQuery.user.admin.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: m.update_user_role() }));
				setOpen(false);
				form.setValue("role", "USER");
				form.clearErrors();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.update_user_role().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
				form.setError("role", { message: error.message });
			},
		}),
	);

	const onSubmit = async (values: UpdateUserRole) => {
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
					{m.update_user_role()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.update_user_role()}</DialogTitle>
					<DialogDescription>{m.update_user_role_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="role"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.role()}</FormLabel>
									<Select
										onValueChange={field.onChange}
										defaultValue={field.value}
									>
										<FormControl>
											<SelectTrigger className="w-full">
												<SelectValue />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											{ROLES_TYPED.map((e) => (
												<SelectItem key={e.id} value={e.id}>
													{e.name}
												</SelectItem>
											))}
										</SelectContent>
									</Select>
									<FormMessage />
								</FormItem>
							)}
						/>
						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.update_user_role()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
