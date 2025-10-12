import { Image as UnpicImage } from "@unpic/react";
import { useRef, useState } from "react";
import Zoom from "react-medium-image-zoom";
import { cn } from "@/utils/cn";

export type ImageZoomProps = {
	className?: string;
	backdropClassName?: string;
	key?: string;
	src: string;
	width: number;
	height: number;
	background: string;
	layout?: "constrained" | "fixed";
	alt: string;
};

export const ImageZoom = ({
	className,
	backdropClassName,
	key,
	src,
	width,
	height,
	background = "auto",
	layout = "constrained",
	alt,
	...props
}: ImageZoomProps) => {
	const [isZoomed, setIsZoomed] = useState(false);
	const [isPreloaded, setIsPreloaded] = useState(false);
	const containerRef = useRef<HTMLDivElement>(null);

	const handleZoomChange = (shouldZoom: boolean) => {
		setIsZoomed(shouldZoom);
	};

	const handleMouseEnter = () => {
		if (!isPreloaded) {
			const img = new Image();
			const url = new URL(src);
			url.searchParams.set("width", "1080");
			url.searchParams.set("height", "1080");
			img.src = url.toString();
			img.width = 1080;
			img.height = 1080;
			setIsPreloaded(true);
		}
	};

	return (
		// biome-ignore lint/a11y/noStaticElementInteractions: i dunno how to resolve for now
		<div
			ref={containerRef}
			onMouseEnter={handleMouseEnter}
			className={cn(
				"relative",
				"[&_[data-rmiz-ghost]]:pointer-events-none [&_[data-rmiz-ghost]]:absolute",
				"[&_[data-rmiz-btn-zoom]]:m-0 [&_[data-rmiz-btn-zoom]]:size-10 [&_[data-rmiz-btn-zoom]]:touch-manipulation [&_[data-rmiz-btn-zoom]]:appearance-none [&_[data-rmiz-btn-zoom]]:rounded-[50%] [&_[data-rmiz-btn-zoom]]:border-none [&_[data-rmiz-btn-zoom]]:bg-foreground/70 [&_[data-rmiz-btn-zoom]]:p-2 [&_[data-rmiz-btn-zoom]]:text-background [&_[data-rmiz-btn-zoom]]:outline-offset-2",
				"[&_[data-rmiz-btn-unzoom]]:m-0 [&_[data-rmiz-btn-unzoom]]:size-10 [&_[data-rmiz-btn-unzoom]]:touch-manipulation [&_[data-rmiz-btn-unzoom]]:appearance-none [&_[data-rmiz-btn-unzoom]]:rounded-[50%] [&_[data-rmiz-btn-unzoom]]:border-none [&_[data-rmiz-btn-unzoom]]:bg-foreground/70 [&_[data-rmiz-btn-unzoom]]:p-2 [&_[data-rmiz-btn-unzoom]]:text-background [&_[data-rmiz-btn-unzoom]]:outline-offset-2",
				"[&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:pointer-events-none [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:absolute [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:size-px [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:overflow-hidden [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:whitespace-nowrap [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:[clip-path:inset(50%)] [&_[data-rmiz-btn-zoom]:not(:focus):not(:active)]:[clip:rect(0_0_0_0)]",
				"[&_[data-rmiz-btn-zoom]]:absolute [&_[data-rmiz-btn-zoom]]:top-2.5 [&_[data-rmiz-btn-zoom]]:right-2.5 [&_[data-rmiz-btn-zoom]]:bottom-auto [&_[data-rmiz-btn-zoom]]:left-auto [&_[data-rmiz-btn-zoom]]:cursor-zoom-in",
				"[&_[data-rmiz-btn-unzoom]]:absolute [&_[data-rmiz-btn-unzoom]]:top-5 [&_[data-rmiz-btn-unzoom]]:right-5 [&_[data-rmiz-btn-unzoom]]:bottom-auto [&_[data-rmiz-btn-unzoom]]:left-auto [&_[data-rmiz-btn-unzoom]]:z-[1] [&_[data-rmiz-btn-unzoom]]:cursor-zoom-out",
				'[&_[data-rmiz-content="found"]_img]:cursor-zoom-in',
				'[&_[data-rmiz-content="found"]_svg]:cursor-zoom-in',
				'[&_[data-rmiz-content="found"]_[role="img"]]:cursor-zoom-in',
				'[&_[data-rmiz-content="found"]_[data-zoom]]:cursor-zoom-in',
				className,
			)}
		>
			<Zoom
				classDialog={cn(
					"[&::backdrop]:hidden",
					"[&[open]]:fixed [&[open]]:m-0 [&[open]]:h-dvh [&[open]]:max-h-none [&[open]]:w-dvw [&[open]]:max-w-none [&[open]]:overflow-hidden [&[open]]:border-0 [&[open]]:bg-transparent [&[open]]:p-0",
					"[&_[data-rmiz-modal-overlay]]:absolute [&_[data-rmiz-modal-overlay]]:inset-0 [&_[data-rmiz-modal-overlay]]:transition-all",
					'[&_[data-rmiz-modal-overlay="hidden"]]:bg-transparent',
					'[&_[data-rmiz-modal-overlay="visible"]]:bg-background/80 [&_[data-rmiz-modal-overlay="visible"]]:backdrop-blur-md',
					"[&_[data-rmiz-modal-content]]:relative [&_[data-rmiz-modal-content]]:size-full",
					"[&_[data-rmiz-modal-img]]:absolute [&_[data-rmiz-modal-img]]:origin-top-left [&_[data-rmiz-modal-img]]:cursor-zoom-out [&_[data-rmiz-modal-img]]:transition-transform",
					"motion-reduce:[&_[data-rmiz-modal-img]]:transition-none motion-reduce:[&_[data-rmiz-modal-overlay]]:transition-none",
					backdropClassName,
				)}
				onZoomChange={handleZoomChange}
				{...props}
			>
				<UnpicImage
					key={key}
					src={src}
					layout={layout}
					width={isZoomed ? 1080 : width}
					height={isZoomed ? 1080 : height}
					background={background}
					alt={alt}
				/>
			</Zoom>
		</div>
	);
};
