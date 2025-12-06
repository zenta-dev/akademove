import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import z from "zod";
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
	FormMessage,
} from "@/components/ui/form";
import { orpcClient, queryClient } from "@/lib/orpc";
import { Input } from "../ui/input";

export const ActivateDriverDialog = ({ driverId }: { driverId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);

	const form = useForm({
		resolver: zodResolver(z.object({ id: z.string() })),
		defaultValues: {
			id: driverId,
		},
	});

	const mutation = useMutation({
		mutationFn: async () => {
			const result = await orpcClient.driver.activate({
				params: { id: driverId },
			});
			if (result.status !== 200) {
				throw new Error(result.body.message);
			}
			return result;
		},
		onSuccess: async () => {
			await queryClient.invalidateQueries();
			toast.success(m.success_placeholder({ action: m.activate_driver() }));
			setDialogOpen(false);
			form.clearErrors();
		},
		onError: (error: Error) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.activate_driver().toLowerCase()),
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
					{m.activate_driver()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.activate_driver()}</DialogTitle>
					<DialogDescription>{m.activate_driver_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="id"
							render={({ field }) => (
								<FormItem className="hidden">
									<FormControl>
										<Input
											disabled={mutation.isPending}
											{...field}
											value={driverId}
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

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.activate_driver()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
