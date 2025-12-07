import { m } from "@repo/i18n";
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
	minWithdrawalAmount?: number;
}

export function WithdrawDialog({
	open,
	onOpenChange,
	availableBalance,
	minWithdrawalAmount = 50000,
}: WithdrawDialogProps) {
	const [amount, setAmount] = useState("");
	const [bankProvider, setBankProvider] = useState<BankProvider>("BCA");
	const [accountNumber, setAccountNumber] = useState("");
	const [accountName, setAccountName] = useState("");

	const withdrawMutation = useMutation({
		mutationFn: async () => {
			const withdrawAmount = Number.parseFloat(amount);
			if (Number.isNaN(withdrawAmount) || withdrawAmount <= 0) {
				throw new Error(m.withdraw_wallet_invalid_amount());
			}

			if (withdrawAmount < minWithdrawalAmount) {
				throw new Error(m.withdraw_wallet_minimum());
			}

			if (withdrawAmount > availableBalance) {
				throw new Error(m.withdraw_wallet_insufficient());
			}

			if (!accountNumber.trim()) {
				throw new Error(m.withdraw_wallet_account_required());
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
			toast.success(m.withdraw_wallet_success());
			onOpenChange(false);
			resetForm();
			queryClient.invalidateQueries();
		},
		onError: (error: Error) => {
			toast.error(m.withdraw_wallet_error({ error: error.message }));
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
					<DialogTitle>{m.withdraw_wallet_title()}</DialogTitle>
					<DialogDescription>{m.withdraw_wallet_desc()}</DialogDescription>
				</DialogHeader>

				<form onSubmit={handleSubmit} className="space-y-4">
					{/* Available Balance */}
					<div className="rounded-lg border bg-muted/50 p-4">
						<p className="text-muted-foreground text-sm">
							{m.withdraw_wallet_available()}
						</p>
						<p className="font-semibold text-2xl">
							{formatCurrency(availableBalance)}
						</p>
					</div>

					{/* Amount */}
					<div>
						<Label htmlFor="amount">{m.withdraw_wallet_amount()}</Label>
						<Input
							id="amount"
							type="number"
							placeholder={m.withdraw_wallet_amount_placeholder()}
							value={amount}
							onChange={(e) => setAmount(e.target.value)}
							min={minWithdrawalAmount}
							max={availableBalance}
							step={1000}
							required
							disabled={withdrawMutation.isPending}
						/>
						{amount && Number.parseFloat(amount) > 0 && (
							<p className="mt-1 text-xs">
								{Number.parseFloat(amount) < minWithdrawalAmount ? (
									<span className="text-destructive">
										{m.withdraw_wallet_amount_min()}
									</span>
								) : Number.parseFloat(amount) > availableBalance ? (
									<span className="text-destructive">
										{m.withdraw_wallet_amount_exceeds()}
									</span>
								) : (
									<span className="text-muted-foreground">
										{m.withdraw_wallet_receive({
											amount: formatCurrency(Number.parseFloat(amount)),
										})}
									</span>
								)}
							</p>
						)}
					</div>

					{/* Bank Provider */}
					<div>
						<Label htmlFor="bank">{m.withdraw_wallet_bank()}</Label>
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
						<Label htmlFor="accountNumber">
							{m.withdraw_wallet_account_number()}
						</Label>
						<Input
							id="accountNumber"
							type="text"
							placeholder={m.withdraw_wallet_account_number_placeholder()}
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
							{m.withdraw_wallet_account_name()}{" "}
							<span className="text-muted-foreground text-xs">
								({m.optional()})
							</span>
						</Label>
						<Input
							id="accountName"
							type="text"
							placeholder={m.withdraw_wallet_account_name_placeholder()}
							value={accountName}
							onChange={(e) => setAccountName(e.target.value)}
							disabled={withdrawMutation.isPending}
						/>
						<p className="mt-1 text-muted-foreground text-xs">
							{m.withdraw_wallet_account_name_desc()}
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
							{m.cancel()}
						</Button>
						<Button type="submit" disabled={withdrawMutation.isPending}>
							{withdrawMutation.isPending
								? m.withdraw_wallet_processing()
								: m.withdraw_wallet_title()}
						</Button>
					</DialogFooter>
				</form>
			</DialogContent>
		</Dialog>
	);
}
