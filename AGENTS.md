# Agent Development Guide

## Commands
`bun run check` (lint/format) | `turbo check-types` | `turbo build` | `turbo -F server|web build|dev` | `cd apps/mobile && flutter test [path.dart]` | `turbo -F server db:push`

## Style
Tabs, double quotes, auto-imports (Biome). Never `any`/`dynamic` (use `unknown`). camelCase (TS vars), PascalCase (classes), snake_case (Dart/DB). `@/*` paths.

## Server (oRPC + Drizzle)
**Routes**: `*-handler.ts` uses `createORPCRouter(Spec)→{pub,priv}` + `.use(hasPermission({resource:["action"]}))`. Always `trimObjectValues(body)`, Zod validation, `db.transaction()` for multi-ops.
**Repos**: Extend `BaseRepository`, use cache w/fallback, accept `opts?: PartialWithTx`. IDs: `v7()`, decimals: `toNumberSafe()`, errors: `throw new RepositoryError()`.

## Web (React)
TanStack Router+Query + Shadcn UI. Forms: `zodResolver`. Mutations: `orpcQuery.feature.method.mutationOptions()` + always `invalidateQueries()` after.

## Flutter
`BaseCubit<State>` (initial/loading/success/failure). Wrap API calls in `guard()`. Log errors: `logger.e()`. DI: GetIt. Never `dynamic`.

## Validation
Zod schemas from `@repo/schema`. Pattern: `InsertSchema = Schema.omit({id, createdAt, updatedAt})`, `UpdateSchema = InsertSchema.partial()`.
