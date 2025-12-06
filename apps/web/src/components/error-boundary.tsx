import { m } from "@repo/i18n";
import { Component, type ErrorInfo, type ReactNode } from "react";
import { log } from "@/utils/logger";

interface Props {
	children: ReactNode;
	fallback?: (error: Error, reset: () => void) => ReactNode;
	onError?: (error: Error, errorInfo: ErrorInfo) => void;
}

interface State {
	hasError: boolean;
	error: Error | null;
}

/**
 * Error Boundary component to catch and handle React errors
 * Prevents entire app crash when a component throws an error
 */
export class ErrorBoundary extends Component<Props, State> {
	constructor(props: Props) {
		super(props);
		this.state = { hasError: false, error: null };
	}

	static getDerivedStateFromError(error: Error): State {
		// Update state so the next render will show the fallback UI
		return { hasError: true, error };
	}

	componentDidCatch(error: Error, errorInfo: ErrorInfo): void {
		// Log error to logging service
		log.error(
			{
				error,
				componentStack: errorInfo.componentStack,
			},
			"[ErrorBoundary] React component error",
		);

		// Call custom error handler if provided
		this.props.onError?.(error, errorInfo);
	}

	reset = (): void => {
		this.setState({ hasError: false, error: null });
	};

	render(): ReactNode {
		if (this.state.hasError && this.state.error) {
			// Use custom fallback if provided
			if (this.props.fallback) {
				return this.props.fallback(this.state.error, this.reset);
			}

			// Default fallback UI
			return (
				<DefaultErrorFallback error={this.state.error} reset={this.reset} />
			);
		}

		return this.props.children;
	}
}

/**
 * Default error fallback UI
 */
function DefaultErrorFallback({
	error,
	reset,
}: {
	error: Error;
	reset: () => void;
}) {
	return (
		<div className="flex min-h-screen items-center justify-center bg-background p-4">
			<div className="w-full max-w-md space-y-6 rounded-lg border border-destructive/50 bg-card p-6 shadow-lg">
				<div className="space-y-2">
					<h1 className="font-bold text-2xl text-destructive">
						{m.error_fallback_title()}
					</h1>
					<p className="text-muted-foreground text-sm">
						{m.error_fallback_desc()}
					</p>
				</div>

				<div className="rounded-md bg-muted p-4">
					<p className="break-words font-mono text-foreground text-sm">
						{error.message}
					</p>
					{error.stack && (
						<details className="mt-2">
							<summary className="cursor-pointer text-muted-foreground text-xs hover:text-foreground">
								{m.error_view_stack()}
							</summary>
							<pre className="mt-2 overflow-x-auto whitespace-pre-wrap text-xs">
								{error.stack}
							</pre>
						</details>
					)}
				</div>

				<div className="flex gap-3">
					<button
						type="button"
						onClick={reset}
						className="flex-1 rounded-md bg-primary px-4 py-2 font-medium text-primary-foreground text-sm transition-colors hover:bg-primary/90"
					>
						{m.try_again()}
					</button>
					<button
						type="button"
						onClick={() => window.location.reload()}
						className="flex-1 rounded-md border border-input bg-background px-4 py-2 font-medium text-sm transition-colors hover:bg-accent hover:text-accent-foreground"
					>
						{m.reload()}
					</button>
				</div>

				<div className="flex justify-center">
					<a href="/" className="text-primary text-sm hover:underline">
						{m.error_go_home()}
					</a>
				</div>
			</div>
		</div>
	);
}
