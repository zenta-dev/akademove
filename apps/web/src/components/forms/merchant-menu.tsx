import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import {
	InsertMerchantMenuSchema,
	type MerchantMenu,
	UpdateMerchantMenuSchema,
} from "@repo/schema/merchant";
import { capitalizeFirstLetter } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { X } from "lucide-react";
import { useCallback, useEffect, useMemo, useState } from "react";
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
import {
	Dropzone,
	DropzoneContent,
	DropzoneEmptyState,
} from "@/components/ui/shadcn-io/dropzone";
import type { ActionKind } from "@/lib/interface";
import { orpcQuery, queryClient } from "@/lib/orpc";
import { cn } from "@/utils/cn";
import { createPhotoPreviewUrl } from "@/utils/file";

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
	const [imagePreview, setImagePreview] = useState<string | undefined>(
		data?.image,
	);
	const form = useForm({
		resolver: zodResolver(
			kind === "new" ? InsertMerchantMenuSchema : UpdateMerchantMenuSchema,
		),
		defaultValues:
			kind === "edit" && data
				? { ...data, image: undefined }
				: {
						image: undefined,
						name: "",
						price: 0,
						stock: 0,
						category: "",
					},
	});

	const _onSuccess = useCallback(
		async (kind: "insert" | "update") => {
			await queryClient.invalidateQueries({
				queryKey: orpcQuery.merchant.menu.list.queryKey({
					input: { params: { merchantId }, query: { limit: 10 } },
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
			setImagePreview(undefined);
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
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
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
					toast.error("Validation failed", {
						description: parse.error.issues
							.map((e: { message: string }) => e.message)
							.join(", "),
					});
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
	useEffect(() => {
		if (kind === "edit" && data) {
			form.reset({
				...data,
				image: undefined,
			});
			setImagePreview(data.image);
		}
	}, [kind, data, form]);

	return (
		<Form {...form}>
			<form
				onSubmit={form.handleSubmit(onSubmit)}
				className="grid grid-cols-1 gap-4"
			>
				<FormField
					control={form.control}
					name="image"
					render={({ field }) => (
						<FormItem>
							<FormLabel>{m.image()}</FormLabel>
							<FormControl>
								<div className="relative mx-auto h-48 w-48 overflow-hidden rounded-md">
									<Button
										type="button"
										variant="ghost"
										size="icon"
										className="absolute top-2 right-2 z-10"
										onClick={() => {
											field.onChange(undefined);
											setImagePreview(undefined);
										}}
									>
										<X />
										<span className="sr-only">{m.remove_file()}</span>
									</Button>

									<Dropzone
										accept={{
											"image/jpeg": [".jpeg", ".jpg"],
											"image/png": [".png"],
										}}
										onDrop={(files) => {
											if (files.length > 0) {
												createPhotoPreviewUrl(files, {
													onSuccess: setImagePreview,
												});
												field.onChange(files[0]);
											}
										}}
										onError={(err) => {
											form.setError("image", { message: err.message });
										}}
										src={
											field.value
												? [field.value]
												: data?.image !== undefined && kind === "edit"
													? []
													: undefined
										}
										className={cn(
											"relative z-0 h-48 w-48",
											field.value && "p-0",
										)}
									>
										<DropzoneEmptyState />
										<DropzoneContent>
											{imagePreview && (
												<div className="relative h-48 w-48">
													<img
														alt="Preview"
														src={imagePreview}
														className="absolute inset-0 h-full w-full object-cover"
													/>
												</div>
											)}
										</DropzoneContent>
									</Dropzone>
								</div>
							</FormControl>

							<FormMessage />
						</FormItem>
					)}
				/>
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
