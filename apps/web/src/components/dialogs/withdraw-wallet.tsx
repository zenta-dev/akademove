import type { BankProvider } from "@repo/schema/common";
import { useMutation } from "@tanstack/react-query";
import { useState } from "react";
import { toast } from "sonner";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
} from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { orpcClient, queryClient } from "@/lib/orpc";

const BANK_PROVIDERS: { value: BankProvider; label: string }[] = [
	{ value: "BCA", label: "BCA" },
	{ value: "BNI", label: "BNI" },
	{ value: "BRI", label: "BRI" },
	{ value: "MANDIRI", label: "Mandiri" },
	{ value: "PERMATA", label: "Permata" },
];

interface WithdrawDialogProps {
	open: boolean;
	onOpenChange: (open: boolean) => void;
	availableBalance: number;
}

export function WithdrawDialog({
	open,
	onOpenChange,
	availableBalance,
}: WithdrawDialogProps) {
	const [amount, setAmount] = useState("");
	const [bankProvider, setBankProvider] = useState<BankProvider>("BCA");
	const [accountNumber, setAccountNumber] = useState("");
	const [accountName, setAccountName] = useState("");

	const withdrawMutation = useMutation({
		mutationFn: async () => {
			const withdrawAmount = Number.parseFloat(amount);
			if (Number.isNaN(withdrawAmount) || withdrawAmount <= 0) {
				throw new Error("Invalid amount");
			}

			if (withdrawAmount < 50000) {
				throw new Error("Minimum withdrawal amount is 50,000 IDR");
			}

			if (withdrawAmount > availableBalance) {
				throw new Error("Insufficient balance");
			}

			if (!accountNumber.trim()) {
				throw new Error("Account number is required");
			}

			const result = await orpcClient.wallet.withdraw({
				body: {
					amount: withdrawAmount,
					bankProvider,
					accountNumber: accountNumber.trim(),
					accountName: accountName.trim() || undefined,
				},
			});

			if (result.status !== 200) {
				throw new Error(result.body.message);
			}

			return result.body.data;
		},
		onSuccess: () => {
			toast.success(
				"Withdrawal request submitted successfully! It will be processed within 1-3 business days.",
			);
			onOpenChange(false);
			resetForm();
			queryClient.invalidateQueries({ queryKey: ["wallet"] });
			queryClient.invalidateQueries({ queryKey: ["transactions"] });
		},
		onError: (error: Error) => {
			toast.error(`Failed to request withdrawal: ${error.message}`);
		},
	});

	const resetForm = () => {
		setAmount("");
		setBankProvider("BCA");
		setAccountNumber("");
		setAccountName("");
	};

	const handleSubmit = (e: React.FormEvent) => {
		e.preventDefault();
		withdrawMutation.mutate();
	};

	const formatCurrency = (value: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(value);
	};

	return (
		<Dialog open={open} onOpenChange={onOpenChange}>
			<DialogContent className="max-w-md">
				<DialogHeader>
					<DialogTitle>Request Withdrawal</DialogTitle>
					<DialogDescription>
						Withdraw your earnings to your bank account. Processing time: 1-3
						business days.
					</DialogDescription>
				</DialogHeader>

				<form onSubmit={handleSubmit} className="space-y-4">
					{/* Available Balance */}
					<div className="rounded-lg border bg-muted/50 p-4">
						<p className="text-muted-foreground text-sm">Available Balance</p>
						<p className="font-semibold text-2xl">
							{formatCurrency(availableBalance)}
						</p>
					</div>

					{/* Amount */}
					<div>
						<Label htmlFor="amount">
							Withdrawal Amount{" "}
							<span className="text-muted-foreground text-xs">
								(min. 50,000 IDR)
							</span>
						</Label>
						<Input
							id="amount"
							type="number"
							placeholder="50000"
							value={amount}
							onChange={(e) => setAmount(e.target.value)}
							min={50000}
							max={availableBalance}
							step={1000}
							required
							disabled={withdrawMutation.isPending}
						/>
						{amount && Number.parseFloat(amount) > 0 && (
							<p className="mt-1 text-xs">
								{Number.parseFloat(amount) < 50000 ? (
									<span className="text-destructive">
										Minimum withdrawal is 50,000 IDR
									</span>
								) : Number.parseFloat(amount) > availableBalance ? (
									<span className="text-destructive">
										Amount exceeds available balance
									</span>
								) : (
									<span className="text-muted-foreground">
										You will receive:{" "}
										{formatCurrency(Number.parseFloat(amount))}
									</span>
								)}
							</p>
						)}
					</div>

					{/* Bank Provider */}
					<div>
						<Label htmlFor="bank">Bank</Label>
						<Select
							value={bankProvider}
							onValueChange={(value) => setBankProvider(value as BankProvider)}
							disabled={withdrawMutation.isPending}
						>
							<SelectTrigger id="bank">
								<SelectValue />
							</SelectTrigger>
							<SelectContent>
								{BANK_PROVIDERS.map((bank) => (
									<SelectItem key={bank.value} value={bank.value}>
										{bank.label}
									</SelectItem>
								))}
							</SelectContent>
						</Select>
					</div>

					{/* Account Number */}
					<div>
						<Label htmlFor="accountNumber">Account Number</Label>
						<Input
							id="accountNumber"
							type="text"
							placeholder="1234567890"
							value={accountNumber}
							onChange={(e) =>
								setAccountNumber(e.target.value.replace(/\D/g, ""))
							}
							required
							disabled={withdrawMutation.isPending}
						/>
					</div>

					{/* Account Name (Optional) */}
					<div>
						<Label htmlFor="accountName">
							Account Name{" "}
							<span className="text-muted-foreground text-xs">(optional)</span>
						</Label>
						<Input
							id="accountName"
							type="text"
							placeholder="John Doe"
							value={accountName}
							onChange={(e) => setAccountName(e.target.value)}
							disabled={withdrawMutation.isPending}
						/>
						<p className="mt-1 text-muted-foreground text-xs">
							For verification purposes
						</p>
					</div>

					<DialogFooter>
						<Button
							type="button"
							variant="outline"
							onClick={() => {
								onOpenChange(false);
								resetForm();
							}}
							disabled={withdrawMutation.isPending}
						>
							Cancel
						</Button>
						<Button type="submit" disabled={withdrawMutation.isPending}>
							{withdrawMutation.isPending
								? "Processing..."
								: "Request Withdrawal"}
						</Button>
					</DialogFooter>
				</form>
			</DialogContent>
		</Dialog>
	);
}
