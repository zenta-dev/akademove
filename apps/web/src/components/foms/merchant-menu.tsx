import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	InsertMerchantMenuSchema,
	type MerchantMenu,
	UpdateMerchantMenuSchema,
} from "@repo/schema/merchant";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useCallback, useMemo } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import {
	Form,
	FormControl,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import type { ActionKind } from "@/lib/interface";
import { orpcQuery, queryClient } from "@/lib/orpc";

export type MerchantMenuFormProps = {
	kind: ActionKind;
	merchantId: string;
	data?: MerchantMenu;
	onSuccess?: () => void;
};

export const MerchantMenuForm = ({
	kind,
	merchantId,
	data,
	onSuccess,
}: MerchantMenuFormProps) => {
	const form = useForm({
		resolver: zodResolver(
			kind === "new" ? InsertMerchantMenuSchema : UpdateMerchantMenuSchema,
		),
		defaultValues:
			kind === "edit" && data
				? data
				: {
						name: "",
						merchantId,
						price: 0,
						stock: 0,
						category: "",
					},
	});

	const _onSuccess = useCallback(
		async (kind: "insert" | "update") => {
			await queryClient.invalidateQueries({
				queryKey: orpcQuery.merchant.menu.list.queryKey({
					input: { params: { merchantId }, query: {} },
				}),
			});
			toast.success(
				m.success_placeholder({
					action: capitalizeFirstLetter(
						(kind === "insert"
							? m.create_menu()
							: m.update_menu()
						).toLowerCase(),
					),
				}),
			);
			form.reset();
			onSuccess?.();
		},
		[form.reset, onSuccess, merchantId],
	);

	const onError = useCallback((kind: "insert" | "update", error: Error) => {
		toast.error(
			m.failed_placeholder({
				action: capitalizeFirstLetter(
					(kind === "insert" ? m.create_menu() : m.update_menu()).toLowerCase(),
				),
			}),
			{
				description: error.message || m.an_unexpected_error_occurred(),
			},
		);
	}, []);

	const insertMutation = useMutation(
		orpcQuery.merchant.menu.create.mutationOptions({
			onSuccess: () => _onSuccess("insert"),
			onError: (error) => onError("insert", error),
		}),
	);

	const updateMutation = useMutation(
		orpcQuery.merchant.menu.update.mutationOptions({
			onSuccess: () => _onSuccess("update"),
			onError: (error) => onError("update", error),
		}),
	);

	const onSubmit = useCallback(
		async (values: unknown) => {
			if (kind === "new") {
				const parse = InsertMerchantMenuSchema.safeParse(values);
				if (parse.success) {
					await insertMutation.mutateAsync({
						params: { merchantId },
						body: parse.data,
					});
				} else {
					console.error("Validation errors:", parse.error);
				}
			}

			if (kind === "edit" && data) {
				const parse = UpdateMerchantMenuSchema.safeParse(values);
				if (parse.success) {
					await updateMutation.mutateAsync({
						params: { id: data.id, merchantId },
						body: parse.data,
					});
				} else {
					console.error("Validation errors:", parse.error);
				}
			}
		},
		[data, insertMutation, updateMutation, kind, merchantId],
	);

	const isLoading = useMemo(
		() =>
			kind === "new" ? insertMutation.isPending : updateMutation.isPending,
		[kind, insertMutation.isPending, updateMutation.isPending],
	);

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit(onSubmit)}
				className="grid grid-cols-1 gap-4"
			>
				<FormField
					control={form.control}
					name="name"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.name()}</FormLabel>
							<FormControl>
								<Input
									placeholder="Crazy Fried Rice"
									disabled={isLoading}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="price"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.price()}</FormLabel>
							<FormControl>
								<Input
									placeholder="5000"
									type="number"
									disabled={isLoading}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="stock"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.stock()}</FormLabel>
							<FormControl>
								<Input
									placeholder="100"
									type="number"
									disabled={isLoading}
									{...field}
								/>
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<FormField
					control={form.control}
					name="category"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.category()}</FormLabel>
							<FormControl>
								<Input placeholder="Food" disabled={isLoading} {...field} />
							</FormControl>
							<FormMessage />
						</FormItem>
					)}
				/>
				<Button type="submit" disabled={isLoading} className="w-full">
					{isLoading ? (
						<Submitting />
					) : kind === "new" ? (
						m.create_menu()
					) : (
						m.update_menu()
					)}
				</Button>
			</form>
		</Form>
	);
};
