import type {
	DriverMinQuizQuestion,
	DriverQuizQuestion,
	InsertDriverQuizQuestion,
	ListDriverQuizQuestionQuery,
	UpdateDriverQuizQuestion,
} from "@repo/schema/driver-quiz-question";
import { eq, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, PartialWithTx, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { DriverQuizQuestionDatabase } from "@/core/tables/driver-quiz-question";
import { log } from "@/utils";

export class DriverQuizQuestionRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("driverQuizQuestion", kv, db);
	}

	static composeEntity(item: DriverQuizQuestionDatabase): DriverQuizQuestion {
		return {
			...item,
			explanation: item.explanation ?? null,
		};
	}

	async #getFromDB(
		id: string,
		opts?: PartialWithTx,
	): Promise<DriverQuizQuestion | undefined> {
		const tx = opts?.tx ?? this.db;
		const result = await tx.query.driverQuizQuestion.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? DriverQuizQuestionRepository.composeEntity(result)
			: undefined;
	}

	async list(
		query: ListDriverQuizQuestionQuery,
		opts?: PartialWithTx,
	): Promise<ListResult<DriverQuizQuestion>> {
		try {
			const {
				category,
				type,
				isActive,
				page = 1,
				limit = 20,
				query: search,
			} = query;
			const tx = opts?.tx ?? this.db;

			const conditions: SQL[] = [];
			if (category) {
				conditions.push(eq(tables.driverQuizQuestion.category, category));
			}
			if (type) {
				conditions.push(eq(tables.driverQuizQuestion.type, type));
			}
			if (isActive !== undefined) {
				conditions.push(eq(tables.driverQuizQuestion.isActive, isActive));
			}

			if (search) {
				conditions.push(
					ilike(
						tables.driverQuizQuestion.question,
						`%${search.trim().replace(/%/g, "\\%")}%`,
					),
				);
			}

			const offset = (page - 1) * limit;

			const res = await tx.query.driverQuizQuestion.findMany({
				where: (_, op) =>
					conditions.length > 0 ? op.and(...conditions) : undefined,
				orderBy: (f, op) => [op.asc(f.displayOrder), op.desc(f.createdAt)],
				offset,
				limit,
			});

			const rows = res.map(DriverQuizQuestionRepository.composeEntity);
			const totalCount = await this.getTotalRow(opts);
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, totalPages };
		} catch (error) {
			log.error(
				{ error, query },
				"[DriverQuizQuestionRepository] Failed to list questions",
			);
			throw this.handleError(error, "list");
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<DriverQuizQuestion> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);

				if (!res) {
					throw new RepositoryError("Driver quiz question not found", {
						code: "NOT_FOUND",
					});
				}

				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });

				return res;
			};

			return await this.getCache(id, { fallback });
		} catch (error) {
			log.error(
				{ error, id },
				"[DriverQuizQuestionRepository] Failed to get question",
			);
			throw this.handleError(error, "get");
		}
	}

	async create(
		data: InsertDriverQuizQuestion,
		opts: WithTx,
	): Promise<DriverQuizQuestion> {
		try {
			const now = new Date();
			const id = v7();

			const [res] = await opts.tx
				.insert(tables.driverQuizQuestion)
				.values({
					id,
					question: data.question,
					type: data.type,
					category: data.category,
					options: data.options,
					explanation: data.explanation ?? null,
					points: data.points ?? 10,
					isActive: data.isActive ?? true,
					displayOrder: data.displayOrder ?? 0,
					createdAt: now,
					updatedAt: now,
				})
				.returning();

			log.info(
				{ questionId: res.id },
				"[DriverQuizQuestionRepository] Question created",
			);

			return DriverQuizQuestionRepository.composeEntity(res);
		} catch (error) {
			log.error(
				{ error, data },
				"[DriverQuizQuestionRepository] Failed to create question",
			);
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		data: UpdateDriverQuizQuestion,
		opts: WithTx,
	): Promise<DriverQuizQuestion> {
		try {
			await this.get(id, opts);

			const [res] = await opts.tx
				.update(tables.driverQuizQuestion)
				.set({
					...data,
					updatedAt: new Date(),
				})
				.where(eq(tables.driverQuizQuestion.id, id))
				.returning();

			if (!res) {
				throw new RepositoryError("Driver quiz question not found", {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);

			log.info(
				{ questionId: id },
				"[DriverQuizQuestionRepository] Question updated",
			);

			return DriverQuizQuestionRepository.composeEntity(res);
		} catch (error) {
			log.error(
				{ error, id, data },
				"[DriverQuizQuestionRepository] Failed to update question",
			);
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string, opts: WithTx): Promise<void> {
		try {
			const [res] = await opts.tx
				.delete(tables.driverQuizQuestion)
				.where(eq(tables.driverQuizQuestion.id, id))
				.returning();

			if (!res) {
				throw new RepositoryError("Driver quiz question not found", {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);

			log.info(
				{ questionId: id },
				"[DriverQuizQuestionRepository] Question deleted",
			);
		} catch (error) {
			log.error(
				{ error, id },
				"[DriverQuizQuestionRepository] Failed to delete question",
			);
			throw this.handleError(error, "remove");
		}
	}

	/**
	 * Get random questions for quiz taking (hides correct answers)
	 */
	async getQuizQuestions(
		query: { category?: string; limit?: number },
		opts?: PartialWithTx,
	): Promise<Array<DriverMinQuizQuestion>> {
		try {
			const { category, limit = 20 } = query;
			const tx = opts?.tx ?? this.db;

			const conditions: SQL[] = [eq(tables.driverQuizQuestion.isActive, true)];

			if (category) {
				conditions.push(
					eq(
						tables.driverQuizQuestion.category,
						category as (typeof tables.driverQuizQuestion.category.enumValues)[number],
					),
				);
			}

			const res = await tx.query.driverQuizQuestion.findMany({
				where: (_, op) => op.and(...conditions),
				orderBy: (f, op) => [op.asc(f.displayOrder)],
				limit,
			});

			// Map to hide correct answers
			return res.map((q) => ({
				id: q.id,
				question: q.question,
				type: q.type,
				category: q.category,
				points: q.points,
				displayOrder: q.displayOrder,
				options: q.options.map((o) => ({
					id: o.id,
					text: o.text,
				})),
			}));
		} catch (error) {
			log.error(
				{ error, query },
				"[DriverQuizQuestionRepository] Failed to get quiz questions",
			);
			throw this.handleError(error, "getQuizQuestions");
		}
	}
}
