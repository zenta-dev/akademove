import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	BANNER_ACTION_TYPE,
	BANNER_PLACEMENT,
	BANNER_TARGET_AUDIENCE,
	type Banner,
	InsertBannerSchema,
	UpdateBannerSchema,
} from "@repo/schema/banner";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useRouter } from "@tanstack/react-router";
import { format } from "date-fns";
import { CalendarIcon, Check } from "lucide-react";
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
import { Input } from "@/components/ui/input";
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover";
import { Textarea } from "@/components/ui/textarea";
import { orpcQuery, queryClient } from "@/lib/orpc";
import type { FileRouteTypes } from "@/routeTree.gen";
import { cn } from "@/utils/cn";

const PLACEMENT_OPTIONS = [
	{ id: BANNER_PLACEMENT.USER_HOME, name: m.banner_placement_user_home() },
	{ id: BANNER_PLACEMENT.DRIVER_HOME, name: m.banner_placement_driver_home() },
	{
		id: BANNER_PLACEMENT.MERCHANT_HOME,
		name: m.banner_placement_merchant_home(),
	},
] as const;

const TARGET_AUDIENCE_OPTIONS = [
	{ id: BANNER_TARGET_AUDIENCE.ALL, name: m.banner_target_audience_all() },
	{ id: BANNER_TARGET_AUDIENCE.USERS, name: m.banner_target_audience_users() },
	{
		id: BANNER_TARGET_AUDIENCE.DRIVERS,
		name: m.banner_target_audience_drivers(),
	},
	{
		id: BANNER_TARGET_AUDIENCE.MERCHANTS,
		name: m.banner_target_audience_merchants(),
	},
] as const;

const ACTION_TYPE_OPTIONS = [
	{ id: BANNER_ACTION_TYPE.NONE, name: "None" },
	{ id: BANNER_ACTION_TYPE.LINK, name: "External Link" },
	{ id: BANNER_ACTION_TYPE.ROUTE, name: "App Route" },
] as const;

export const BannerForm = ({
	kind,
	banner,
	onSuccess,
}: {
	kind: "new" | "edit";
	banner?: Banner;
	onSuccess?: () => Promise<void>;
}) => {
	const router = useRouter();
	const form = useForm({
		resolver: zodResolver(
			kind === "new" ? InsertBannerSchema : UpdateBannerSchema,
		),
		defaultValues:
			kind === "edit" && banner
				? {
						title: banner.title,
						description: banner.description,
						imageUrl: banner.imageUrl,
						actionType: banner.actionType,
						actionValue: banner.actionValue,
						placement: banner.placement,
						targetAudience: banner.targetAudience,
						isActive: banner.isActive,
						priority: banner.priority,
						startAt: banner.startAt,
						endAt: banner.endAt,
					}
				: {
						title: "",
						description: null,
						imageUrl: "",
						actionType: "NONE" as const,
						actionValue: null,
						placement: "USER_HOME" as const,
						targetAudience: "ALL" as const,
						isActive: true,
						priority: 0,
						startAt: null,
						endAt: null,
					},
	});

	const _onSuccess = useCallback(
		async (kind: "insert" | "update") => {
			await queryClient.invalidateQueries();
			toast.success(
				m.success_placeholder({
					action: capitalizeFirstLetter(
						(kind === "insert"
							? m.banner_create()
							: m.banner_update()
						).toLowerCase(),
					),
				}),
			);
			form.reset();
			await onSuccess?.();
		},
		[form, onSuccess],
	);

	const onError = useCallback((kind: "insert" | "update", error: Error) => {
		toast.error(
			m.failed_placeholder({
				action: capitalizeFirstLetter(
					(kind === "insert"
						? m.banner_create()
						: m.banner_update()
					).toLowerCase(),
				),
			}),
			{
				description: error.message || m.an_unexpected_error_occurred(),
			},
		);
	}, []);

	const insertMutation = useMutation(
		orpcQuery.banner.create.mutationOptions({
			onSuccess: () => _onSuccess("insert"),
			onError: (error: Error) => onError("insert", error),
		}),
	);

	const updateMutation = useMutation(
		orpcQuery.banner.update.mutationOptions({
			onSuccess: () => _onSuccess("update"),
			onError: (error: Error) => onError("update", error),
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			if (kind === "new") {
				const parse = InsertBannerSchema.safeParse(values);
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

			if (kind === "edit" && banner) {
				const parse = UpdateBannerSchema.safeParse(values);
				if (parse.success) {
					await updateMutation.mutateAsync({
						params: { id: banner.id },
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
		[banner, insertMutation, updateMutation, kind],
	);

	const isLoading = useMemo(
		() =>
			kind === "new" ? insertMutation.isPending : updateMutation.isPending,
		[kind, insertMutation.isPending, updateMutation.isPending],
	);

	const watchedActionType = form.watch("actionType");

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit(onSubmit)}
				className="grid grid-cols-1 gap-4 md:grid-cols-2"
			>
				<FormField
					control={form.control}
					name="title"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_title()}</FormLabel>
							<FormControl>
								<Input
									placeholder="Summer Promo"
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
					name="imageUrl"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_image_url()}</FormLabel>
							<FormControl>
								<Input
									placeholder="https://example.com/image.png"
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
					name="description"
					render={({ field }) => (
						<FormItem className="md:col-span-2">
							<FormLabel>{m.banner_description()}</FormLabel>
							<FormControl>
								<Textarea
									placeholder="Optional description for the banner"
									disabled={isLoading}
									{...field}
									value={field.value ?? ""}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<FormField
					control={form.control}
					name="placement"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_placement()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild disabled={isLoading}>
									<FormControl>
										<Button
											variant="outline"
											role="combobox"
											className="justify-between"
										>
											{field.value
												? PLACEMENT_OPTIONS.find((v) => field.value === v.id)
														?.name
												: m.select_placeholder({ field: m.banner_placement() })}
										</Button>
									</FormControl>
								</PopoverTrigger>
								<PopoverContent className="p-0">
									<Command>
										<CommandInput
											placeholder={m.search_placeholder({
												field: m.banner_placement(),
											})}
											className="h-9"
										/>
										<CommandList>
											<CommandEmpty>
												{m.no_results_placeholder({
													field: m.banner_placement().toLowerCase(),
												})}
											</CommandEmpty>
											<CommandGroup>
												{PLACEMENT_OPTIONS.map((option) => (
													<CommandItem
														key={option.id}
														value={option.id}
														onSelect={() => field.onChange(option.id)}
													>
														{option.name}
														<Check
															className={cn(
																"ml-auto",
																field.value === option.id
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
					name="targetAudience"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_target_audience()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild disabled={isLoading}>
									<FormControl>
										<Button
											variant="outline"
											role="combobox"
											className="justify-between"
										>
											{field.value
												? TARGET_AUDIENCE_OPTIONS.find(
														(v) => field.value === v.id,
													)?.name
												: m.select_placeholder({
														field: m.banner_target_audience(),
													})}
										</Button>
									</FormControl>
								</PopoverTrigger>
								<PopoverContent className="p-0">
									<Command>
										<CommandInput
											placeholder={m.search_placeholder({
												field: m.banner_target_audience(),
											})}
											className="h-9"
										/>
										<CommandList>
											<CommandEmpty>
												{m.no_results_placeholder({
													field: m.banner_target_audience().toLowerCase(),
												})}
											</CommandEmpty>
											<CommandGroup>
												{TARGET_AUDIENCE_OPTIONS.map((option) => (
													<CommandItem
														key={option.id}
														value={option.id}
														onSelect={() => field.onChange(option.id)}
													>
														{option.name}
														<Check
															className={cn(
																"ml-auto",
																field.value === option.id
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
					name="actionType"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_action_type()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild disabled={isLoading}>
									<FormControl>
										<Button
											variant="outline"
											role="combobox"
											className="justify-between"
										>
											{field.value
												? ACTION_TYPE_OPTIONS.find((v) => field.value === v.id)
														?.name
												: m.select_placeholder({
														field: m.banner_action_type(),
													})}
										</Button>
									</FormControl>
								</PopoverTrigger>
								<PopoverContent className="p-0">
									<Command>
										<CommandInput
											placeholder={m.search_placeholder({
												field: m.banner_action_type(),
											})}
											className="h-9"
										/>
										<CommandList>
											<CommandEmpty>
												{m.no_results_placeholder({
													field: m.banner_action_type().toLowerCase(),
												})}
											</CommandEmpty>
											<CommandGroup>
												{ACTION_TYPE_OPTIONS.map((option) => (
													<CommandItem
														key={option.id}
														value={option.id}
														onSelect={() => field.onChange(option.id)}
													>
														{option.name}
														<Check
															className={cn(
																"ml-auto",
																field.value === option.id
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

				{watchedActionType !== "NONE" && (
					<FormField
						control={form.control}
						name="actionValue"
						render={({ field }) => (
							<FormItem>
								<FormLabel>{m.banner_action_value()}</FormLabel>
								<FormControl>
									<Input
										placeholder={
											watchedActionType === "LINK"
												? "https://example.com"
												: "/home"
										}
										disabled={isLoading}
										{...field}
										value={field.value ?? ""}
									/>
								</FormControl>
								<FormMessage />
							</FormItem>
						)}
					/>
				)}

				<FormField
					control={form.control}
					name="priority"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_priority()}</FormLabel>
							<FormControl>
								<Input
									type="number"
									placeholder="0"
									disabled={isLoading}
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
					name="startAt"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_start_at()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild>
									<FormControl>
										<Button
											variant="outline"
											className={cn(
												"pl-3 text-left font-normal",
												!field.value && "text-muted-foreground",
											)}
											disabled={isLoading}
										>
											{field.value ? (
												format(field.value as Date | string, "PPP")
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
											field.value
												? new Date(field.value as Date | string)
												: undefined
										}
										onSelect={(val) =>
											field.onChange(val ? val.toISOString() : null)
										}
										disabled={isLoading}
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
					name="endAt"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.banner_end_at()}</FormLabel>
							<Popover>
								<PopoverTrigger asChild>
									<FormControl>
										<Button
											variant="outline"
											className={cn(
												"pl-3 text-left font-normal",
												!field.value && "text-muted-foreground",
											)}
											disabled={isLoading}
										>
											{field.value ? (
												format(field.value as Date | string, "PPP")
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
											field.value
												? new Date(field.value as Date | string)
												: undefined
										}
										onSelect={(val) =>
											field.onChange(val ? val.toISOString() : null)
										}
										disabled={isLoading}
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
					name="isActive"
					render={({ field }) => (
						<FormItem className="md:col-span-2">
							<FormLabel>{m.banner_is_active()}</FormLabel>
							<FormControl>
								<div className="flex items-center gap-2">
									<Checkbox
										checked={field.value ?? false}
										onCheckedChange={field.onChange}
										disabled={isLoading}
									/>
									<p className="text-muted-foreground text-sm">
										{m.banner_activate_desc()}
									</p>
								</div>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>

				<Button
					type="submit"
					disabled={isLoading}
					className="w-full md:col-span-2"
				>
					{isLoading ? (
						<Submitting />
					) : kind === "new" ? (
						m.banner_create()
					) : (
						m.banner_update()
					)}
				</Button>
			</form>
		</Form>
	);
};
