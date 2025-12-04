import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type RejectDriver, RejectDriverSchema } from "@repo/schema/driver";
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
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient, queryClient } from "@/lib/orpc";

export const RejectDriverDialog = ({ driverId }: { driverId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);

	const form = useForm<RejectDriver>({
		resolver: zodResolver(RejectDriverSchema),
		defaultValues: { reason: "" },
	});

	const mutation = useMutation({
		mutationFn: async (values: RejectDriver) => {
			const result = await orpcClient.driver.main.reject({
				params: { id: driverId },
				body: values,
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result;
		},
		onSuccess: async () => {
			await queryClient.invalidateQueries();
			toast.success(m.success_placeholder({ action: m.reject_driver() }));
			setDialogOpen(false);
			form.setValue("reason", "");
			form.clearErrors();
		},
		onError: (error: Error) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.reject_driver().toLowerCase()),
				}),
				{
					description: error.message || m.an_unexpected_error_occurred(),
				},
			);
			form.setError("reason", { message: error.message });
		},
	});

	const onSubmit = async (values: RejectDriver) => {
		await mutation.mutateAsync(values);
	};

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>
				<Button
					className="w-full justify-start bg-destructive/10 p-2 text-start font-normal text-destructive hover:bg-destructive/20"
					variant="destructive"
					size="sm"
				>
					{m.reject_driver()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.reject_driver()}</DialogTitle>
					<DialogDescription>{m.reject_driver_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="reason"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.reject_reason()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Documents are incomplete..."
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button
								type="submit"
								variant="destructive"
								disabled={mutation.isPending}
							>
								{mutation.isPending ? <Submitting /> : m.reject_driver()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
