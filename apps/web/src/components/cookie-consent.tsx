import { m } from "@repo/i18n";
import { Link } from "@tanstack/react-router";
import { X } from "lucide-react";
import { useEffect, useState } from "react";
import { Button } from "@/components/ui/button";

const CONSENT_COOKIE_NAME = "cookie-consent";
const CONSENT_EXPIRY_DAYS = 365;

export function CookieConsent() {
	const [isVisible, setIsVisible] = useState(false);

	useEffect(() => {
		const consent = localStorage.getItem(CONSENT_COOKIE_NAME);
		if (!consent) {
			setIsVisible(true);
		}
	}, []);

	const handleAccept = () => {
		localStorage.setItem(
			CONSENT_COOKIE_NAME,
			JSON.stringify({
				accepted: true,
				timestamp: new Date().toISOString(),
				expiresIn: CONSENT_EXPIRY_DAYS,
			}),
		);
		setIsVisible(false);
	};

	const handleDismiss = () => {
		setIsVisible(false);
	};

	if (!isVisible) {
		return null;
	}

	return (
		<div className="fixed right-4 bottom-4 left-4 z-50 md:right-4 md:left-auto md:max-w-md">
			<div className="rounded-lg border bg-background p-4 shadow-lg">
				<div className="flex items-start justify-between gap-3">
					<div className="flex-1 space-y-2">
						<p className="text-muted-foreground text-sm">
							{m.cookie_consent_message()}
						</p>
						<div className="flex flex-wrap gap-2">
							<Button size="sm" onClick={handleAccept}>
								{m.cookie_accept()}
							</Button>
							<Button size="sm" variant="outline" asChild>
								<Link to="/cookies">{m.learn_more()}</Link>
							</Button>
						</div>
					</div>
					<Button
						size="icon"
						variant="ghost"
						className="h-6 w-6 shrink-0"
						onClick={handleDismiss}
						aria-label={m.cookie_dismiss()}
					>
						<X className="h-4 w-4" />
					</Button>
				</div>
			</div>
		</div>
	);
}
