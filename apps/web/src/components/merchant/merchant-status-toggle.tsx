import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Power } from "lucide-react";
import { useCallback, useState } from "react";
import { toast } from "sonner";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { orpcClient } from "@/lib/orpc";

interface MerchantStatusToggleProps {
	merchantId: string;
	isOnline: boolean;
	isTakingOrders: boolean;
	operatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE";
}

export function MerchantStatusToggle({
	merchantId,
	isOnline: initialIsOnline,
	isTakingOrders: initialIsTakingOrders,
	operatingStatus: initialOperatingStatus,
}: MerchantStatusToggleProps) {
	const queryClient = useQueryClient();
	const [isOnline, setIsOnline] = useState(initialIsOnline);
	const [isTakingOrders, setIsTakingOrders] = useState(initialIsTakingOrders);
	const [operatingStatus, setOperatingStatus] = useState(
		initialOperatingStatus,
	);

	// Toggle online status mutation
	const onlineStatusMutation = useMutation({
		mutationFn: async (isOnlineValue: boolean) => {
			const result = await orpcClient.merchant.setOnlineStatus({
				params: { id: merchantId },
				body: { isOnline: isOnlineValue },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data) => {
			setIsOnline(data.isOnline);
			queryClient.invalidateQueries();
			toast.success(data.isOnline ? "You're now online" : "You're now offline");
		},
		onError: (error) => {
			setIsOnline(!isOnline); // Revert state
			toast.error(
				error instanceof Error
					? error.message
					: "Failed to update online status",
			);
		},
	});

	// Toggle order taking status mutation
	const orderTakingMutation = useMutation({
		mutationFn: async (isTakingOrdersValue: boolean) => {
			const result = await orpcClient.merchant.setOrderTakingStatus({
				params: { id: merchantId },
				body: { isTakingOrders: isTakingOrdersValue },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data) => {
			setIsTakingOrders(data.isTakingOrders);
			queryClient.invalidateQueries();
			toast.success(
				data.isTakingOrders
					? "You're now taking orders"
					: "You've stopped taking orders",
			);
		},
		onError: (error) => {
			setIsTakingOrders(!isTakingOrders); // Revert state
			toast.error(
				error instanceof Error
					? error.message
					: "Failed to update order-taking status",
			);
		},
	});

	// Toggle operating status mutation
	const operatingStatusMutation = useMutation({
		mutationFn: async (
			newOperatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE",
		) => {
			const result = await orpcClient.merchant.setOperatingStatus({
				params: { id: merchantId },
				body: { operatingStatus: newOperatingStatus },
			});
			if (result.status !== 200) throw new Error(result.body.message);
			return result.body.data;
		},
		onSuccess: (data) => {
			setOperatingStatus(data.operatingStatus);
			queryClient.invalidateQueries();
			toast.success(`Store is now ${data.operatingStatus.toLowerCase()}`);
		},
		onError: (error) => {
			setOperatingStatus(initialOperatingStatus); // Revert state
			toast.error(
				error instanceof Error
					? error.message
					: "Failed to update operating status",
			);
		},
	});

	const handleOnlineToggle = useCallback(() => {
		const newValue = !isOnline;
		setIsOnline(newValue);
		onlineStatusMutation.mutate(newValue);
	}, [isOnline, onlineStatusMutation]);

	const handleOrderTakingToggle = useCallback(() => {
		const newValue = !isTakingOrders;
		setIsTakingOrders(newValue);
		orderTakingMutation.mutate(newValue);
	}, [isTakingOrders, orderTakingMutation]);

	const handleOperatingStatusChange = useCallback(
		(value: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE") => {
			setOperatingStatus(value);
			operatingStatusMutation.mutate(value);
		},
		[operatingStatusMutation],
	);

	const isLoading =
		onlineStatusMutation.isPending ||
		orderTakingMutation.isPending ||
		operatingStatusMutation.isPending;

	const getStatusColor = () => {
		if (!isOnline) return "text-destructive";
		if (!isTakingOrders) return "text-warning";
		if (operatingStatus === "OPEN") return "text-green-600 dark:text-green-400";
		return "text-amber-600 dark:text-amber-400";
	};

	return (
		<div className="flex flex-col gap-4">
			{/* Main Online/Offline Toggle */}
			<div className="flex items-center justify-between rounded-lg border p-4">
				<div className="flex items-center gap-3">
					<Power className={`h-5 w-5 ${getStatusColor()}`} />
					<div className="flex flex-col">
						<span className="font-medium text-sm">
							{isOnline ? "Online" : "Offline"}
						</span>
						<span className="text-muted-foreground text-xs">
							{isOnline ? "You can receive orders" : "Not receiving orders"}
						</span>
					</div>
				</div>
				<Switch
					checked={isOnline}
					onCheckedChange={handleOnlineToggle}
					disabled={isLoading}
				/>
			</div>

			{/* Order Taking Toggle - Only visible when online */}
			{isOnline && (
				<div className="flex items-center justify-between rounded-lg border p-4">
					<div className="flex flex-col">
						<span className="font-medium text-sm">
							{isTakingOrders ? "Taking Orders" : "Not Taking Orders"}
						</span>
						<span className="text-muted-foreground text-xs">
							{isTakingOrders
								? "Ready to accept new orders"
								: "Temporarily paused"}
						</span>
					</div>
					<Switch
						checked={isTakingOrders}
						onCheckedChange={handleOrderTakingToggle}
						disabled={isLoading || !isOnline}
					/>
				</div>
			)}

			{/* Operating Status Selector - Only visible when online */}
			{isOnline && (
				<div className="rounded-lg border p-4">
					<label
						htmlFor="store-status"
						className="mb-2 block font-medium text-sm"
					>
						Store Status
					</label>
					<Select
						value={operatingStatus}
						onValueChange={handleOperatingStatusChange}
						disabled={isLoading}
					>
						<SelectTrigger id="store-status">
							<SelectValue placeholder="Select store status" />
						</SelectTrigger>
						<SelectContent>
							<SelectItem value="OPEN">
								<span className="text-green-600 dark:text-green-400">
									● Open
								</span>
							</SelectItem>
							<SelectItem value="BREAK">
								<span className="text-amber-600 dark:text-amber-400">
									● On Break
								</span>
							</SelectItem>
							<SelectItem value="MAINTENANCE">
								<span className="text-orange-600 dark:text-orange-400">
									● Under Maintenance
								</span>
							</SelectItem>
							<SelectItem value="CLOSED">
								<span className="text-destructive">● Closed</span>
							</SelectItem>
						</SelectContent>
					</Select>
					<p className="mt-2 text-muted-foreground text-xs">
						Let customers know your current store status
					</p>
				</div>
			)}

			{/* Status Summary */}
			<div className="rounded-lg bg-muted p-3">
				<p className="font-medium text-muted-foreground text-xs">
					Current Status:{" "}
					<span className={`font-semibold ${getStatusColor()}`}>
						{!isOnline
							? "Offline"
							: !isTakingOrders
								? "Online (Paused)"
								: `Online - ${operatingStatus}`}
					</span>
				</p>
			</div>
		</div>
	);
}
