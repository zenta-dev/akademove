import type { Coupon } from "@repo/schema/coupon";
import { useMutation } from "@tanstack/react-query";
import { Check, Loader2, Tag, X } from "lucide-react";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { orpcClient, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";

interface CouponInputProps {
	orderAmount: number;
	onCouponApplied: (coupon: Coupon, discountAmount: number) => void;
	onCouponRemoved: () => void;
	appliedCoupon?: Coupon;
	discountAmount?: number;
	disabled?: boolean;
}

export function CouponInput({
	orderAmount,
	onCouponApplied,
	onCouponRemoved,
	appliedCoupon,
	discountAmount = 0,
	disabled = false,
}: CouponInputProps) {
	const [code, setCode] = useState("");
	const [errorMessage, setErrorMessage] = useState<string | null>(null);

	const validateMutation = useMutation({
		mutationFn: async (couponCode: string) => {
			if (!couponCode.trim()) {
				throw new Error("Please enter a coupon code");
			}

			const result = await orpcClient.coupon.validate({
				body: {
					code: couponCode.trim().toUpperCase(),
					orderAmount,
				},
			});

			if (result.status !== 200) {
				throw new Error(result.body.message);
			}

			return result.body.data;
		},
		onSuccess: (data) => {
			queryClient.invalidateQueries();
			if (data.valid && data.coupon) {
				onCouponApplied(data.coupon, data.discountAmount);
				setErrorMessage(null);
				setCode("");
			} else {
				setErrorMessage(data.reason || "Invalid coupon code");
			}
		},
		onError: (error: Error) => {
			setErrorMessage(error.message);
		},
	});

	const handleApply = () => {
		setErrorMessage(null);
		validateMutation.mutate(code);
	};

	const handleRemove = () => {
		onCouponRemoved();
		setCode("");
		setErrorMessage(null);
	};

	const formatPrice = (price: number) => {
		return new Intl.NumberFormat("id-ID", {
			style: "currency",
			currency: "IDR",
			minimumFractionDigits: 0,
		}).format(price);
	};

	if (appliedCoupon) {
		return (
			<div className="space-y-2">
				<Label>Coupon Applied</Label>
				<div className="flex items-center gap-2 rounded-lg border border-green-200 bg-green-50 p-3">
					<div className="flex h-8 w-8 items-center justify-center rounded-full bg-green-100">
						<Check className="h-4 w-4 text-green-600" />
					</div>
					<div className="flex-1">
						<p className="font-medium text-sm">{appliedCoupon.name}</p>
						<p className="text-green-700 text-xs">
							Code: {appliedCoupon.code} • Discount:{" "}
							{formatPrice(discountAmount)}
						</p>
					</div>
					<Button
						variant="ghost"
						size="sm"
						onClick={handleRemove}
						disabled={disabled}
					>
						<X className="h-4 w-4" />
					</Button>
				</div>
			</div>
		);
	}

	return (
		<div className="space-y-2">
			<Label htmlFor="coupon">Have a coupon code?</Label>
			<div className="flex gap-2">
				<div className="relative flex-1">
					<Tag className="-translate-y-1/2 absolute top-1/2 left-3 h-4 w-4 text-muted-foreground" />
					<Input
						id="coupon"
						placeholder="Enter code"
						value={code}
						onChange={(e) => {
							setCode(e.target.value.toUpperCase());
							if (errorMessage) setErrorMessage(null);
						}}
						onKeyDown={(e) => {
							if (e.key === "Enter") {
								e.preventDefault();
								handleApply();
							}
						}}
						disabled={disabled || validateMutation.isPending}
						className={cn(
							"pl-10",
							errorMessage &&
								"border-destructive focus-visible:ring-destructive",
						)}
					/>
				</div>
				<Button
					onClick={handleApply}
					disabled={!code.trim() || disabled || validateMutation.isPending}
				>
					{validateMutation.isPending ? (
						<Loader2 className="h-4 w-4 animate-spin" />
					) : (
						"Apply"
					)}
				</Button>
			</div>
			{errorMessage && (
				<p className="text-destructive text-sm">{errorMessage}</p>
			)}
			<p className="text-muted-foreground text-xs">
				Enter a valid coupon code to get discount on your order
			</p>
		</div>
	);
}
