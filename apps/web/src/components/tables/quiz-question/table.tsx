import { m } from "@repo/i18n";
import { useQuery } from "@tanstack/react-query";
import type { VisibilityState } from "@tanstack/react-table";
import { useCallback, useEffect, useMemo, useState } from "react";
import { DataTable } from "@/components/tables/data-table";
import { useDebounce } from "@/hooks/use-debounce";
import { useIsMobile } from "@/hooks/use-mobile";
import { orpcQuery } from "@/lib/orpc";
import { DefaultPagination } from "../default-pagination";
import type { TableProps } from "../type";
import { QUIZ_QUESTION_COLUMNS } from "./columns";

interface Props extends TableProps {}

export const QuizQuestionTable = ({ search, to }: Props) => {
	const [filter, setFilter] = useState<string | undefined>(search.query);
	const debouncedFilter = useDebounce(filter ?? search.query, 500);

	const quizQuestions = useQuery(
		orpcQuery.driverQuizQuestion.list.queryOptions({
			input: {
				query: {
					...search,
					query: debouncedFilter?.trim() ?? search.query?.trim(),
				},
			},
		}),
	);

	const isMobile = useIsMobile();
	const [visibility, setVisibility] = useState<VisibilityState>({
		question: true,
		type: !isMobile,
		category: !isMobile,
		points: !isMobile,
		displayOrder: false,
		isActive: true,
		createdAt: !isMobile,
		actions: true,
	});

	const composeSearch = useCallback(
		(page: number) => ({ ...search, page, query: debouncedFilter }),
		[search, debouncedFilter],
	);

	const totalPages = useMemo(
		() => quizQuestions.data?.body.pagination?.totalPages || 1,
		[quizQuestions.data?.body.pagination?.totalPages],
	);

	useEffect(() => {
		if (isMobile) {
			setVisibility((prev) => ({
				...prev,
				type: false,
				category: false,
				points: false,
				createdAt: false,
			}));
		} else {
			setVisibility((prev) => ({
				...prev,
				type: true,
				category: true,
				points: true,
				createdAt: true,
			}));
		}
	}, [isMobile]);

	return (
		<div className="space-y-4">
			<DataTable
				columns={QUIZ_QUESTION_COLUMNS}
				data={quizQuestions.data?.body.data?.rows || []}
				isPending={quizQuestions.isPending}
				columnVisibility={visibility}
				setColumnVisibility={setVisibility}
				filterKeys={[m.question().toLowerCase()]}
				filterValue={filter}
				onFilterChange={setFilter}
			>
				<DefaultPagination
					search={search}
					to={to}
					composeSearch={composeSearch}
					totalPages={totalPages}
				/>
			</DataTable>
		</div>
	);
};
