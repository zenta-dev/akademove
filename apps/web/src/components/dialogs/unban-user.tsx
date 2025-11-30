import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type UnbanUser, UnbanUserSchema } from "@repo/schema/user";
import { capitalizeFirstLetter } from "@repo/shared";
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
import { Form } from "@/components/ui/form";
import { orpcQuery, queryClient } from "@/lib/orpc";

export const UnbanUserDialog = ({ userId }: { userId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);

	const form = useForm<UnbanUser>({
		resolver: zodResolver(UnbanUserSchema),
		defaultValues: { id: userId },
	});

	const mutation = useMutation(
		orpcQuery.user.admin.update.mutationOptions({
			onSuccess: async () => {
				await queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: m.unban_user() }));
				setDialogOpen(false);
				form.clearErrors();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.unban_user().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
			},
		}),
	);

	const onSubmit = async (values: UnbanUser) => {
		await mutation.mutateAsync({ params: { id: userId }, body: values });
	};

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>
				<Button
					className="justify-start p-2 text-start font-normal"
					variant="ghost"
					size="sm"
				>
					{m.unban_user()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.unban_user()}</DialogTitle>
					<DialogDescription>{m.unban_user_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.unban_user()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
