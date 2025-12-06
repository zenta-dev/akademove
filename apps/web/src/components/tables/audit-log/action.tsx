import { m } from "@repo/i18n";
import { EyeIcon } from "lucide-react";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { ScrollArea } from "@/components/ui/scroll-area";
import type { AuditLog } from "@/lib/types/audit";

interface Props {
	auditLog: AuditLog;
}

export function AuditLogAction({ auditLog }: Props) {
	const [open, setOpen] = useState(false);

	return (
		<>
			<Button
				variant="ghost"
				size="icon"
				onClick={() => setOpen(true)}
				title={m.view_details()}
			>
				<EyeIcon className="h-4 w-4" />
			</Button>

			<Dialog open={open} onOpenChange={setOpen}>
				<DialogContent className="max-w-3xl">
					<DialogHeader>
						<DialogTitle>{m.audit_log_details()}</DialogTitle>
						<DialogDescription>
							{auditLog.tableName} - {auditLog.operation} - {m.record_id()}{" "}
							{auditLog.recordId.slice(0, 8)}
						</DialogDescription>
					</DialogHeader>

					<ScrollArea className="max-h-[600px]">
						<div className="space-y-4">
							<div>
								<h4 className="mb-2 font-medium">{m.metadata()}</h4>
								<div className="space-y-2 rounded-md bg-muted p-4">
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.updated_by()}:
										</span>
										<code className="truncate text-xs">
											{auditLog.updatedById ?? m.system()}
										</code>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.ip_address()}:
										</span>
										<code className="text-xs">
											{auditLog.ipAddress ?? "N/A"}
										</code>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.user_agent()}:
										</span>
										<code className="text-xs">
											{auditLog.userAgent
												? auditLog.userAgent.slice(0, 50)
												: "N/A"}
										</code>
									</div>
									<div className="flex justify-between">
										<span className="text-muted-foreground text-sm">
											{m.session_id()}:
										</span>
										<code className="text-xs">
											{auditLog.sessionId?.slice(0, 16) ?? "N/A"}
										</code>
									</div>
									{auditLog.reason && (
										<div className="flex justify-between">
											<span className="text-muted-foreground text-sm">
												{m.ban_reason()}:
											</span>
											<span className="text-xs">{auditLog.reason}</span>
										</div>
									)}
								</div>
							</div>

							{auditLog.oldData !== null && auditLog.oldData !== undefined && (
								<div>
									<h4 className="mb-2 font-medium">{m.old_data()}</h4>
									<pre className="overflow-x-auto rounded-md bg-muted p-4 text-xs">
										{JSON.stringify(auditLog.oldData, null, 2)}
									</pre>
								</div>
							)}

							{auditLog.newData !== null && auditLog.newData !== undefined && (
								<div>
									<h4 className="mb-2 font-medium">{m.new_data()}</h4>
									<pre className="overflow-x-auto rounded-md bg-muted p-4 text-xs">
										{JSON.stringify(auditLog.newData, null, 2)}
									</pre>
								</div>
							)}
						</div>
					</ScrollArea>
				</DialogContent>
			</Dialog>
		</>
	);
}
