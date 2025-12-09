import { m } from "@repo/i18n";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { ChevronDownIcon } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
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
import { Label } from "@/components/ui/label";
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover";
import { Separator } from "@/components/ui/separator";
import { Textarea } from "@/components/ui/textarea";
import { orpcClient, queryClient } from "@/lib/orpc";

type SuspendDriverForm = {
	reason: string;
	suspendUntil?: Date;
};

export const SuspendDriverDialog = ({ driverId }: { driverId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);
	const [datePickerOpen, setDatePickerOpen] = useState(false);
	const [date, setDate] = useState<Date | undefined>(undefined);
	const [time, setTime] = useState("10:30:00");

	const form = useForm({
		defaultValues: { reason: "", suspendUntil: undefined },
	});

	const mutation = useMutation({
		mutationFn: async (values: SuspendDriverForm) => {
			const result = await orpcClient.driver.suspend({
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
			toast.success(m.success_placeholder({ action: m.suspend_driver() }));
			setDialogOpen(false);
			form.setValue("reason", "");
			form.setValue("suspendUntil", undefined);
			setDate(undefined);
			form.clearErrors();
		},
		onError: (error: Error) => {
			toast.error(
				m.failed_placeholder({
					action: capitalizeFirstLetter(m.suspend_driver().toLowerCase()),
				}),
				{
					description: error.message || m.an_unexpected_error_occurred(),
				},
			);
			form.setError("reason", { message: error.message });
		},
	});

	const onSubmit = async (values: SuspendDriverForm) => {
		let suspendUntil: Date | undefined;
		if (date) {
			const [hours, minutes, seconds] = time.split(":").map(Number);
			date.setHours(hours, minutes, seconds, 0);
			suspendUntil = date;
		}
		await mutation.mutateAsync({ ...values, suspendUntil });
	};

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>
				<Button
					className="w-full justify-start bg-yellow-500/10 p-2 text-start font-normal text-yellow-700 hover:bg-yellow-500/20 dark:text-yellow-500"
					variant="ghost"
					size="sm"
				>
					{m.suspend_driver()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.suspend_driver()}</DialogTitle>
					<DialogDescription>{m.suspend_driver_desc()}</DialogDescription>
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
									<FormLabel>{m.suspend_reason()}</FormLabel>
									<FormControl>
										<Textarea
											placeholder="Multiple customer complaints..."
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						<Separator className="my-2" />

						<div className="flex flex-col gap-2">
							<Label>{m.suspend_until()} (Optional)</Label>
							<div className="flex gap-4">
								<div className="flex flex-col gap-3">
									<Label htmlFor={`date-picker-${driverId}`}>Date</Label>
									<Popover
										open={datePickerOpen}
										onOpenChange={setDatePickerOpen}
									>
										<PopoverTrigger asChild>
											<Button
												variant="outline"
												id={`date-picker-${driverId}`}
												className="w-32 justify-between font-normal"
											>
												{date ? date.toLocaleDateString() : "Select date"}
												<ChevronDownIcon />
											</Button>
										</PopoverTrigger>
										<PopoverContent
											className="w-auto overflow-hidden p-0"
											align="start"
										>
											<Calendar
												mode="single"
												selected={date}
												captionLayout="dropdown"
												onSelect={(date) => {
													setDate(date);
													setDatePickerOpen(false);
												}}
											/>
										</PopoverContent>
									</Popover>
								</div>
								<div className="flex flex-col gap-3">
									<Label htmlFor={`time-picker-${driverId}`}>Time</Label>
									<Input
										type="time"
										id={`time-picker-${driverId}`}
										step="1"
										defaultValue="10:30:00"
										onChange={(e) => setTime(e.target.value)}
										className="appearance-none bg-background [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
									/>
								</div>
							</div>
						</div>

						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.suspend_driver()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
