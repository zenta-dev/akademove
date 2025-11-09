import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { type BanUser, BanUserSchema } from "@repo/schema/user";
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
import { BetterAuthClientError } from "@/lib/error";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";
import { Separator } from "../ui/separator";

export const BanUserDialog = ({ userId }: { userId: string }) => {
	const [dialogOpen, setDialogOpen] = useState(false);
	const [datePickerOpen, setDatePickerOpen] = useState(false);
	const [date, setDate] = useState<Date | undefined>(new Date());
	const [time, setTime] = useState("10:30:00");

	const form = useForm<BanUser>({
		resolver: zodResolver(BanUserSchema),
		defaultValues: { banReason: "", banExpiresIn: undefined },
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
				queryClient.invalidateQueries();
				toast.success(m.success_placeholder({ action: m.ban_user() }));
				setDialogOpen(false);
				form.setValue("banReason", "");
				form.clearErrors();
			},
			onError: (error: BetterAuthClientError) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.ban_user().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
				form.setError("banExpiresIn", { message: error.message });
			},
		}),
	);

	const onSubmit = async (values: BanUser) => {
		let banExpiresIn: number | undefined;
		if (date) {
			const [hours, minutes, seconds] = time.split(":").map(Number);
			date.setHours(hours, minutes, seconds, 0);
			banExpiresIn = date.getTime() - Date.now();
		}
		await mutation.mutateAsync({
			params: { id: userId },
			body: { ...values, banExpiresIn },
		});
	};

	return (
		<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
			<DialogTrigger asChild>
				<Button
					className="w-full justify-start bg-destructive/10 p-2 text-start font-normal text-destructive hover:bg-destructive/20"
					variant="destructive"
					size="sm"
				>
					{m.ban_user()}
				</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.ban_user()}</DialogTitle>
					<DialogDescription>{m.ban_user_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="banReason"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.ban_reason()}</FormLabel>
									<FormControl>
										<Input
											placeholder="You're violating..."
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
							<Label>{m.ban_until()}</Label>
							<div className="flex gap-4">
								<div className="flex flex-col gap-3">
									<Label htmlFor={`date-picker-${userId}`}>Date</Label>
									<Popover
										open={datePickerOpen}
										onOpenChange={setDatePickerOpen}
									>
										<PopoverTrigger asChild>
											<Button
												variant="outline"
												id={`date-picker-${userId}`}
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
									<Label htmlFor={`time-picker-${userId}`}>Time</Label>
									<Input
										type="time"
										id={`time-picker-${userId}`}
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
								{mutation.isPending ? <Submitting /> : m.ban_user()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
