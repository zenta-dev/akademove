import { createFileRoute } from "@tanstack/react-router";

// File: CouponForm.tsx
// Place in your React + TypeScript project. Adjust shadcn import paths if needed.

import { zodResolver } from "@hookform/resolvers/zod";
import React from "react";
import { useFieldArray, useForm } from "react-hook-form";
import * as z from "zod";

// --- shadcn/ui components (adjust paths to your project) ---
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Separator } from "@/components/ui/separator";
import { Switch } from "@/components/ui/switch";
import { Textarea } from "@/components/ui/textarea";

export const Route = createFileRoute("/{-$lang}/ref/")({
	component: RouteComponent,
});

function RouteComponent() {
	return <CouponForm/>
}

// ---------------- Zod schemas (normalized) ----------------
const RideTypeEnum = z.enum(["economy", "premium", "bike"]);
const DayEnum = z.enum(["mon", "tue", "wed", "thu", "fri", "sat", "sun"]);

// General rules schema
const GeneralRulesSchema = z.object({
	type: z.enum(["percentage", "fixed"]).default("percentage"),
	minOrderAmount: z.number().nonnegative().optional(),
	maxDiscountAmount: z.number().nonnegative().optional(),
});

// Ride rules schema
const RideRulesSchema = z.object({
	minDistanceKm: z.number().nonnegative().optional(),
	maxDistanceKm: z.number().nonnegative().optional(),
	allowedRideTypes: z.array(RideTypeEnum).optional(),
	allowedPickupZones: z.array(z.string()).optional(), // zone IDs or names
	allowedDropoffZones: z.array(z.string()).optional(),
});

// User rules schema
const UserRulesSchema = z.object({
	newUserOnly: z.boolean().optional(),
	allowedUserGroups: z.array(z.string()).optional(),
});

// Time rules schema
const TimeRulesSchema = z.object({
	allowedDays: z.array(DayEnum).optional(),
	// store hours as integers 0..23
	allowedHours: z.array(z.number().int().min(0).max(23)).optional(),
});

// Top-level rules schema
const CouponRulesSchema = z.object({
	general: GeneralRulesSchema.optional(),
	ride: RideRulesSchema.optional(),
	user: UserRulesSchema.optional(),
	time: TimeRulesSchema.optional(),
});

// Coupon schema
export const CouponSchema = z.object({
	id: z.string().uuid().optional(), // optional when creating new
	name: z.string().min(1, "Name required"),
	code: z.string().min(1, "Code required"),
	rules: CouponRulesSchema,
	discountAmount: z.number().nonnegative().optional(), // used when fixed
	discountPercentage: z.number().min(0).max(100).optional(), // used when percentage
	minOrderAmount: z.number().nonnegative().optional(),
	maxOrderAmount: z.number().nonnegative().optional(),
	usageLimit: z.number().int().min(0).optional(),
	usedCount: z.number().int().min(0).optional(),
	periodStart: z.string().optional(), // will be ISO string via input
	periodEnd: z.string().optional(),
	isActive: z.boolean().default(true),
	createdById: z.string().optional(),
	createdAt: z.string().optional(),
});

// Type inference for react-hook-form
type CouponFormValues = z.infer<typeof CouponSchema>;

// --- Component ---
export default function CouponForm({
	initialValues,
	onSubmit,
}: {
	initialValues?: Partial<CouponFormValues>;
	onSubmit?: (values: CouponFormValues) => Promise<void> | void;
}) {
	// default values for the form — normalized structure
	const defaults: CouponFormValues = {
		name: "",
		code: "",
		rules: {
			general: { type: "percentage" },
			ride: {},
			user: {},
			time: {},
		},
		discountAmount: 0,
		discountPercentage: 10,
		minOrderAmount: 0,
		maxOrderAmount: undefined,
		usageLimit: 0,
		usedCount: 0,
		periodStart: new Date().toISOString().slice(0, 16), // yyyy-mm-ddThh:mm for datetime-local
		periodEnd: new Date(Date.now() + 1000 * 60 * 60 * 24 * 30)
			.toISOString()
			.slice(0, 16),
		isActive: true,
		...initialValues,
	}

	const {
		register,
		control,
		handleSubmit,
		watch,
		setValue,
		formState: { errors, isSubmitting },
	} = useForm<CouponFormValues>({
		resolver: zodResolver(CouponSchema),
		defaultValues: defaults,
		mode: "onBlur",
	})

	// Field arrays for dynamic pickup/dropoff zones under rules.ride.allowedPickupZones
	// We'll present pickup zones as an editable list
	const rideAllowedPickupZones = useFieldArray({
		control,
		name: "rules.ride.allowedPickupZones" as const,
	})

	const rideAllowedDropoffZones = useFieldArray({
		control,
		name: "rules.ride.allowedDropoffZones" as const,
	})

	// allowedUserGroups dynamic list
	const userGroups = useFieldArray({
		control,
		name: "rules.user.allowedUserGroups" as const,
	})

	// convenience watchers
	const ruleType = watch("rules.general?.type") ?? "percentage";

	// Internal submit wrapper: convert local datetime-local values to ISO strings if needed
	async function internalSubmit(data: CouponFormValues) {
		// normalize periodStart/periodEnd to ISO strings with seconds
		if (data.periodStart) {
			const d = new Date(data.periodStart);
			data.periodStart = d.toISOString();
		}
		if (data.periodEnd) {
			const d = new Date(data.periodEnd);
			data.periodEnd = d.toISOString();
		}

		// ensure arrays exist when empty (avoid undefineds)
		data.rules = {
			general: data.rules?.general ?? undefined,
			ride: {
				...(data.rules?.ride ?? {}),
				allowedPickupZones: data.rules?.ride?.allowedPickupZones ?? undefined,
				allowedDropoffZones: data.rules?.ride?.allowedDropoffZones ?? undefined,
			},
			user: {
				...(data.rules?.user ?? {}),
				allowedUserGroups: data.rules?.user?.allowedUserGroups ?? undefined,
			},
			time: data.rules?.time ?? undefined,
		}

		if (onSubmit) {
			await onSubmit(data);
			return
		}
		// default action: show JSON in console
		// eslint-disable-next-line no-console
		console.log("Coupon payload:", JSON.stringify(data, null, 2));
		alert("Coupon payload printed to console (see devtools).");
	}

	return (
		<Card>
			<CardHeader>
				<CardTitle>Create / Edit Coupon</CardTitle>
			</CardHeader>
			<CardContent>
				<form onSubmit={handleSubmit(internalSubmit)} className="space-y-6">
					{/* Basic info */}
					<div className="grid gap-2 md:grid-cols-2">
						<div>
							<Label htmlFor="name">Name</Label>
							<Input id="name" {...register("name")} />
							{errors.name && (
								<p className="text-red-600 text-sm">{errors.name.message}</p>
							)}
						</div>

						<div>
							<Label htmlFor="code">Code</Label>
							<Input id="code" {...register("code")} />
							{errors.code && (
								<p className="text-red-600 text-sm">{errors.code.message}</p>
							)}
						</div>

						<div>
							<Label htmlFor="isActive">Active</Label>
							<div className="flex items-center gap-2">
								<Switch
									id="isActive"
									checked={watch("isActive")}
									onCheckedChange={(v) => setValue("isActive", Boolean(v))}
								/>
								<span className="text-muted-foreground text-sm">
									{watch("isActive") ? "Active" : "Inactive"}
								</span>
							</div>
						</div>

						<div>
							<Label htmlFor="usageLimit">Usage Limit</Label>
							<Input
								id="usageLimit"
								type="number"
								{...register("usageLimit", { valueAsNumber: true })}
							/>
							{errors.usageLimit && (
								<p className="text-red-600 text-sm">
									{errors.usageLimit.message}
								</p>
							)}
						</div>
					</div>

					<Separator />

					{/* Discount section (general rules) */}
					<div className="space-y-2">
						<h3 className="font-medium text-lg">Discount</h3>
						<div className="grid gap-2 md:grid-cols-3">
							<div>
								<Label>Type</Label>
								<Select
									onValueChange={(val) =>
										setValue(
											"rules.general.type",
											val as "percentage" | "fixed",
										)
									}
									value={ruleType}
								>
									<SelectTrigger className="w-full">
										<SelectValue placeholder="Select type" />
									</SelectTrigger>
									<SelectContent>
										<SelectItem value="percentage">Percentage</SelectItem>
										<SelectItem value="fixed">Fixed amount</SelectItem>
									</SelectContent>
								</Select>
							</div>

							<div>
								<Label>Discount Percentage</Label>
								<Input
									type="number"
									{...register("discountPercentage", { valueAsNumber: true })}
								/>
								{errors.discountPercentage && (
									<p className="text-red-600 text-sm">
										{errors.discountPercentage.message}
									</p>
								)}
							</div>

							<div>
								<Label>Discount Amount (fixed)</Label>
								<Input
									type="number"
									{...register("discountAmount", { valueAsNumber: true })}
								/>
							</div>
						</div>

						<div className="grid gap-2 md:grid-cols-2">
							<div>
								<Label>Min order amount</Label>
								<Input
									type="number"
									{...register("rules.general.minOrderAmount", {
										valueAsNumber: true,
									})}
								/>
							</div>
							<div>
								<Label>Max discount amount</Label>
								<Input
									type="number"
									{...register("rules.general.maxDiscountAmount", {
										valueAsNumber: true,
									})}
								/>
							</div>
						</div>
					</div>

					<Separator />

					{/* Ride rules */}
					<div className="space-y-2">
						<h3 className="font-medium text-lg">Ride Rules</h3>

						<div className="grid gap-2 md:grid-cols-3">
							<div>
								<Label>Min distance (km)</Label>
								<Input
									type="number"
									{...register("rules.ride.minDistanceKm", {
										valueAsNumber: true,
									})}
								/>
							</div>
							<div>
								<Label>Max distance (km)</Label>
								<Input
									type="number"
									{...register("rules.ride.maxDistanceKm", {
										valueAsNumber: true,
									})}
								/>
							</div>

							<div>
								<Label>Allowed ride types</Label>
								<div className="mt-2 flex items-center gap-4">
									{["economy", "premium", "bike"].map((rt) => (
										<label
											key={rt}
											className="inline-flex items-center space-x-2"
										>
											<Checkbox
												checked={(
													watch("rules.ride.allowedRideTypes") ?? []
												).includes(rt as any)}
												onCheckedChange={(checked) => {
													const current = new Set(
														watch("rules.ride.allowedRideTypes") ?? [],
													)
													if (checked) current.add(rt)
													else current.delete(rt)
													setValue(
														"rules.ride.allowedRideTypes",
														Array.from(current) as any,
													)
												}}
											/>
											<span className="capitalize">{rt}</span>
										</label>
									))}
								</div>
							</div>
						</div>

						{/* dynamic pickup zones */}
						<div>
							<Label>Allowed pickup zones</Label>
							<div className="mt-2 space-y-2">
								{rideAllowedPickupZones.fields.length === 0 && (
									<p className="text-muted-foreground text-sm">
										No pickup zones — leave empty for all zones
									</p>
								)}
								{rideAllowedPickupZones.fields.map((field, idx) => (
									<div key={field.id} className="flex gap-2">
										<Input
											{...register(
												`rules.ride.allowedPickupZones.${idx}` as const,
											)}
										/>
										<Button
											type="button"
											variant="destructive"
											onClick={() => rideAllowedPickupZones.remove(idx)}
										>
											Remove
										</Button>
									</div>
								))}
								<Button
									type="button"
									onClick={() => rideAllowedPickupZones.append("")}
								>
									Add pickup zone
								</Button>
							</div>
						</div>

						{/* dynamic dropoff zones */}
						<div>
							<Label>Allowed dropoff zones</Label>
							<div className="mt-2 space-y-2">
								{rideAllowedDropoffZones.fields.length === 0 && (
									<p className="text-muted-foreground text-sm">
										No dropoff zones — leave empty for all zones
									</p>
								)}
								{rideAllowedDropoffZones.fields.map((field, idx) => (
									<div key={field.id} className="flex gap-2">
										<Input
											{...register(
												`rules.ride.allowedDropoffZones.${idx}` as const,
											)}
										/>
										<Button
											type="button"
											variant="destructive"
											onClick={() => rideAllowedDropoffZones.remove(idx)}
										>
											Remove
										</Button>
									</div>
								))}
								<Button
									type="button"
									onClick={() => rideAllowedDropoffZones.append("")}
								>
									Add dropoff zone
								</Button>
							</div>
						</div>
					</div>

					<Separator />

					{/* User rules */}
					<div className="space-y-2">
						<h3 className="font-medium text-lg">User Rules</h3>
						<div className="flex items-center gap-2">
							<Checkbox
								id="newUserOnly"
								checked={!!watch("rules.user.newUserOnly")}
								onCheckedChange={(v) =>
									setValue("rules.user.newUserOnly", Boolean(v))
								}
							/>
							<Label htmlFor="newUserOnly">New user only</Label>
						</div>

						<div>
							<Label>Allowed user groups</Label>
							<div className="mt-2 space-y-2">
								{userGroups.fields.length === 0 && (
									<p className="text-muted-foreground text-sm">
										No groups — leave empty for all users
									</p>
								)}
								{userGroups.fields.map((field, idx) => (
									<div key={field.id} className="flex gap-2">
										<Input
											{...register(
												`rules.user.allowedUserGroups.${idx}` as const,
											)}
										/>
										<Button
											type="button"
											variant="destructive"
											onClick={() => userGroups.remove(idx)}
										>
											Remove
										</Button>
									</div>
								))}
								<Button type="button" onClick={() => userGroups.append("")}>
									Add user group
								</Button>
							</div>
						</div>
					</div>

					<Separator />

					{/* Time rules */}
					<div className="space-y-2">
						<h3 className="font-medium text-lg">Time Rules</h3>
						<div>
							<Label>Allowed days</Label>
							<div className="mt-2 flex flex-wrap gap-3">
								{["mon", "tue", "wed", "thu", "fri", "sat", "sun"].map((d) => {
									const current = watch("rules.time.allowedDays") ?? [];
									const checked = current.includes(d as any);
									return (
										<label
											key={d}
											className="inline-flex items-center space-x-2"
										>
											<Checkbox
												checked={checked}
												onCheckedChange={(v) => {
													const set = new Set(current)
													if (v) set.add(d)
													else set.delete(d)
													setValue(
														"rules.time.allowedDays",
														Array.from(set) as any,
													)
												}}
											/>
											<span className="capitalize">{d}</span>
										</label>
									)
								})}
							</div>
						</div>

						<div>
							<Label>Allowed hours (0–23)</Label>
							<div className="mt-2 flex flex-wrap gap-2">
								{(watch("rules.time.allowedHours") ?? []).map((h, idx) => (
									<div key={idx} className="flex items-center gap-2">
										<Input
											type="number"
											min={0}
											max={23}
											{...register(`rules.time.allowedHours.${idx}` as const, {
												valueAsNumber: true,
											})}
											style={{ width: 80 }}
										/>
										<Button
											type="button"
											variant="destructive"
											onClick={() => {
												const arr = [
													...(watch("rules.time.allowedHours") ?? []),
												]
												arr.splice(idx, 1)
												setValue("rules.time.allowedHours", arr as any);
											}}
										>
											Remove
										</Button>
									</div>
								))}
								<Button
									type="button"
									onClick={() => {
										const arr = [...(watch("rules.time.allowedHours") ?? [])];
										arr.push(0)
										setValue("rules.time.allowedHours", arr as any);
									}}
								>
									Add hour
								</Button>
							</div>
						</div>
					</div>

					<Separator />

					{/* Period & misc */}
					<div className="grid gap-2 md:grid-cols-2">
						<div>
							<Label>Start (local)</Label>
							<Input type="datetime-local" {...register("periodStart")} />
						</div>
						<div>
							<Label>End (local)</Label>
							<Input type="datetime-local" {...register("periodEnd")} />
						</div>
					</div>

					<div className="flex justify-end gap-2">
						<Button type="submit" disabled={isSubmitting}>
							{isSubmitting ? "Saving..." : "Save coupon"}
						</Button>
						<Button
							type="button"
							variant="outline"
							onClick={() => {
								// reset to defaults
								window.location.reload(); // quick-and-dirty reset (replace with reset() if you import it)
							}}
						>
							Reset
						</Button>
					</div>
				</form>
			</CardContent>
		</Card>
	)
}
