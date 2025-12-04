import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import type { DayOfWeek } from "@repo/schema/common";
import {
	type Coupon,
	type GeneralRuleType,
	InsertCouponSchema,
	UpdateCouponSchema,
} from "@repo/schema/coupon";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useRouter } from "@tanstack/react-router";
import { format } from "date-fns";
import { CalendarIcon, Check, InfoIcon } from "lucide-react";
import { useCallback, useMemo } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import { Calendar } from "@/components/ui/calendar";
import { Checkbox } from "@/components/ui/checkbox";
import {
	Command,
	CommandEmpty,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
} from "@/components/ui/command";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import {
	HoverCard,
	HoverCardContent,
	HoverCardTrigger,
} from "@/components/ui/hover-card";
import { Input } from "@/components/ui/input";
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

const GENERAL_RULE_TYPES: { id: GeneralRuleType; name: string }[] = [
	{
		id: "PERCENTAGE",
		name: m.percentage(),
	},
	{
		id: "FIXED",
		name: m.fixed(),
	},
] as const;

const DAY_OF_WEEKS: { id: DayOfWeek; name: string }[] = [
	{
		id: "SUNDAY",
		name: m.sunday(),
	},
	{
		id: "MONDAY",
		name: m.monday(),
	},
	{
		id: "TUESDAY",
		name: m.tuesday(),
	},
	{
		id: "WEDNESDAY",
		name: m.wednesday(),
	},
	{
		id: "THURSDAY",
		name: m.thursday(),
	},
	{
		id: "FRIDAY",
		name: m.friday(),
	},
	{
		id: "SATURDAY",
		name: m.saturday(),
	},
] as const;

export const CouponForm = ({
	kind,
	coupon,
}: {
	kind: "new" | "edit";
	coupon?: Coupon;
}) => {
	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(
			kind === "new" ? InsertCouponSchema : UpdateCouponSchema,
		),
		defaultValues:
			kind === "edit" && coupon
				? coupon
				: {
						name: "",
						code: "",
						rules: {
							general: {
								type: "PERCENTAGE" as const,
								minOrderAmount: undefined,
								maxDiscountAmount: undefined,
							},
							user: {
								newUserOnly: undefined,
							},
							time: {
								allowedDays: undefined,
								allowedHours: undefined,
							},
						},
						discountAmount: 0,
						discountPercentage: 0,
						usageLimit: 1,
						periodStart: new Date(),
						periodEnd: new Date(),
						isActive: true,
					},
	});

	const onSuccess = useCallback(
		async (kind: "insert" | "update") => {
			await queryClient.invalidateQueries();
			toast.success(
				m.success_placeholder({
					action: capitalizeFirstLetter(
						(kind === "insert"
							? m.create_coupon()
							: m.update_coupon()
						).toLowerCase(),
					),
				}),
			);
			form.reset();
			await router.navigate({
				to: "/dash/operator/coupons",
				// @ts-expect-error - search params type mismatch
				search: {},
			});
		},
		[form.reset, router.navigate],
	);

	const onError = useCallback((kind: "insert" | "update", error: Error) => {
		toast.error(
			m.failed_placeholder({
				action: capitalizeFirstLetter(
					(kind === "insert"
						? m.create_coupon()
						: m.update_coupon()
					).toLowerCase(),
				),
			}),
			{
				description: error.message || m.an_unexpected_error_occurred(),
			},
		);
	}, []);

	const insertMutation = useMutation(
		orpcQuery.coupon.create.mutationOptions({
			onSuccess: () => onSuccess("insert"),
			onError: (error) => onError("insert", error),
		}),
	);

	const updateMutation = useMutation(
		orpcQuery.coupon.update.mutationOptions({
			onSuccess: () => onSuccess("update"),
			onError: (error) => onError("update", error),
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			if (kind === "new") {
				const parse = InsertCouponSchema.safeParse(values);
				if (parse.success) {
					await insertMutation.mutateAsync({ body: parse.data });
				} else {
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
				}
			}

			if (kind === "edit" && coupon) {
				const parse = UpdateCouponSchema.safeParse(values);
				if (parse.success) {
					await updateMutation.mutateAsync({
						params: { id: coupon.id },
						body: parse.data,
					});
				} else {
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
				}
			}
		},
		[coupon, insertMutation, updateMutation, kind],
	);

	const isLoading = useMemo(
		() =>
			kind === "new" ? insertMutation.isPending : updateMutation.isPending,
		[kind, insertMutation.isPending, updateMutation.isPending],
	);

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit(onSubmit)}
				className="grid grid-cols-1 gap-4 md:grid-cols-2"
			>
				<FormField
					control={form.control}
					name="name"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.name()}</FormLabel>
							<FormControl>
								<Input
									placeholder="Dies Natalies Event"
									disabled={isLoading}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="code"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.code()}</FormLabel>
							<FormControl>
								<Input placeholder="DNE-2025" disabled={isLoading} {...field} />
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="periodStart"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.period_start()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild>
									<FormControl>
										<Button
											variant={"outline"}
											className={cn(
												"pl-3 text-left font-normal",
												!field.value && "text-muted-foreground",
											)}
											disabled={isLoading}
										>
											{field.value ? (
												format(field.value as Date | number, "PPP")
											) : (
												<span>{m.pick_a_date()}</span>
											)}
											<CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
										</Button>
									</FormControl>
								</PopoverTrigger>
								<PopoverContent className="w-auto p-0" align="start">
									<Calendar
										mode="single"
										selected={
											typeof field.value === "number"
												? new Date(field.value)
												: undefined
										}
										onSelect={(val) => field.onChange(val?.getTime())}
										disabled={(date) => {
											if (isLoading) return true;
											const endDate = form.getValues("periodEnd");
											if (typeof endDate === "number") {
												return date > new Date(endDate);
											}
											return false;
										}}
										captionLayout="dropdown"
									/>
								</PopoverContent>
							</Popover>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="periodEnd"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.period_end()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild>
									<FormControl>
										<Button
											variant={"outline"}
											className={cn(
												"pl-3 text-left font-normal",
												!field.value && "text-muted-foreground",
											)}
											disabled={isLoading}
										>
											{field.value ? (
												format(field.value as Date | number, "PPP")
											) : (
												<span>{m.pick_a_date()}</span>
											)}
											<CalendarIcon className="ml-auto h-4 w-4 opacity-50" />
										</Button>
									</FormControl>
								</PopoverTrigger>
								<PopoverContent className="w-auto p-0" align="start">
									<Calendar
										mode="single"
										selected={
											typeof field.value === "number"
												? new Date(field.value)
												: undefined
										}
										onSelect={(val) => field.onChange(val?.getTime())}
										disabled={(date) => {
											if (isLoading) return true;
											const startDate = form.getValues("periodStart");
											if (typeof startDate === "number") {
												return date < new Date(startDate);
											}
											return false;
										}}
										captionLayout="dropdown"
									/>
								</PopoverContent>
							</Popover>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="discountAmount"
					render={({ field }) => (
						<FormItem>
							<div className="flex items-center gap-2">
								<FormLabel>{m.discount_amount()}</FormLabel>
								<HoverCard>
									<HoverCardTrigger asChild>
										<Button
											variant="ghost"
											className="p-0 text-muted-foreground has-[>svg]:p-0"
										>
											<InfoIcon />
										</Button>
									</HoverCardTrigger>
									<HoverCardContent className="w-80 p-2">
										<p className="text-sm">
											{m.discount_hint_placeholder({
												field: m.discount_percentage().toLowerCase(),
											})}
										</p>
									</HoverCardContent>
								</HoverCard>
							</div>
							<FormControl>
								<Input
									disabled={isLoading}
									type="number"
									{...field}
									onChange={(e) => field.onChange(Number(e.target.value))}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="discountPercentage"
					render={({ field }) => (
						<FormItem>
							<div className="flex items-center gap-2">
								<FormLabel>{m.discount_percentage()}</FormLabel>
								<HoverCard>
									<HoverCardTrigger asChild>
										<Button
											variant="ghost"
											className="p-0 text-muted-foreground has-[>svg]:p-0"
										>
											<InfoIcon />
										</Button>
									</HoverCardTrigger>
									<HoverCardContent className="w-80 p-2">
										<p className="text-sm">
											{m.discount_hint_placeholder({
												field: m.discount_amount().toLowerCase(),
											})}
										</p>
									</HoverCardContent>
								</HoverCard>
							</div>
							<FormControl>
								<Input
									disabled={isLoading}
									type="number"
									{...field}
									onChange={(e) => field.onChange(Number(e.target.value))}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="usageLimit"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.usage_limit()}</FormLabel>
							<FormControl>
								<Input
									disabled={isLoading}
									type="number"
									{...field}
									onChange={(e) => field.onChange(Number(e.target.value))}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="isActive"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.is_active()}</FormLabel>
							<FormControl>
								<div className="flex flex-col items-center gap-2 md:flex-row">
									<Checkbox
										checked={field.value ?? false}
										onCheckedChange={field.onChange}
										disabled={isLoading}
									/>
									<p className="text-muted-foreground text-sm">
										{m.coupon_is_active_desc()}
									</p>
								</div>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<Tabs defaultValue="general" className="col-span-2 w-full">
					<p>{m.rules()}</p>
					<TabsList className="w-full">
						<TabsTrigger value="general">{m.general()}</TabsTrigger>
						<TabsTrigger value="user">{m.user()}</TabsTrigger>
						<TabsTrigger value="time">{m.time()}</TabsTrigger>
					</TabsList>
					<TabsContent
						value="general"
						className="w-full rounded-lg border bg-background/10 p-3"
					>
						<div className="grid grid-cols-1 gap-4 md:grid-cols-3">
							<FormField
								control={form.control}
								name="rules.general.type"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.type()}</FormLabel>
										<Popover>
											<PopoverTrigger asChild disabled={isLoading}>
												<FormControl>
													<Button
														variant="outline"
														role="combobox"
														className="justify-between"
													>
														{field.value
															? GENERAL_RULE_TYPES.find(
																	(v) => field.value === v.id,
																)?.name
															: m.select_placeholder({ field: m.type() })}
													</Button>
												</FormControl>
											</PopoverTrigger>
											<PopoverContent className="p-0">
												<Command>
													<CommandInput
														placeholder={m.search_placeholder({
															field: m.type(),
														})}
														className="h-9"
													/>
													<CommandList>
														<CommandEmpty>
															{m.no_results_placeholder({
																field: m.type().toLowerCase(),
															})}
															.
														</CommandEmpty>
														<CommandGroup>
															{GENERAL_RULE_TYPES.map((type) => (
																<CommandItem
																	key={type.id}
																	value={type.id}
																	onSelect={() => field.onChange(type.id)}
																>
																	{type.name}
																	<Check
																		className={cn(
																			"ml-auto",
																			field.value === type.id
																				? "opacity-100"
																				: "opacity-0",
																		)}
																	/>
																</CommandItem>
															))}
														</CommandGroup>
													</CommandList>
												</Command>
											</PopoverContent>
										</Popover>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="rules.general.minOrderAmount"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.min_order_amount()}</FormLabel>
										<FormControl>
											<Input
												disabled={isLoading}
												type="number"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="rules.general.maxDiscountAmount"
								render={({ field }) => (
									<FormItem>
										<FormLabel>{m.max_discount_amount()}</FormLabel>
										<FormControl>
											<Input
												disabled={isLoading}
												type="number"
												{...field}
												onChange={(e) => field.onChange(Number(e.target.value))}
											/>
										</FormControl>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>
					</TabsContent>
					<TabsContent
						value="user"
						className="w-full rounded-lg border bg-background/10 p-3"
					>
						<FormField
							control={form.control}
							name="rules.user.newUserOnly"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.new_user_only()}</FormLabel>
									<FormControl>
										<div className="flex flex-col items-center gap-2 md:flex-row">
											<Checkbox
												checked={field.value ?? false}
												onCheckedChange={field.onChange}
												disabled={isLoading}
											/>
											<p className="text-muted-foreground text-sm">
												{m.new_user_only_desc()}
											</p>
										</div>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
					</TabsContent>
					<TabsContent
						value="time"
						className="grid w-full grid-cols-1 gap-4 rounded-lg border bg-background/10 p-3"
					>
						<div>
							<p>{m.allowed_days()}</p>
							<div className="mt-2 flex flex-wrap items-center gap-4 md:flex-row md:flex-nowrap">
								{DAY_OF_WEEKS.map((item) => (
									<FormField
										key={item.id}
										control={form.control}
										name="rules.time.allowedDays"
										render={({ field }) => (
											<FormItem className="flex flex-col items-center gap-2 md:flex-row">
												<FormControl>
													<Checkbox
														checked={field.value?.includes(item.id) ?? false}
														onCheckedChange={(checked) => {
															const currentValue = field.value || [];
															const newValue = checked
																? [...currentValue, item.id]
																: currentValue.filter(
																		(value) => value !== item.id,
																	);
															field.onChange(newValue);
														}}
														disabled={isLoading}
													/>
												</FormControl>
												<FormLabel className="font-normal text-sm">
													{item.name}
												</FormLabel>
											</FormItem>
										)}
									/>
								))}
							</div>
						</div>
						<FormField
							control={form.control}
							name="rules.time.allowedHours"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.allowed_hours()}</FormLabel>
									<FormControl>
										<Input
											type="text"
											placeholder="0,1,2,8,9,10"
											value={field.value?.join(",") || ""}
											onChange={(e) => {
												const value = e.target.value;
												if (!value.trim()) {
													field.onChange(undefined);
													return;
												}
												const hours = value
													.split(",")
													.map((h) => Number.parseInt(h.trim(), 10))
													.filter((h) => !Number.isNaN(h) && h >= 0 && h <= 23);
												field.onChange(hours);
											}}
											disabled={isLoading}
										/>
									</FormControl>
									<p className="text-muted-foreground text-xs">
										Enter comma-separated hours (0-23)
									</p>
									<FormMessage />
								</FormItem>
							)}
						/>
					</TabsContent>
				</Tabs>
				<Button
					type="submit"
					disabled={isLoading}
					className="w-full md:col-span-2"
				>
					{isLoading ? (
						<Submitting />
					) : kind === "new" ? (
						m.create_coupon()
					) : (
						m.update_coupon()
					)}
				</Button>
			</form>
		</Form>
	);
};
