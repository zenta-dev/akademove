import { Bell, X } from "lucide-react";
import { useCallback, useState } from "react";
import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardTitle,
} from "@/components/ui/card";
import { useNotifications } from "@/hooks/use-notifications";

interface NotificationBannerProps {
	onDismiss?: () => void;
}

/**
 * Banner component to request notification permissions
 *
 * Shows when:
 * - Notifications are supported
 * - Permission is not yet granted
 * - User hasn't dismissed the banner
 */
export const NotificationBanner = ({ onDismiss }: NotificationBannerProps) => {
	const { permission, isSupported, requestPermission } = useNotifications();
	const [isVisible, setIsVisible] = useState(true);
	const [isRequesting, setIsRequesting] = useState(false);

	const handleEnable = useCallback(async () => {
		setIsRequesting(true);
		try {
			const result = await requestPermission();
			if (result === "granted") {
				setIsVisible(false);
				onDismiss?.();
			}
		} finally {
			setIsRequesting(false);
		}
	}, [requestPermission, onDismiss]);

	const handleDismiss = useCallback(() => {
		setIsVisible(false);
		onDismiss?.();
	}, [onDismiss]);

	// Don't show if not supported, already granted, or dismissed
	if (!isSupported || permission === "granted" || !isVisible) {
		return null;
	}

	// Don't show if permanently denied
	if (permission === "denied") {
		return null;
	}

	return (
		<Card className="relative border-primary/50 bg-primary/5">
			<CardContent className="pt-6">
				<div className="flex gap-4">
					<div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary/10">
						<Bell className="h-5 w-5 text-primary" />
					</div>
					<div className="flex-1">
						<CardTitle className="mb-1 text-base">
							Enable Notifications
						</CardTitle>
						<CardDescription className="mb-3 text-sm">
							Get instant alerts when you receive new orders. Never miss an
							order again!
						</CardDescription>
						<div className="flex gap-2">
							<Button size="sm" onClick={handleEnable} disabled={isRequesting}>
								{isRequesting ? "Requesting..." : "Enable Notifications"}
							</Button>
							<Button size="sm" variant="outline" onClick={handleDismiss}>
								Maybe Later
							</Button>
						</div>
					</div>
					<Button
						size="icon"
						variant="ghost"
						className="h-8 w-8 shrink-0"
						onClick={handleDismiss}
					>
						<X className="h-4 w-4" />
						<span className="sr-only">Dismiss</span>
					</Button>
				</div>
			</CardContent>
		</Card>
	);
};
