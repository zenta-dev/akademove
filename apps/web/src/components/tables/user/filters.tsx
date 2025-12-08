import { useState } from "react";
import { DateRangePicker } from "../filters/date-range-picker";
import { FilterActions } from "../filters/filter-actions";
import { MultiSelectFilter } from "../filters/multi-select-filter";
import { SingleSelectFilter } from "../filters/single-select-filter";

interface UserFilters {
	roles?: ("ADMIN" | "OPERATOR" | "MERCHANT" | "DRIVER" | "USER")[];
	genders?: ("MALE" | "FEMALE")[];
	emailVerified?: boolean;
	banned?: boolean;
	startDate?: Date;
	endDate?: Date;
}

interface UserFiltersProps {
	filters: UserFilters;
	onFiltersChange: (filters: UserFilters) => void;
	onApplyFilters: () => void;
	onClearFilters: () => void;
	isApplying?: boolean;
}

const ROLE_OPTIONS = [
	{ value: "ADMIN", label: "Admin" },
	{ value: "OPERATOR", label: "Operator" },
	{ value: "MERCHANT", label: "Merchant" },
	{ value: "DRIVER", label: "Driver" },
	{ value: "USER", label: "User" },
];

const GENDER_OPTIONS = [
	{ value: "MALE", label: "Male" },
	{ value: "FEMALE", label: "Female" },
];

const EMAIL_VERIFIED_OPTIONS = [
	{ value: "true", label: "Verified" },
	{ value: "false", label: "Not Verified" },
];

const BANNED_OPTIONS = [
	{ value: "true", label: "Banned" },
	{ value: "false", label: "Not Banned" },
];

export const UserFiltersComponent = ({
	filters,
	onFiltersChange,
	onApplyFilters,
	onClearFilters,
	isApplying = false,
}: UserFiltersProps) => {
	const [localFilters, setLocalFilters] = useState<UserFilters>(filters);

	const handleRolesChange = (roles: string[]) => {
		setLocalFilters((prev) => ({
			...prev,
			roles:
				roles.length > 0
					? (roles as ("ADMIN" | "OPERATOR" | "MERCHANT" | "DRIVER" | "USER")[])
					: undefined,
		}));
	};

	const handleGendersChange = (genders: string[]) => {
		setLocalFilters((prev) => ({
			...prev,
			genders:
				genders.length > 0 ? (genders as ("MALE" | "FEMALE")[]) : undefined,
		}));
	};

	const handleEmailVerifiedChange = (value: string | undefined) => {
		setLocalFilters((prev) => ({
			...prev,
			emailVerified: value ? value === "true" : undefined,
		}));
	};

	const handleBannedChange = (value: string | undefined) => {
		setLocalFilters((prev) => ({
			...prev,
			banned: value ? value === "true" : undefined,
		}));
	};

	const handleDateRangeChange = (
		dateRange: { from?: Date; to?: Date } | undefined,
	) => {
		setLocalFilters((prev) => ({
			...prev,
			startDate: dateRange?.from,
			endDate: dateRange?.to,
		}));
	};

	const handleApplyFilters = () => {
		onFiltersChange(localFilters);
		onApplyFilters();
	};

	const handleClearFilters = () => {
		const clearedFilters: UserFilters = {};
		setLocalFilters(clearedFilters);
		onFiltersChange(clearedFilters);
		onClearFilters();
	};

	const hasActiveFilters = !!(
		filters.roles?.length ||
		filters.genders?.length ||
		filters.emailVerified !== undefined ||
		filters.banned !== undefined ||
		filters.startDate ||
		filters.endDate
	);

	return (
		<div className="flex flex-wrap items-center gap-4 rounded-lg bg-muted/50 px-4 py-2">
			<MultiSelectFilter
				options={ROLE_OPTIONS}
				selectedValues={localFilters.roles ?? []}
				onSelectionChange={handleRolesChange}
				placeholder="Roles"
				variant="compact"
			/>

			<MultiSelectFilter
				options={GENDER_OPTIONS}
				selectedValues={localFilters.genders ?? []}
				onSelectionChange={handleGendersChange}
				placeholder="Genders"
				variant="compact"
			/>

			<SingleSelectFilter
				options={EMAIL_VERIFIED_OPTIONS}
				value={localFilters.emailVerified?.toString()}
				onValueChange={handleEmailVerifiedChange}
				placeholder="Email Status"
			/>

			<SingleSelectFilter
				options={BANNED_OPTIONS}
				value={localFilters.banned?.toString()}
				onValueChange={handleBannedChange}
				placeholder="Ban Status"
			/>

			<DateRangePicker
				value={{
					from: localFilters.startDate,
					to: localFilters.endDate,
				}}
				onChange={handleDateRangeChange}
				placeholder="Join Date Range"
			/>

			<FilterActions
				onApplyFilters={handleApplyFilters}
				onClearFilters={handleClearFilters}
				hasActiveFilters={hasActiveFilters}
				isApplying={isApplying}
			/>
		</div>
	);
};
