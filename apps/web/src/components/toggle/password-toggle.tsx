import { m } from "@repo/i18n";
import { EyeIcon, EyeOffIcon } from "lucide-react";
import { cn } from "@/utils/cn";
import { Button } from "../ui/button";

type Props = {
	isVisible: boolean;
	setIsVisible: React.Dispatch<React.SetStateAction<boolean>>;
	disabled?: boolean;
	className?: string;
};
export const PasswordToggle = ({
	isVisible,
	setIsVisible,
	disabled,
	className,
}: Props) => {
	return (
		<Button
			variant="ghost"
			type="button"
			size="icon"
			onClick={() => setIsVisible(!isVisible)}
			disabled={disabled}
			className={cn("p-0", className)}
		>
			{isVisible ? (
				<>
					<EyeIcon aria-label={m.hide_password()} />
					<span className="sr-only">{m.hide_password()}</span>
				</>
			) : (
				<>
					<EyeOffIcon aria-label={m.show_password()} />
					<span className="sr-only">{m.show_password()}</span>
				</>
			)}
		</Button>
	);
};
