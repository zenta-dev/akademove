import { m } from "@repo/i18n";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { BankSpec } from "./bank-spec";

const { pub } = createORPCRouter(BankSpec);

export const BankHandler = pub.router({
	validateAccount: pub.validateAccount.handler(
		async ({ context, input: { body } }) => {
			logger.debug(
				{ bankProvider: body.bankProvider },
				"[BankHandler] Validating bank account",
			);

			const result = await context.svc.bankValidation.validateBankAccount({
				bankProvider: body.bankProvider,
				accountNumber: body.accountNumber,
			});

			logger.info(
				{
					bankProvider: body.bankProvider,
					isValid: result.isValid,
					accountName: result.accountName,
				},
				"[BankHandler] Bank account validation completed",
			);

			return {
				status: 200,
				body: {
					message: result.isValid
						? m.server_bank_validation_success()
						: m.server_bank_validation_failed(),
					data: result,
				},
			};
		},
	),
});
