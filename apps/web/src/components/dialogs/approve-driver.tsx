import { m } from "@repo/i18n";
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
import { orpcClient, queryClient } from "@/lib/orpc";

export const ApproveDriverDialog = ({ driverId }: { driverId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);

	const form = useForm({
		defaultValues: {},
	});

	const mutation = useMutation({
		mutationFn: async () => {
			const result = await orpcClient.driver.main.approve({
				params: { id: driverId },
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result;
		},
		onSuccess: async () => {
			await queryClient.invalidateQueries();
			toast.success(m.success_placeholder({ action: m.approve_driver() }));
			setDialogOpen(false);
			form.clearErrors();
		},
		onError: (error: Error) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.approve_driver().toLowerCase()),
				}),
				{
					description: error.message || m.an_unexpected_error_occurred(),
				},
			);
		},
	});

	const onSubmit = async () => {
		await mutation.mutateAsync();
	};

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>
				<Button
					className="justify-start p-2 text-start font-normal"
					variant="ghost"
					size="sm"
				>
					{m.approve_driver()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.approve_driver()}</DialogTitle>
					<DialogDescription>{m.approve_driver_desc()}</DialogDescription>
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
								{mutation.isPending ? <Submitting /> : m.approve_driver()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
