import { zodResolver } from "@hookform/resolvers/zod";
import { m } from "@repo/i18n";
import { createDefaults } from "@repo/schema/default.helper";
import { type InviteUser, InviteUserSchema } from "@repo/schema/user";
import { capitalizeFirstLetter, ROLES_TYPED } from "@repo/shared";
import { useMutation } from "@tanstack/react-query";
import { useRouter } from "@tanstack/react-router";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { toast } from "sonner";
import { Submitting } from "@/components/misc/submitting";
import { Button } from "@/components/ui/button";
import {
	Dialog,
	DialogClose,
	DialogContent,
	DialogDescription,
	DialogFooter,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog";
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
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { orpcQuery, queryClient } from "@/lib/orpc";

function randomPhoneNumber() {
	return {
		countryCode: "ID",
		number: Math.floor(Math.random() * 1000000000),
	} as const;
}

export const InviteUserDialog = () => {
	const router = useRouter();
	const [open, setOpen] = useState(false);
	const [_showPassword, _setShowPassword] = useState(false);
	const [_showConfirmPassword, _setShowConfirmPassword] = useState(false);
	const form = useForm({
		resolver: zodResolver(InviteUserSchema),
		defaultValues: createDefaults(InviteUserSchema, {
			overrides: {
				role: "USER",
				gender: undefined,
				phone: randomPhoneNumber(),
			},
		}),
	});

	const mutation = useMutation(
		orpcQuery.user.admin.create.mutationOptions({
			onSuccess: async () => {
				await Promise.all([
					queryClient.invalidateQueries(),
					router.invalidate(),
				]);
				toast.success(m.success_placeholder({ action: m.invite_user() }));
				setOpen(false);
				form.setValue("name", "");
				form.setValue("email", "");
				form.setValue("role", "USER");
				form.clearErrors();
			},
			onError: (error: Error) => {
				toast.error(
					m.failed_placeholder({
						action: capitalizeFirstLetter(m.invite_user().toLowerCase()),
					}),
					{
						description: error.message || m.an_unexpected_error_occurred(),
					},
				);
				if (error.message.toLowerCase().includes("email")) {
					form.setError("email", { message: error.message });
				}
			},
		}),
	);

	const onSubmit = async (values: InviteUser) => {
		await mutation.mutateAsync({ body: values });
	};

	return (
		<Dialog open={open} onOpenChange={() => setOpen(!open)}>
			<DialogTrigger asChild>
				<Button>{m.invite_user()}</Button>
			</DialogTrigger>
			<DialogContent>
				<DialogHeader>
					<DialogTitle>{m.invite_user()}</DialogTitle>
					<DialogDescription>{m.invite_user_desc()}</DialogDescription>
				</DialogHeader>
				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="mt-4 space-y-4"
					>
						<FormField
							control={form.control}
							name="name"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.name()}</FormLabel>
									<FormControl>
										<Input
											placeholder="John Doe"
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="role"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.role()}</FormLabel>
									<Select
										onValueChange={field.onChange}
										defaultValue={field.value}
									>
										<FormControl>
											<SelectTrigger className="w-full">
												<SelectValue />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											{ROLES_TYPED.map((e) => (
												<SelectItem key={e.id} value={e.id}>
													{e.name}
												</SelectItem>
											))}
										</SelectContent>
									</Select>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="email"
							render={({ field }) => (
								<FormItem>
									<FormLabel>{m.email()}</FormLabel>
									<FormControl>
										<Input
											placeholder="johndoe@gmail.com"
											disabled={mutation.isPending}
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<DialogFooter>
							<DialogClose asChild>
								<Button variant="outline">{m.cancel()}</Button>
							</DialogClose>

							<Button type="submit" disabled={mutation.isPending}>
								{mutation.isPending ? <Submitting /> : m.invite_user()}
							</Button>
						</DialogFooter>
					</form>
				</Form>
			</DialogContent>
		</Dialog>
	);
};
