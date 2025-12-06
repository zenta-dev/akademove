import { createFileRoute } from "@tanstack/react-router";
import { AccountDeletionForm } from "@/components/account-deletion-form";
import {
	LegalLayout,
	LegalSection,
	type LegalSection as LegalSectionType,
} from "@/components/legal/legal-layout";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { APP_NAME } from "@/lib/constants";

export const Route = createFileRoute("/(legal)/account-deletion")({
	component: AccountDeletionComponent,
	head: () => ({
		meta: [
			{
				title: `Account Deletion - ${APP_NAME}`,
			},
			{
				name: "description",
				content:
					"Request account deletion from AkadeMove. Learn what data will be deleted and how to submit a deletion request.",
			},
		],
	}),
});

const sections: LegalSectionType[] = [
	{ id: "overview", title: "Overview" },
	{ id: "what-gets-deleted", title: "What Gets Deleted" },
	{ id: "what-is-retained", title: "What Is Retained" },
	{ id: "how-to-request", title: "How to Request Deletion" },
	{ id: "processing-time", title: "Processing Time" },
	{ id: "consequences", title: "Consequences of Deletion" },
];

function AccountDeletionComponent() {
	const lastUpdated = "December 6, 2025";

	return (
		<LegalLayout
			title="Account Deletion Request"
			lastUpdated={lastUpdated}
			sections={sections}
		>
			<LegalSection id="overview" title="Overview">
				<div className="space-y-4">
					<p className="text-muted-foreground">
						You have the right to request deletion of your {APP_NAME} account
						and associated personal data at any time. This page explains the
						account deletion process, what data will be removed, and how to
						submit a deletion request.
					</p>

					<Card className="border-blue-200 bg-blue-50 dark:border-blue-900 dark:bg-blue-950">
						<CardContent className="pt-6">
							<p className="text-blue-900 text-sm dark:text-blue-100">
								<strong>⚠️ Important:</strong> Account deletion is permanent and
								cannot be undone. Please review this information carefully
								before proceeding.
							</p>
						</CardContent>
					</Card>
				</div>
			</LegalSection>

			<LegalSection id="what-gets-deleted" title="What Gets Deleted">
				<div className="space-y-4">
					<p className="text-muted-foreground">
						When you request account deletion, the following data will be
						permanently removed from our systems:
					</p>

					<div className="space-y-3">
						<Card>
							<CardHeader>
								<CardTitle className="text-base">Profile Information</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Name, email address, phone number</li>
									<li>Profile photo</li>
									<li>Gender and preferences</li>
									<li>Account credentials (password)</li>
								</ul>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle className="text-base">
									Wallet & Payment Data
								</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Wallet balance (will be forfeited)</li>
									<li>Bank account information</li>
									<li>Pending transactions</li>
								</ul>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle className="text-base">Usage Data</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Order history (non-financial)</li>
									<li>Reviews and ratings</li>
									<li>Chat messages</li>
									<li>App preferences and settings</li>
								</ul>
							</CardContent>
						</Card>

						<Card>
							<CardHeader>
								<CardTitle className="text-base">
									Driver/Merchant Specific Data
								</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>
										KTM (Student ID), SIM (Driver License), STNK documents
									</li>
									<li>Vehicle information and license plate</li>
									<li>Class schedule (KRS)</li>
									<li>Merchant outlet information</li>
									<li>Menu items and product listings</li>
								</ul>
							</CardContent>
						</Card>
					</div>
				</div>
			</LegalSection>

			<LegalSection id="what-is-retained" title="What Is Retained">
				<div className="space-y-4">
					<Card className="border-orange-200 bg-orange-50 dark:border-orange-900 dark:bg-orange-950">
						<CardContent className="pt-6">
							<p className="text-orange-900 text-sm dark:text-orange-100">
								<strong>⚠️ Legal Retention:</strong> Some information must be
								retained for legal and regulatory compliance, even after account
								deletion.
							</p>
						</CardContent>
					</Card>

					<p className="text-muted-foreground">
						The following data will be retained for the specified periods:
					</p>

					<div className="space-y-3">
						<Card className="border-orange-200 dark:border-orange-900">
							<CardHeader>
								<CardTitle className="text-base text-orange-900 dark:text-orange-200">
									Financial Records (10 years)
								</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Transaction history and payment records</li>
									<li>Commission calculations</li>
									<li>Tax-related documentation</li>
									<li>Invoice and receipt data</li>
								</ul>
								<p className="text-muted-foreground text-xs">
									Required by Indonesian tax law and financial regulations
								</p>
							</CardContent>
						</Card>

						<Card className="border-orange-200 dark:border-orange-900">
							<CardHeader>
								<CardTitle className="text-base text-orange-900 dark:text-orange-200">
									Safety & Fraud Prevention (90 days)
								</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Account suspension/violation records</li>
									<li>Fraud investigation data</li>
									<li>Security incident logs</li>
								</ul>
								<p className="text-muted-foreground text-xs">
									Required for platform safety and dispute resolution
								</p>
							</CardContent>
						</Card>

						<Card className="border-orange-200 dark:border-orange-900">
							<CardHeader>
								<CardTitle className="text-base text-orange-900 dark:text-orange-200">
									Anonymized Analytics (Indefinite)
								</CardTitle>
							</CardHeader>
							<CardContent className="space-y-3">
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>
										Aggregated usage statistics (with all personal identifiers
										removed)
									</li>
									<li>Service improvement metrics</li>
								</ul>
								<p className="text-muted-foreground text-xs">
									Cannot be linked back to you after anonymization
								</p>
							</CardContent>
						</Card>
					</div>
				</div>
			</LegalSection>

			<LegalSection id="how-to-request" title="How to Request Deletion">
				<div className="space-y-6">
					<p className="text-muted-foreground">
						You can request account deletion using one of the following methods:
					</p>

					<div className="space-y-4">
						<Card className="border-primary/20 bg-primary/5">
							<CardContent className="pt-6">
								<div className="flex items-start gap-4">
									<div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-primary/10">
										<span className="font-bold text-2xl text-primary">1</span>
									</div>
									<div className="flex-1 space-y-3">
										<h4 className="font-semibold text-lg">
											In-App Deletion (Recommended)
										</h4>
										<ol className="list-inside list-decimal space-y-2 text-muted-foreground text-sm">
											<li>Open the {APP_NAME} mobile app</li>
											<li>
												Go to <strong>Profile</strong> →{" "}
												<strong>Settings</strong>
											</li>
											<li>
												Scroll to <strong>Account Management</strong>
											</li>
											<li>
												Tap <strong>"Delete Account"</strong>
											</li>
											<li>Follow the confirmation prompts</li>
										</ol>
										<p className="text-muted-foreground text-sm">
											This is the fastest method and provides immediate
											confirmation.
										</p>
									</div>
								</div>
							</CardContent>
						</Card>

						<Card>
							<CardContent className="pt-6">
								<div className="flex items-start gap-4">
									<div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-muted">
										<span className="font-bold text-2xl">2</span>
									</div>
									<div className="flex-1 space-y-3">
										<h4 className="font-semibold text-lg">Email Request</h4>
										<p className="text-muted-foreground text-sm">
											Send an email to our data protection team with the subject
											line <strong>"Account Deletion Request"</strong>
										</p>
										<div className="rounded-lg bg-muted p-4">
											<div className="flex items-center gap-2">
												<span className="font-medium text-sm">📧</span>
												<a
													href="mailto:privacy@akademove.com?subject=Account%20Deletion%20Request"
													className="font-medium text-primary hover:underline"
												>
													privacy@akademove.com
												</a>
											</div>
										</div>
										<div className="space-y-2 text-muted-foreground text-sm">
											<p className="font-medium">Include in your email:</p>
											<ul className="list-inside list-disc space-y-1">
												<li>Your registered email address</li>
												<li>Your registered phone number</li>
												<li>Your full name as registered</li>
												<li>Account type (User, Driver, or Merchant)</li>
												<li>Reason for deletion (optional)</li>
											</ul>
										</div>
										<Card className="border-blue-200 bg-blue-50 dark:border-blue-900 dark:bg-blue-950">
											<CardContent className="py-3">
												<p className="text-blue-900 text-xs dark:text-blue-100">
													ℹ️ We may contact you to verify your identity before
													processing the deletion request.
												</p>
											</CardContent>
										</Card>
									</div>
								</div>
							</CardContent>
						</Card>

						<Card>
							<CardContent className="pt-6">
								<div className="flex items-start gap-4">
									<div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-muted">
										<span className="font-bold text-2xl">3</span>
									</div>
									<div className="flex-1 space-y-3">
										<h4 className="font-semibold text-lg">WhatsApp Support</h4>
										<p className="text-muted-foreground text-sm">
											Contact our support team via WhatsApp
										</p>
										<div className="rounded-lg bg-muted p-4">
											<div className="flex items-center gap-2">
												<span className="text-green-600 text-xl">📱</span>
												<a
													href="https://wa.me/622112345678"
													target="_blank"
													rel="noopener noreferrer"
													className="font-medium text-primary hover:underline"
												>
													+62 21 1234 5678
												</a>
											</div>
										</div>
										<p className="text-muted-foreground text-xs">
											Available Monday-Friday, 9:00 AM - 5:00 PM WIB
										</p>
									</div>
								</div>
							</CardContent>
						</Card>
					</div>

					<Card className="border-blue-200 bg-blue-50 dark:border-blue-900 dark:bg-blue-950">
						<CardContent className="pt-6">
							<p className="text-blue-900 text-sm dark:text-blue-100">
								<strong>💡 Tip:</strong> For fastest processing, use the in-app
								deletion feature. Email requests may take 3-5 business days to
								process due to identity verification requirements.
							</p>
						</CardContent>
					</Card>
				</div>
			</LegalSection>

			<LegalSection id="processing-time" title="Processing Time">
				<div className="space-y-4">
					<p className="text-muted-foreground">
						Account deletion processing times vary by method:
					</p>

					<div className="grid gap-4 md:grid-cols-2">
						<Card className="border-green-200 dark:border-green-900">
							<CardHeader>
								<CardTitle className="flex items-center gap-2 text-base">
									<span className="text-green-600">✓</span>
									In-App Deletion
								</CardTitle>
							</CardHeader>
							<CardContent className="space-y-2">
								<p className="font-bold text-2xl">Immediate</p>
								<p className="text-muted-foreground text-sm">
									Account is deactivated immediately. Complete data removal
									within 48 hours.
								</p>
							</CardContent>
						</Card>

						<Card className="border-orange-200 dark:border-orange-900">
							<CardHeader>
								<CardTitle className="flex items-center gap-2 text-base">
									<span className="text-orange-600">⏱</span>
									Email/WhatsApp Request
								</CardTitle>
							</CardHeader>
							<CardContent className="space-y-2">
								<p className="font-bold text-2xl">3-5 Business Days</p>
								<p className="text-muted-foreground text-sm">
									Includes identity verification. Complete data removal within 7
									days of verification.
								</p>
							</CardContent>
						</Card>
					</div>

					<p className="text-muted-foreground text-sm">
						You will receive a confirmation email once your account has been
						fully deleted. If you don't receive confirmation within the expected
						timeframe, please contact{" "}
						<a
							href="mailto:privacy@akademove.com"
							className="text-primary hover:underline"
						>
							privacy@akademove.com
						</a>
						.
					</p>
				</div>
			</LegalSection>

			<LegalSection id="consequences" title="Consequences of Deletion">
				<div className="space-y-4">
					<Card className="border-red-200 bg-red-50 dark:border-red-900 dark:bg-red-950">
						<CardContent className="pt-6">
							<p className="text-red-900 text-sm dark:text-red-100">
								<strong>⚠️ Warning:</strong> Account deletion is{" "}
								<strong>permanent and irreversible</strong>. Please consider
								these consequences carefully.
							</p>
						</CardContent>
					</Card>

					<div className="space-y-3">
						<Card className="border-red-200 dark:border-red-900">
							<CardHeader>
								<CardTitle className="text-base text-red-900 dark:text-red-200">
									You Will Lose:
								</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>Access to your account and all associated services</li>
									<li>All wallet balance (no refunds available)</li>
									<li>
										Order history, ratings, reviews, and earned
										badges/achievements
									</li>
									<li>Pending orders (will be automatically cancelled)</li>
									<li>
										Driver/Merchant earnings that haven't been withdrawn (if
										applicable)
									</li>
									<li>Saved addresses, preferences, and favorites</li>
								</ul>
							</CardContent>
						</Card>

						<Card className="border-red-200 dark:border-red-900">
							<CardHeader>
								<CardTitle className="text-base text-red-900 dark:text-red-200">
									You Will Not Be Able To:
								</CardTitle>
							</CardHeader>
							<CardContent>
								<ul className="list-inside list-disc space-y-1 text-muted-foreground text-sm">
									<li>
										Recover any data after deletion is complete (even if you
										change your mind)
									</li>
									<li>
										Complete active orders (they will be cancelled
										automatically)
									</li>
									<li>
										Contact support about orders placed before deletion (after
										retention period)
									</li>
									<li>
										Use the same email address to create a new account for 90
										days
									</li>
								</ul>
							</CardContent>
						</Card>
					</div>

					<Card className="border-blue-200 bg-blue-50 dark:border-blue-900 dark:bg-blue-950">
						<CardContent className="pt-6">
							<p className="text-blue-900 text-sm dark:text-blue-100">
								<strong>💡 Alternative to Deletion:</strong> If you just want to
								take a break, consider deactivating your account instead.
								Deactivation preserves your data and can be reversed anytime.
								Contact support for deactivation options.
							</p>
						</CardContent>
					</Card>
				</div>
			</LegalSection>

			<div className="mt-12">
				<AccountDeletionForm />
			</div>

			<Card className="mt-12 border-primary/20">
				<CardHeader>
					<CardTitle>Need Help?</CardTitle>
				</CardHeader>
				<CardContent className="space-y-4">
					<p className="text-muted-foreground">
						If you have questions about account deletion or need assistance with
						the process, please contact us:
					</p>
					<div className="flex flex-col gap-3 sm:flex-row">
						<Button asChild>
							<a href="mailto:privacy@akademove.com?subject=Account%20Deletion%20Question">
								📧 Email Support
							</a>
						</Button>
						<Button variant="outline" asChild>
							<a
								href="https://wa.me/622112345678"
								target="_blank"
								rel="noopener noreferrer"
							>
								📱 WhatsApp Chat
							</a>
						</Button>
					</div>
				</CardContent>
			</Card>
		</LegalLayout>
	);
}
