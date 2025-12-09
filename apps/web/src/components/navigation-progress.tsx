import { useRouterState } from "@tanstack/react-router";
import * as React from "react";
import { Progress } from "@/components/ui/progress";

export function NavigationProgress() {
	const routerState = useRouterState();
	const [visible, setVisible] = React.useState(false);

	const isNavigating = routerState.status === "pending";

	// Calculate actual progress based on route matches
	const progress = React.useMemo(() => {
		if (!isNavigating) return 100;

		const pendingMatches = routerState.pendingMatches ?? [];
		const matches = routerState.matches ?? [];

		if (pendingMatches.length === 0) return 0;

		// Count how many pending matches have completed loading
		const loadedCount = pendingMatches.filter(
			(match) => match.status === "success",
		).length;

		// Calculate progress as percentage of loaded matches
		const matchProgress = (loadedCount / pendingMatches.length) * 100;

		// Also consider if we have resolved matches vs pending
		const resolvedRatio =
			matches.length > 0 ? (matches.length / pendingMatches.length) * 50 : 0;

		return Math.min(Math.max(matchProgress, resolvedRatio), 95);
	}, [isNavigating, routerState.pendingMatches, routerState.matches]);

	React.useEffect(() => {
		if (isNavigating) {
			setVisible(true);
		} else {
			// Hide after completion animation
			const timeout = setTimeout(() => setVisible(false), 200);
			return () => clearTimeout(timeout);
		}
	}, [isNavigating]);

	if (!visible) return null;

	return (
		<div className="fixed top-0 right-0 left-0 z-50">
			<Progress
				value={progress}
				className="h-1 rounded-none border-0 bg-transparent shadow-none"
				indicatorClassName="bg-primary/80 backdrop-blur-sm transition-all duration-150 ease-out"
			/>
		</div>
	);
}
