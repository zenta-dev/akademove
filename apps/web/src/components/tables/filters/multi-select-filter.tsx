import { m } from "@repo/i18n";
import { cva } from "class-variance-authority";
import { Check, PlusCircle } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Command,
	CommandEmpty,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
	CommandSeparator,
} from "@/components/ui/command";
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/utils/cn";

interface FilterOption {
	value: string;
	label: string;
	icon?: React.ComponentType<{ className?: string }>;
}

interface MultiSelectFilterProps {
	options: FilterOption[];
	selectedValues: string[];
	onSelectionChange: (values: string[]) => void;
	placeholder?: string;
	className?: string;
	variant?: "default" | "compact";
}

const filterVariants = cva(
	"flex items-center justify-between rounded-md border px-3 py-2 font-medium text-sm",
	{
		variants: {
			variant: {
				default: "w-[200px]",
				compact: "w-[150px]",
			},
		},
		defaultVariants: {
			variant: "default",
		},
	},
);

export const MultiSelectFilter = ({
	options,
	selectedValues,
	onSelectionChange,
	placeholder = "Select options...",
	className,
	variant = "default",
}: MultiSelectFilterProps) => {
	const handleSelect = (value: string) => {
		if (selectedValues.includes(value)) {
			onSelectionChange(selectedValues.filter((v) => v !== value));
		} else {
			onSelectionChange([...selectedValues, value]);
		}
	};

	const handleClearAll = () => {
		onSelectionChange([]);
	};

	const selectedLabels = selectedValues.map(
		(value) => options.find((option) => option.value === value)?.label || value,
	);

	return (
		<Popover>
			<PopoverTrigger asChild>
				<Button
					variant="outline"
					className={cn(filterVariants({ variant }), className)}
				>
					<PlusCircle className="mr-2 h-4 w-4" />
					{selectedValues.length > 0 ? (
						<div className="flex gap-1">
							{selectedLabels.slice(0, 2).map((label) => (
								<Badge key={label} variant="secondary" className="px-1 py-0">
									{label}
								</Badge>
							))}
							{selectedValues.length > 2 && (
								<Badge variant="secondary" className="px-1 py-0">
									+{selectedValues.length - 2}
								</Badge>
							)}
						</div>
					) : (
						placeholder
					)}
				</Button>
			</PopoverTrigger>
			<PopoverContent className="w-[200px] p-0" align="start">
				<Command>
					<CommandInput placeholder={m.search()} />
					<CommandList>
						<CommandEmpty>No options found.</CommandEmpty>
						<CommandGroup>
							{options.map((option) => {
								const isSelected = selectedValues.includes(option.value);
								return (
									<CommandItem
										key={option.value}
										onSelect={() => handleSelect(option.value)}
									>
										<div
											className={cn(
												"mr-2 flex h-4 w-4 items-center justify-center rounded-sm border border-primary",
												isSelected
													? "bg-primary text-primary-foreground"
													: "opacity-50 [&_svg]:invisible",
											)}
										>
											<Check className="h-3 w-4" />
										</div>
										{option.icon && (
											<option.icon className="mr-2 h-4 w-4 text-muted-foreground" />
										)}
										<span>{option.label}</span>
									</CommandItem>
								);
							})}
						</CommandGroup>
						{selectedValues.length > 0 && (
							<>
								<CommandSeparator />
								<CommandGroup>
									<CommandItem onSelect={handleClearAll}>
										<div className="mr-2 flex h-4 w-4 items-center justify-center rounded-sm border border-destructive">
											<Check className="h-3 w-4" />
										</div>
										<span className="text-destructive">Clear all</span>
									</CommandItem>
								</CommandGroup>
							</>
						)}
					</CommandList>
				</Command>
			</PopoverContent>
		</Popover>
	);
};
