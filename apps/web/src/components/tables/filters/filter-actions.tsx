import { FilterX } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/utils/cn";

interface FilterActionsProps {
	onApplyFilters: () => void;
	onClearFilters: () => void;
	hasActiveFilters: boolean;
	isApplying?: boolean;
	className?: string;
}

export const FilterActions = ({
	onApplyFilters,
	onClearFilters,
	hasActiveFilters,
	isApplying = false,
	className,
}: FilterActionsProps) => {
	return (
		<div className={cn("flex gap-2", className)}>
			<Button onClick={onApplyFilters} disabled={isApplying}>
				{isApplying ? "Applying..." : "Apply Filters"}
			</Button>
			{hasActiveFilters && (
				<Button variant="outline" onClick={onClearFilters}>
					<FilterX className="mr-2 h-4 w-4" />
					Clear
				</Button>
			)}
		</div>
	);
};
