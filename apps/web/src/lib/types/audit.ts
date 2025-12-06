export interface AuditLog {
	id: number;
	tableName:
		| "configurations"
		| "contact"
		| "coupon"
		| "report"
		| "user"
		| "wallet";
	recordId: string;
	operation: "INSERT" | "UPDATE" | "DELETE";
	oldData?: unknown | null;
	newData?: unknown | null;
	updatedById?: string | null;
	ipAddress?: string | null;
	userAgent?: string | null;
	sessionId?: string | null;
	reason?: string | null;
	updatedAt: Date;
}
