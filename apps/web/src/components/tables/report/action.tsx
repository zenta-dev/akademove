import { m } from "@repo/i18n";
import type { Report } from "@repo/schema/report";
import { FileText, MoreHorizontal, Search, XCircle } from "lucide-react";
import { useState } from "react";
import { DismissReportDialog } from "@/components/dialogs/dismiss-report";
import { ResolveReportDialog } from "@/components/dialogs/resolve-report";
import { StartInvestigationDialog } from "@/components/dialogs/start-investigation";
import { Button } from "@/components/ui/button";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";

export const ReportActionTable = ({ val }: { val: Report }) => {
	const [investigateOpen, setInvestigateOpen] = useState(false);
	const [resolveOpen, setResolveOpen] = useState(false);
	const [dismissOpen, setDismissOpen] = useState(false);

	const isPending = val.status === "PENDING";
	const isClosed = val.status === "RESOLVED" || val.status === "DISMISSED";

	return (
		<>
			<DropdownMenu>
				<DropdownMenuTrigger asChild>
					<Button variant="ghost" className="h-8 w-8 p-0">
						<span className="sr-only">{m.actions()}</span>
						<MoreHorizontal className="h-4 w-4" />
					</Button>
				</DropdownMenuTrigger>
				<DropdownMenuContent align="end">
					<DropdownMenuLabel>{m.actions()}</DropdownMenuLabel>
					{!isClosed && (
						<>
							{isPending && (
								<DropdownMenuItem
									className="text-blue-600"
									onClick={() => setInvestigateOpen(true)}
								>
									<Search className="mr-2 h-4 w-4" />
									{m.start_investigation()}
								</DropdownMenuItem>
							)}
							<DropdownMenuItem
								className="text-green-600"
								onClick={() => setResolveOpen(true)}
							>
								<FileText className="mr-2 h-4 w-4" />
								{m.resolve_report()}
							</DropdownMenuItem>
							<DropdownMenuSeparator />
							<DropdownMenuItem
								className="text-red-600"
								onClick={() => setDismissOpen(true)}
							>
								<XCircle className="mr-2 h-4 w-4" />
								{m.dismiss_report()}
							</DropdownMenuItem>
						</>
					)}
					{isClosed && (
						<DropdownMenuItem disabled className="text-muted-foreground">
							Report already closed
						</DropdownMenuItem>
					)}
				</DropdownMenuContent>
			</DropdownMenu>

			<StartInvestigationDialog
				open={investigateOpen}
				onOpenChange={setInvestigateOpen}
				report={val}
			/>
			<ResolveReportDialog
				open={resolveOpen}
				onOpenChange={setResolveOpen}
				report={val}
			/>
			<DismissReportDialog
				open={dismissOpen}
				onOpenChange={setDismissOpen}
				report={val}
			/>
		</>
	);
};
