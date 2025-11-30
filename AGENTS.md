# Agent Development Guide - Akademove

## 🏗️ Architecture
**Monorepo**: Turbo + Bun workspaces. **Server**: Cloudflare Workers (Hono + oRPC + Drizzle ORM + PostgreSQL). **Web**: React 19 + TanStack Router/Query + Shadcn UI. **Mobile**: Flutter + BLoC + GetIt DI. **Packages**: `@repo/schema` (Zod), `@repo/shared` (utils), `@repo/i18n` (translations).

## 🚀 Commands
**Lint/Format**: `bun run check` (Biome auto-fix). **Type Check**: `turbo check-types`. **Build All**: `turbo build`. **Dev Server**: `turbo -F server dev` or `bun run dev:server`. **Dev Web**: `turbo -F web dev` or `bun run dev:web`. **Flutter Test (Single)**: `cd apps/mobile && flutter test test/path/to/test_file.dart`. **Flutter Test (All)**: `cd apps/mobile && flutter test`. **DB Push**: `turbo -F server db:push` or `bun run db:push`. **DB Studio**: `bun run db:studio`. **DB Generate Migration**: `turbo -F server db:generate`. **Melos Commands**: `melos generate`, `melos analyze`, `melos fix`, `melos format`.

## 📝 Code Style
**Formatting**: Tabs (indentStyle), double quotes (Biome enforced). **Imports**: Auto-organize imports (Biome). Use `@/*` path aliases (e.g., `@/core/services/db`). Import from `@repo/schema`, `@repo/shared`. **Types**: NEVER use `any` (TypeScript) or `dynamic` (Dart) - use `unknown` instead. Enable strict mode. **Naming**: camelCase for TS/JS variables, PascalCase for classes/components, snake_case for Dart/database columns. **File Naming**: kebab-case for all files (e.g., `order-handler.ts`, `order_cubit.dart`).

## 🔧 TypeScript/Server Patterns

### Route Handlers (`*-handler.ts`)
1. Import spec: `import { FeatureSpec } from "./feature-spec"`
2. Create router: `const { pub, priv } = createORPCRouter(FeatureSpec)`
3. Use middleware: `.use(hasPermission({ resource: ["action"] }))`
4. Always trim input: `trimObjectValues(body)` before processing
5. Wrap mutations in transactions: `context.svc.db.transaction(async (tx) => { ... })`
6. Return structured responses: `{ status: 200, body: { message: "...", data: result } }`

**Example**:
```typescript
export const OrderHandler = priv.router({
  placeOrder: priv.placeOrder
    .use(hasPermission({ order: ["create"] }))
    .handler(async ({ context, input: { body } }) => {
      return await context.svc.db.transaction(async (tx) => {
        const data = trimObjectValues(body);
        const result = await context.repo.order.placeOrder({ ...data, userId: context.user.id }, { tx });
        return { status: 200, body: { message: "Order placed", data: result } };
      });
    }),
});
```

### Repository Layer (`*-repository.ts`)
1. Extend `BaseRepository` from `@/core/base`
2. Accept `opts?: PartialWithTx` or `opts: WithTx` for all DB methods
3. Use `opts.tx ?? this.db` for queries to support transactions
4. Generate IDs with `v7()` from `uuid`
5. Handle decimals with `toNumberSafe()` / `toStringNumberSafe()` from `@/utils`
6. Throw errors: `throw new RepositoryError("message", { code: "BAD_REQUEST" })`
7. Use cache with fallback: `await this.getCache(key, { fallback: async () => { ... } })`
8. Set cache with TTL: `await this.setCache(key, value, { expirationTtl: CACHE_TTLS["1h"] })`
9. Log with context: `log.info({ userId, orderId }, "[RepoName] Action description")`

**Example**:
```typescript
export class OrderRepository extends BaseRepository {
  async get(id: string, opts?: WithTx): Promise<Order> {
    try {
      const fallback = async () => {
        const res = await (opts?.tx ?? this.db).query.order.findFirst({
          where: (f, op) => op.eq(f.id, id),
        });
        if (!res) throw new RepositoryError("Order not found", { code: "NOT_FOUND" });
        await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
        return OrderRepository.composeEntity(res);
      };
      return await this.getCache(id, { fallback });
    } catch (error) {
      throw this.handleError(error, "get by id");
    }
  }
}
```

### Error Handling
1. Use try-catch in all async methods
2. Log errors with context: `log.error({ error, userId }, "[ClassName] Operation failed")`
3. Re-throw to trigger transaction rollback
4. Use typed errors: `RepositoryError`, `BaseError`
5. Include error codes: `{ code: "BAD_REQUEST" | "NOT_FOUND" | "INTERNAL_SERVER_ERROR" }`

### Database & Transactions
1. All write operations MUST be in transactions: `context.svc.db.transaction(async (tx) => { ... })`
2. Pass `{ tx }` to all repository calls within a transaction
3. Use Drizzle ORM query builder: `tx.query.table.findFirst({ ... })`
4. Index commonly queried fields (see `src/core/tables/*.ts`)
5. Use composite indexes for multi-column filters
6. Add text pattern indexes for ILIKE searches: `index().on(column.op("text_pattern_ops"))`

## ⚛️ React/Web Patterns

### Components
1. Use Shadcn UI components from `@/components/ui/*`
2. Form validation: `zodResolver` from `@hookform/resolvers/zod`
3. Use `react-hook-form` for all forms
4. Toast notifications: `import { toast } from "sonner"`

### Data Fetching & Mutations
1. Import client: `import { orpcClient, orpcQuery, queryClient } from "@/lib/orpc"`
2. Queries: Use TanStack Query hooks directly with `orpcClient`
3. Mutations: Use `orpcQuery.feature.method.mutationOptions({ ... })`
4. ALWAYS invalidate queries after mutations: `queryClient.invalidateQueries({ queryKey: [...] })`

**Example**:
```typescript
const mutation = useMutation(
  orpcQuery.order.placeOrder.mutationOptions({
    mutationFn: async (data) => {
      const result = await orpcClient.order.placeOrder(data);
      if (result.status !== 200) throw new Error(result.body.message);
      return result;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["orders"] });
      toast.success("Order placed successfully");
    },
  })
);
```

### Routing
1. Use TanStack Router file-based routing in `src/routes/`
2. Route files: `route.tsx` for route components
3. Loaders for data fetching: `export const Route = createFileRoute("/path")({ loader: async () => { ... } })`

## 📱 Flutter/Dart Patterns

### Architecture
1. Feature-based structure: `lib/features/{feature}/*`
2. Each feature has: `cubit`, `repository`, `view`, `widgets`
3. Use BLoC pattern with `BaseCubit<State>`
4. Dependency injection with GetIt: `sl<Service>()`

### Cubits (State Management)
1. Extend `BaseCubit<FeatureState>` from `@/core/*`
2. Define sealed states: `initial`, `loading`, `success(data)`, `failure(error)`
3. Wrap API calls in `guard()` for error handling
4. Log errors: `logger.e("message", error: e, stackTrace: st)`
5. Use `emit()` to update state
6. NEVER use `dynamic` - use proper types or `Object?`

**Example**:
```dart
class OrderCubit extends BaseCubit<OrderState> {
  OrderCubit({required this.orderRepository}) : super(OrderState.initial());
  
  final OrderRepository orderRepository;
  
  Future<void> placeOrder(PlaceOrderRequest request) async {
    emit(OrderState.loading());
    await guard(
      () async {
        final order = await orderRepository.placeOrder(request);
        emit(OrderState.success(order));
      },
      onError: (e, st) {
        logger.e('Failed to place order', error: e, stackTrace: st);
        emit(OrderState.failure(e.toString()));
      },
    );
  }
}
```

### Testing
1. Place tests in `test/` mirroring `lib/` structure
2. Use `bloc_test` for cubit testing
3. Use `mocktail` for mocking dependencies
4. Run single test: `cd apps/mobile && flutter test test/features/order/cubit/order_cubit_test.dart`
5. Run all tests: `cd apps/mobile && flutter test`

## 📦 Schema & Validation

### Zod Schemas
1. Define in `packages/schema/src/*.ts`
2. Export schema + inferred type: `export const Schema = z.object({ ... }); export type Type = z.infer<typeof Schema>;`
3. Create variants: `InsertSchema = Schema.omit({ id: true, createdAt: true, updatedAt: true })`
4. Update schemas: `UpdateSchema = InsertSchema.partial()`
5. Use in handlers: Zod validates automatically via oRPC spec

**Example**:
```typescript
export const OrderSchema = z.object({
  id: z.string().uuid(),
  userId: z.string(),
  type: OrderTypeSchema,
  status: OrderStatusSchema,
  totalPrice: z.coerce.number(),
  createdAt: z.date(),
  updatedAt: z.date(),
});

export const InsertOrderSchema = OrderSchema.omit({ id: true, createdAt: true, updatedAt: true });
export const UpdateOrderSchema = InsertOrderSchema.partial();
```

## 🎯 Best Practices

### Performance
1. Cache frequently accessed data with appropriate TTL (`CACHE_TTLS["5m"]`, `["1h"]`, `["24h"]`)
2. Use database indexes for filtered/sorted columns
3. Batch database queries with `Promise.all()`
4. Use cursor pagination for large lists when possible

### Security
1. Always validate input with Zod schemas
2. Use `trimObjectValues()` to sanitize string inputs
3. Check permissions with `hasPermission()` middleware
4. Never expose sensitive data in API responses
5. Use environment variables for secrets (never commit `.env`)

### Logging
1. Use structured logging: `log.info({ userId, orderId }, "Action description")`
2. Log levels: `log.debug()`, `log.info()`, `log.warn()`, `log.error()`
3. Include error context: `log.error({ error, userId }, "Failed to ...")`

### Code Organization
1. Keep handlers thin - business logic in repositories
2. Reuse code via shared packages (`@repo/schema`, `@repo/shared`)
3. Feature-based folder structure (group by feature, not by type)
4. Co-locate related files (handler, repository, spec in same feature folder)

## 🗄️ Database Patterns

### Migrations
1. Generate migration: `bun run db:generate` (after schema changes)
2. Review generated SQL in `apps/server/drizzle/migrations/*.sql`
3. Apply migration: `bun run db:push`
4. Never edit migrations manually - modify table schemas in `src/core/tables/*.ts`

### Table Definitions
1. Define in `apps/server/src/core/tables/*.ts`
2. Use `pgTable("table_name", { ... }, (t) => [indexes])`
3. Add indexes for: foreign keys, status columns, commonly filtered/sorted columns
4. Use composite indexes for multi-column queries: `index().on(col1, col2)`
5. Use text pattern indexes for text searches: `index().on(col.op("text_pattern_ops"))`

## 🧪 Testing Guidelines
**Server**: Add tests when implementing complex business logic. **Web**: Focus on integration tests for critical flows. **Mobile**: Test cubits with `bloc_test`, mock repositories with `mocktail`. **Coverage**: Aim for >70% on critical business logic.

## 🔄 Git Workflow
1. Create feature branch: `git checkout -b feature/description`
2. Commit with conventional commits: `feat:`, `fix:`, `chore:`, etc.
3. Pre-commit hook runs `biome check` and `melos fix/format` automatically
4. Keep commits focused and atomic

## 📚 Key Files
- **Server Entry**: `apps/server/src/index.ts`
- **Web Entry**: `apps/web/src/main.tsx`
- **Mobile Entry**: `apps/mobile/lib/main.dart`
- **Schemas**: `packages/schema/src/*.ts`
- **Shared Utils**: `packages/shared/src/*.ts`
- **DB Tables**: `apps/server/src/core/tables/*.ts`
- **Constants**: `apps/server/src/core/constants.ts`

## ⚠️ Common Pitfalls
1. ❌ Forgetting `db.transaction()` for write operations
2. ❌ Not passing `{ tx }` to repository methods inside transactions
3. ❌ Using `any`/`dynamic` types instead of `unknown`
4. ❌ Forgetting to invalidate queries after mutations
5. ❌ Not handling errors with try-catch
6. ❌ Missing cache invalidation after updates
7. ❌ Not logging errors with context
8. ❌ Forgetting to trim input values with `trimObjectValues()`
9. ❌ Not using `toNumberSafe()`/`toStringNumberSafe()` for decimals
10. ❌ Missing indexes on filtered/sorted database columns

## 🚨 Critical Rules
- **NEVER** use `any` (TS) or `dynamic` (Dart)
- **ALWAYS** wrap multi-step mutations in `db.transaction()`
- **ALWAYS** invalidate queries after mutations
- **ALWAYS** validate input with Zod schemas
- **ALWAYS** handle errors with try-catch + logging
- **ALWAYS** use structured logging with context
- **ALWAYS** pass `opts?: PartialWithTx` to repository methods
- **ALWAYS** use `v7()` for generating UUIDs
- **ALWAYS** check for null/undefined before accessing properties
