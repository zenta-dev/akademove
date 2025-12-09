import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { cn } from "@/utils/cn";

interface SingleSelectFilterProps {
	options: { value: string; label: string }[];
	value?: string;
	onValueChange?: (value: string | undefined) => void;
	placeholder?: string;
	className?: string;
	allOption?: { value: string; label: string };
}

export const SingleSelectFilter = ({
	options,
	value,
	onValueChange,
	placeholder = "Select option...",
	className,
	allOption = { value: "ALL", label: "All" },
}: SingleSelectFilterProps) => {
	const handleValueChange = (newValue: string) => {
		if (newValue === allOption.value) {
			onValueChange?.(undefined);
		} else {
			onValueChange?.(newValue);
		}
	};

	return (
		<Select value={value ?? allOption.value} onValueChange={handleValueChange}>
			<SelectTrigger className={cn("w-[180px]", className)}>
				<SelectValue placeholder={placeholder} />
			</SelectTrigger>
			<SelectContent>
				<SelectItem value={allOption.value}>{allOption.label}</SelectItem>
				{options.map(
					(option) =>
						option.value && (
							<SelectItem key={option.value} value={option.value}>
								{option.label}
							</SelectItem>
						),
				)}
			</SelectContent>
		</Select>
	);
};
