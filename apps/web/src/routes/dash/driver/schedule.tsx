import { m } from "@repo/i18n";
import type { DayOfWeek, Time } from "@repo/schema/common";
import type { DriverSchedule } from "@repo/schema/driver";
import { UnifiedPaginationQuerySchema } from "@repo/schema/pagination";
import { useMutation, useQuery } from "@tanstack/react-query";
import { createFileRoute, redirect, useNavigate } from "@tanstack/react-router";
import {
	Calendar,
	CalendarDays,
	Clock,
	Plus,
	Repeat,
	Trash2,
} from "lucide-react";
import { useMemo, useState } from "react";
import { toast } from "sonner";
import {
	AlertDialog,
	AlertDialogAction,
	AlertDialogCancel,
	AlertDialogContent,
	AlertDialogDescription,
	AlertDialogFooter,
	AlertDialogHeader,
	AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Skeleton } from "@/components/ui/skeleton";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { hasAccess } from "@/lib/actions";
import { SUB_ROUTE_TITLES } from "@/lib/constants";
import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc";

export const Route = createFileRoute("/dash/driver/schedule")({
	validateSearch: (values) => {
		const search = UnifiedPaginationQuerySchema.parse(values);
		if (!values.limit) return { ...search, page: 1, limit: 50 };
		return search;
	},
	head: () => ({ meta: [{ title: SUB_ROUTE_TITLES.DRIVER.SCHEDULE }] }),
	beforeLoad: async () => {
		const ok = await hasAccess(["DRIVER"]);
		if (!ok) redirect({ to: "/", throw: true });

		// Check if driver has passed quiz
		try {
			const driverResult = await orpcClient.driver.getMine();
			if (driverResult.body.data.quizStatus !== "PASSED") {
				redirect({ to: "/quiz/driver", throw: true });
			}
		} catch (error) {
			console.error("Failed to check quiz status:", error);
			redirect({ to: "/", throw: true });
		}

		return { allowed: ok };
	},
	loader: ({ context }) => {
		return { allowed: context.allowed };
	},
	component: RouteComponent,
});

const DAYS_OF_WEEK: { value: DayOfWeek; label: string }[] = [
	{ value: "MONDAY", label: "Monday" },
	{ value: "TUESDAY", label: "Tuesday" },
	{ value: "WEDNESDAY", label: "Wednesday" },
	{ value: "THURSDAY", label: "Thursday" },
	{ value: "FRIDAY", label: "Friday" },
	{ value: "SATURDAY", label: "Saturday" },
	{ value: "SUNDAY", label: "Sunday" },
];

interface ScheduleFormData {
	name: string;
	dayOfWeek: DayOfWeek;
	startTime: string; // HH:MM format
	endTime: string; // HH:MM format
	isRecurring: boolean;
	specificDate?: string; // YYYY-MM-DD format
	isActive: boolean;
}

function timeToObject(timeStr: string): Time {
	const [h, m] = timeStr.split(":").map(Number);
	return { h, m };
}

function timeFromObject(time: Time): string {
	return `${String(time.h).padStart(2, "0")}:${String(time.m).padStart(2, "0")}`;
}

function generateScheduleName(
	isRecurring: boolean,
	dayOfWeek: DayOfWeek,
	startTime: string,
	endTime: string,
	specificDate?: string,
): string {
	if (!isRecurring && specificDate) {
		return `${specificDate} ${startTime}-${endTime}`;
	}
	const day =
		DAYS_OF_WEEK.find((d) => d.value === dayOfWeek)?.label || dayOfWeek;
	return `${day} ${startTime}-${endTime}`;
}

function RouteComponent() {
	const { allowed } = Route.useLoaderData();
	const navigate = useNavigate();
	const search = Route.useSearch();

	const [dialogOpen, setDialogOpen] = useState(false);
	const [editingSchedule, setEditingSchedule] = useState<DriverSchedule | null>(
		null,
	);
	const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
	const [scheduleToDelete, setScheduleToDelete] =
		useState<DriverSchedule | null>(null);

	// Form state
	const [formData, setFormData] = useState<ScheduleFormData>({
		name: "",
		dayOfWeek: "MONDAY",
		startTime: "08:00",
		endTime: "10:00",
		isRecurring: true,
		specificDate: "",
		isActive: true,
	});

	if (!allowed) navigate({ to: "/" });

	// Fetch driver profile to get driverId
	const { data: driverResponse, isLoading: driverLoading } = useQuery(
		orpcQuery.driver.getMine.queryOptions({}),
	);

	const driver = useMemo(() => driverResponse?.body.data, [driverResponse]);

	// Fetch schedules
	const {
		data: schedulesResponse,
		isLoading: schedulesLoading,
		refetch,
	} = useQuery(
		orpcQuery.driver.schedule.list.queryOptions({
			input: {
				params: { driverId: driver?.id || "" },
				query: search,
			},
			enabled: !!driver?.id,
		}),
	);

	const schedulesResult = useMemo(
		() => schedulesResponse?.body.data,
		[schedulesResponse],
	);

	// Create schedule mutation
	const createMutation = useMutation(
		orpcQuery.driver.schedule.create.mutationOptions({
			onSuccess: () => {
				toast.success("Schedule created successfully");
				setDialogOpen(false);
				resetForm();
				queryClient.invalidateQueries();
				refetch();
			},
			onError: (error: Error) => {
				toast.error(`Failed to create schedule: ${error.message}`);
			},
		}),
	);

	// Update schedule mutation
	const updateMutation = useMutation(
		orpcQuery.driver.schedule.update.mutationOptions({
			onSuccess: () => {
				toast.success("Schedule updated successfully");
				setDialogOpen(false);
				setEditingSchedule(null);
				resetForm();
				queryClient.invalidateQueries();
				refetch();
			},
			onError: (error: Error) => {
				toast.error(`Failed to update schedule: ${error.message}`);
			},
		}),
	);

	// Delete schedule mutation
	const deleteMutation = useMutation(
		orpcQuery.driver.schedule.remove.mutationOptions({
			onSuccess: () => {
				toast.success("Schedule deleted successfully");
				setDeleteDialogOpen(false);
				setScheduleToDelete(null);
				queryClient.invalidateQueries();
				refetch();
			},
			onError: (error: Error) => {
				toast.error(`Failed to delete schedule: ${error.message}`);
			},
		}),
	);

	const resetForm = () => {
		setFormData({
			name: "",
			dayOfWeek: "MONDAY",
			startTime: "08:00",
			endTime: "10:00",
			isRecurring: true,
			specificDate: "",
			isActive: true,
		});
	};

	const handleOpenDialog = (schedule?: DriverSchedule) => {
		if (schedule) {
			setEditingSchedule(schedule);
			setFormData({
				name: schedule.name,
				dayOfWeek: schedule.dayOfWeek,
				startTime: timeFromObject(schedule.startTime),
				endTime: timeFromObject(schedule.endTime),
				isRecurring: schedule.isRecurring,
				specificDate: schedule.specificDate
					? new Date(schedule.specificDate).toISOString().split("T")[0]
					: "",
				isActive: schedule.isActive,
			});
		} else {
			setEditingSchedule(null);
			resetForm();
		}
		setDialogOpen(true);
	};

	const handleSubmit = () => {
		if (!driver) {
			toast.error("Driver profile not found");
			return;
		}
		if (editingSchedule) {
			updateMutation.mutate({
				params: { id: editingSchedule.id, driverId: driver?.id },
				body: {
					...formData,
					startTime: timeToObject(formData.startTime),
					endTime: timeToObject(formData.endTime),
				},
			});
		} else {
			createMutation.mutate({
				params: { driverId: driver?.id },
				body: {
					...formData,
					driverId: driver.id,
					startTime: timeToObject(formData.startTime),
					endTime: timeToObject(formData.endTime),
				},
			});
		}
	};

	const handleDelete = (schedule: DriverSchedule) => {
		setScheduleToDelete(schedule);
		setDeleteDialogOpen(true);
	};

	const confirmDelete = () => {
		if (!driver) {
			toast.error("Driver profile not found");
			return;
		}

		if (scheduleToDelete) {
			deleteMutation.mutate({
				params: { id: scheduleToDelete.id, driverId: driver?.id },
			});
		}
	};

	const schedules = schedulesResult || [];
	const isLoading = driverLoading || schedulesLoading;

	return (
		<>
			<div className="flex items-center justify-between">
				<div>
					<h2 className="font-medium text-xl">{m.schedule()}</h2>
					<p className="text-muted-foreground">
						Manage your class schedules to auto-offline during class time
					</p>
				</div>
				<Button onClick={() => handleOpenDialog()} disabled={isLoading}>
					<Plus className="mr-2 h-4 w-4" />
					Add Schedule
				</Button>
			</div>

			<Card>
				<CardHeader>
					<CardTitle>Your Schedules</CardTitle>
					<CardDescription>
						{schedules.length} schedule{schedules.length !== 1 ? "s" : ""}{" "}
						configured
					</CardDescription>
				</CardHeader>
				<CardContent>
					{isLoading ? (
						<div className="space-y-3">
							<Skeleton className="h-20 w-full" />
							<Skeleton className="h-20 w-full" />
							<Skeleton className="h-20 w-full" />
						</div>
					) : schedules.length === 0 ? (
						<div className="flex flex-col items-center justify-center py-12 text-center">
							<Calendar className="mb-4 h-12 w-12 text-muted-foreground" />
							<p className="mb-2 font-medium text-lg">No schedules yet</p>
							<p className="mb-4 text-muted-foreground text-sm">
								Add your class schedules to automatically go offline during
								class time
							</p>
							<Button onClick={() => handleOpenDialog()}>
								<Plus className="mr-2 h-4 w-4" />
								Add Your First Schedule
							</Button>
						</div>
					) : (
						<div className="space-y-3">
							{schedules.map((schedule) => (
								<Card key={schedule.id}>
									<CardContent className="flex items-center justify-between p-4">
										<div className="flex items-center gap-4">
											<div
												className={`flex h-10 w-10 items-center justify-center rounded-full ${
													schedule.isRecurring
														? "bg-blue-100 dark:bg-blue-900"
														: "bg-purple-100 dark:bg-purple-900"
												}`}
											>
												{schedule.isRecurring ? (
													<Repeat className="h-5 w-5 text-blue-600 dark:text-blue-400" />
												) : (
													<CalendarDays className="h-5 w-5 text-purple-600 dark:text-purple-400" />
												)}
											</div>
											<div className="flex-1">
												<div className="flex items-center gap-2">
													<p className="font-medium">{schedule.name}</p>
													<Badge
														variant={
															schedule.isActive ? "default" : "secondary"
														}
													>
														{schedule.isActive ? "Active" : "Inactive"}
													</Badge>
													<Badge variant="outline">
														{
															DAYS_OF_WEEK.find(
																(d) => d.value === schedule.dayOfWeek,
															)?.label
														}
													</Badge>
												</div>
												<div className="flex items-center gap-2 text-muted-foreground text-sm">
													<Clock className="h-3 w-3" />
													<span>
														{timeFromObject(schedule.startTime)} -{" "}
														{timeFromObject(schedule.endTime)}
													</span>
													{!schedule.isRecurring && schedule.specificDate && (
														<span className="ml-2">
															•{" "}
															{new Date(
																schedule.specificDate,
															).toLocaleDateString()}
														</span>
													)}
												</div>
											</div>
										</div>
										<div className="flex gap-2">
											<Button
												variant="outline"
												size="sm"
												onClick={() => handleOpenDialog(schedule)}
											>
												Edit
											</Button>
											<Button
												variant="outline"
												size="sm"
												onClick={() => handleDelete(schedule)}
											>
												<Trash2 className="h-4 w-4" />
											</Button>
										</div>
									</CardContent>
								</Card>
							))}
						</div>
					)}
				</CardContent>
			</Card>

			{/* Add/Edit Dialog */}
			<Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
				<DialogContent className="max-w-md">
					<DialogHeader>
						<DialogTitle>
							{editingSchedule ? "Edit Schedule" : "Add Schedule"}
						</DialogTitle>
						<DialogDescription>
							{editingSchedule
								? "Update your class schedule details"
								: "Add a new class schedule to manage your availability"}
						</DialogDescription>
					</DialogHeader>

					<div className="space-y-4">
						{/* Schedule Type Tabs */}
						<Tabs
							value={formData.isRecurring ? "recurring" : "onetime"}
							onValueChange={(value) =>
								setFormData({ ...formData, isRecurring: value === "recurring" })
							}
						>
							<TabsList className="grid w-full grid-cols-2">
								<TabsTrigger value="recurring">Recurring</TabsTrigger>
								<TabsTrigger value="onetime">One-time</TabsTrigger>
							</TabsList>

							<TabsContent value="recurring" className="space-y-4">
								<div>
									<Label htmlFor="day">Day of Week</Label>
									<Select
										value={formData.dayOfWeek}
										onValueChange={(value) =>
											setFormData({
												...formData,
												dayOfWeek: value as DayOfWeek,
											})
										}
									>
										<SelectTrigger id="day">
											<SelectValue />
										</SelectTrigger>
										<SelectContent>
											{DAYS_OF_WEEK.map((day) => (
												<SelectItem key={day.value} value={day.value}>
													{day.label}
												</SelectItem>
											))}
										</SelectContent>
									</Select>
								</div>
							</TabsContent>

							<TabsContent value="onetime" className="space-y-4">
								<div>
									<Label htmlFor="specificDate">Date</Label>
									<Input
										id="specificDate"
										type="date"
										value={formData.specificDate}
										onChange={(e) =>
											setFormData({ ...formData, specificDate: e.target.value })
										}
										required={!formData.isRecurring}
									/>
								</div>
								<div>
									<Label htmlFor="day-onetime">Day of Week</Label>
									<Select
										value={formData.dayOfWeek}
										onValueChange={(value) =>
											setFormData({
												...formData,
												dayOfWeek: value as DayOfWeek,
											})
										}
									>
										<SelectTrigger id="day-onetime">
											<SelectValue />
										</SelectTrigger>
										<SelectContent>
											{DAYS_OF_WEEK.map((day) => (
												<SelectItem key={day.value} value={day.value}>
													{day.label}
												</SelectItem>
											))}
										</SelectContent>
									</Select>
								</div>
							</TabsContent>
						</Tabs>

						{/* Time Inputs */}
						<div className="grid grid-cols-2 gap-4">
							<div>
								<Label htmlFor="startTime">Start Time</Label>
								<Input
									id="startTime"
									type="time"
									value={formData.startTime}
									onChange={(e) =>
										setFormData({ ...formData, startTime: e.target.value })
									}
									required
								/>
							</div>
							<div>
								<Label htmlFor="endTime">End Time</Label>
								<Input
									id="endTime"
									type="time"
									value={formData.endTime}
									onChange={(e) =>
										setFormData({ ...formData, endTime: e.target.value })
									}
									required
								/>
							</div>
						</div>

						{/* Optional Name */}
						<div>
							<Label htmlFor="name">Schedule Name (optional)</Label>
							<Input
								id="name"
								type="text"
								placeholder={generateScheduleName(
									formData.isRecurring,
									formData.dayOfWeek,
									formData.startTime,
									formData.endTime,
									formData.specificDate,
								)}
								value={formData.name}
								onChange={(e) =>
									setFormData({ ...formData, name: e.target.value })
								}
							/>
							<p className="mt-1 text-muted-foreground text-xs">
								Leave empty to auto-generate
							</p>
						</div>

						{/* Active Toggle */}
						<div className="flex items-center justify-between">
							<div>
								<Label htmlFor="active">Active</Label>
								<p className="text-muted-foreground text-xs">
									Enable auto-offline during this schedule
								</p>
							</div>
							<Switch
								id="active"
								checked={formData.isActive}
								onCheckedChange={(checked) =>
									setFormData({ ...formData, isActive: checked })
								}
							/>
						</div>
					</div>

					<DialogFooter>
						<Button
							variant="outline"
							onClick={() => {
								setDialogOpen(false);
								setEditingSchedule(null);
								resetForm();
							}}
						>
							Cancel
						</Button>
						<Button
							onClick={handleSubmit}
							disabled={createMutation.isPending || updateMutation.isPending}
						>
							{editingSchedule ? "Update" : "Create"} Schedule
						</Button>
					</DialogFooter>
				</DialogContent>
			</Dialog>

			{/* Delete Confirmation Dialog */}
			<AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
				<AlertDialogContent>
					<AlertDialogHeader>
						<AlertDialogTitle>Delete Schedule?</AlertDialogTitle>
						<AlertDialogDescription>
							Are you sure you want to delete "{scheduleToDelete?.name}"? This
							action cannot be undone.
						</AlertDialogDescription>
					</AlertDialogHeader>
					<AlertDialogFooter>
						<AlertDialogCancel>Cancel</AlertDialogCancel>
						<AlertDialogAction
							onClick={confirmDelete}
							disabled={deleteMutation.isPending}
						>
							Delete
						</AlertDialogAction>
					</AlertDialogFooter>
				</AlertDialogContent>
			</AlertDialog>
		</>
	);
}
