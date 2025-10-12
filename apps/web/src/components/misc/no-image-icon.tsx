import { cva, type VariantProps } from "class-variance-authority";
import type React from "react";
import { useId } from "react";

const noImageIconVariants = cva("transition-colors", {
	variants: {
		size: {
			xs: "h-12 w-12",
			sm: "h-16 w-16",
			md: "h-24 w-24",
			lg: "h-32 w-32",
			xl: "h-48 w-48",
			"2xl": "h-64 w-64",
		},
	},
	defaultVariants: {
		size: "md",
	},
});

interface NoImageIconProps extends VariantProps<typeof noImageIconVariants> {
	className?: string;
}

export const NoImageIcon: React.FC<NoImageIconProps> = ({
	size,
	className,
}) => {
	const id = useId();

	const strokeWidthMap: Record<NonNullable<typeof size>, string> = {
		xs: "12",
		sm: "14",
		md: "16",
		lg: "18",
		xl: "20",
		"2xl": "22",
	};

	const strokeWidth = strokeWidthMap[size ?? "md"];
	return (
		<svg
			xmlns="http://www.w3.org/2000/svg"
			viewBox="0 0 512 512"
			fill="none"
			className={noImageIconVariants({ size, className })}
			aria-label="No image available"
			role="img"
		>
			<g clipPath={`url(#${id})`}>
				<path
					d="M449.5 241.5L362.666 159.424C350.055 147.504 330.241 147.808 318.001 160.109L141 338"
					stroke="currentColor"
					strokeWidth={strokeWidth}
					strokeLinecap="round"
				/>
				<path
					d="M234.5 240.5L183.117 192.018C177.103 186.343 167.754 186.186 161.553 191.656L66.5 275.5"
					stroke="currentColor"
					strokeWidth={strokeWidth}
					strokeLinecap="round"
				/>
				<circle
					cx="225"
					cy="138"
					r="14"
					stroke="currentColor"
					strokeWidth="10"
				/>
			</g>
			<rect
				x="64"
				y="57"
				width="384"
				height="284"
				rx="24"
				stroke="currentColor"
				strokeWidth={strokeWidth}
			/>
			<text
				x="256"
				y="430"
				textAnchor="middle"
				fontSize="48"
				fontWeight="bold"
				fill="currentColor"
			>
				NO IMAGE
			</text>
			<defs>
				<clipPath id={id}>
					<rect x="56" y="49" width="400" height="300" rx="32" fill="white" />
				</clipPath>
			</defs>
		</svg>
	);
};
