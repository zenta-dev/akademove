import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import { Link } from "@tanstack/react-router";
import {
	AlertCircle,
	ArrowRight,
	CheckCircle,
	Clock,
	XCircle,
} from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { cn } from "@/utils/cn";

export type DashRole = "admin" | "operator";

// Pending Drivers Table Component
export function PendingDriversTable({
	drivers,
	dashRole,
}: {
	drivers: Driver[];
	dashRole: DashRole;
}) {
	return (
		<Table>
			<TableHeader>
				<TableRow>
					<TableHead>Driver</TableHead>
					<TableHead>Student ID</TableHead>
					<TableHead>License Plate</TableHead>
					<TableHead>Quiz Status</TableHead>
					<TableHead>Applied</TableHead>
					<TableHead className="text-right">Action</TableHead>
				</TableRow>
			</TableHeader>
			<TableBody>
				{drivers.map((driver) => (
					<TableRow key={driver.id}>
						<TableCell>
							<div className="flex flex-col">
								<span className="font-medium">
									{driver.user?.name ?? "Unknown"}
								</span>
								<span className="text-muted-foreground text-sm">
									{driver.user?.email}
								</span>
							</div>
						</TableCell>
						<TableCell>{driver.studentId}</TableCell>
						<TableCell>{driver.licensePlate}</TableCell>
						<TableCell>
							<QuizStatusBadge status={driver.quizStatus} />
						</TableCell>
						<TableCell>
							{driver.createdAt
								? new Date(driver.createdAt).toLocaleDateString("id-ID", {
										day: "numeric",
										month: "short",
										year: "numeric",
									})
								: "-"}
						</TableCell>
						<TableCell className="text-right">
							<Button variant="outline" size="sm" asChild>
								<Link
									to={
										dashRole === "admin"
											? "/dash/admin/driver-approval/$driverId"
											: "/dash/operator/driver-approval/$driverId"
									}
									params={{ driverId: driver.id }}
								>
									Review
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						</TableCell>
					</TableRow>
				))}
			</TableBody>
		</Table>
	);
}

// Pending Merchants Table Component
export function PendingMerchantsTable({
	merchants,
	dashRole,
}: {
	merchants: Merchant[];
	dashRole: DashRole;
}) {
	return (
		<Table>
			<TableHeader>
				<TableRow>
					<TableHead>Merchant</TableHead>
					<TableHead>Category</TableHead>
					<TableHead>Address</TableHead>
					<TableHead>Applied</TableHead>
					<TableHead className="text-right">Action</TableHead>
				</TableRow>
			</TableHeader>
			<TableBody>
				{merchants.map((merchant) => (
					<TableRow key={merchant.id}>
						<TableCell>
							<div className="flex flex-col">
								<span className="font-medium">{merchant.name}</span>
								<span className="text-muted-foreground text-sm">
									{merchant.email}
								</span>
							</div>
						</TableCell>
						<TableCell>
							<Badge variant="outline">{merchant.category ?? "N/A"}</Badge>
						</TableCell>
						<TableCell className="max-w-[200px] truncate">
							{merchant.address ?? "-"}
						</TableCell>
						<TableCell>
							{merchant.createdAt
								? new Date(merchant.createdAt).toLocaleDateString("id-ID", {
										day: "numeric",
										month: "short",
										year: "numeric",
									})
								: "-"}
						</TableCell>
						<TableCell className="text-right">
							<Button variant="outline" size="sm" asChild>
								<Link
									to={
										dashRole === "admin"
											? "/dash/admin/merchant-approval/$merchantId"
											: "/dash/operator/merchant-approval/$merchantId"
									}
									params={{ merchantId: merchant.id }}
								>
									Review
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						</TableCell>
					</TableRow>
				))}
			</TableBody>
		</Table>
	);
}

// Quiz Status Badge Component
export function QuizStatusBadge({ status }: { status: string | undefined }) {
	const statusConfig: Record<
		string,
		{ color: string; icon: React.ElementType }
	> = {
		NOT_STARTED: { color: "bg-gray-500/20 text-gray-500", icon: Clock },
		IN_PROGRESS: { color: "bg-blue-500/20 text-blue-500", icon: AlertCircle },
		PASSED: { color: "bg-green-500/20 text-green-500", icon: CheckCircle },
		FAILED: { color: "bg-red-500/20 text-red-500", icon: XCircle },
	};

	const config =
		statusConfig[status ?? "NOT_STARTED"] ?? statusConfig.NOT_STARTED;
	const Icon = config.icon;

	return (
		<Badge variant="secondary" className={cn(config.color)}>
			<Icon className="mr-1 h-3 w-3" />
			{status ?? "NOT_STARTED"}
		</Badge>
	);
}
