# Localization Guide for AkadeMove Web App

## Overview
This guide helps you complete the localization of all hardcoded strings in the web app.

## Progress

### ✅ Completed
- Added 200+ translation keys to `packages/i18n/messages/en.json` and `id.json`
- Rebuilt i18n package with new translations
- Updated account-deletion-form.tsx imports

### 🔄 In Progress
- Replacing hardcoded strings in components

## How to Localize a Component

### 1. Import i18n
```typescript
import { m } from "@repo/i18n";
```

### 2. Replace Hardcoded Strings

#### Simple strings:
```typescript
// Before:
<Button>Submit</Button>

// After:
<Button>{m.submit()}</Button>
```

#### Strings with variables:
```typescript
// Before:
<p>Welcome back, {name}!</p>

// After:
<p>{m.welcome_back_placeholder({ name })}</p>
```

#### Form validation messages:
```typescript
// Before:
const schema = z.object({
  email: z.string().email("Please enter a valid email"),
});

// After:
const createSchema = () => z.object({
  email: z.string().email(m.account_deletion_email_validation()),
});
```

## Files Needing Localization (Priority Order)

### High Priority (User-Facing)
1. ✅ `components/account-deletion-form.tsx` - PARTIAL (imports done, strings remaining)
2. `components/notification-banner.tsx`
3. `components/error-boundary.tsx`
4. `components/dialogs/rate-order.tsx`
5. `components/dialogs/withdraw-wallet.tsx`
6. `components/dialogs/order-detail.tsx`
7. `components/dialogs/report-user.tsx`
8. `routes/index.tsx` (Landing page)
9. `routes/(legal)/account-deletion.tsx`
10. `routes/(support)/contact.tsx`

### Medium Priority (Dashboard)
11. All `routes/dash/user/*` files
12. All `routes/dash/driver/*` files
13. All `routes/dash/merchant/*` files
14. All `routes/dash/operator/*` files
15. All `routes/dash/admin/*` files

### Lower Priority (Internal/Admin)
16. Table components in `components/tables/*`
17. Configuration components in `components/admin/configuration/*`

## Available Translation Keys

All translation keys are now available in the i18n package. Key patterns:

### Account Deletion
- `account_deletion_*` (validation, labels, descriptions, warnings, etc.)

### Notifications
- `notification_*`

### Errors
- `error_*`, `error_fallback_*`

### Tracking/Maps
- `tracking_*`, `map_*`

### Orders
- `order_detail_*`, `rate_order_*`

### Wallet
- `withdraw_wallet_*`

### Reports
- `report_user_*`

## Testing

After updating a component:

1. Start the dev server:
```bash
bun run dev:web
```

2. Test in both languages:
   - Switch language in the app
   - Verify all strings translate correctly
   - Check for any missing translations

3. Check for TypeScript errors:
```bash
cd apps/web && npx tsc --noEmit
```

## Common Patterns

### Toast Messages
```typescript
// Before:
toast.success("Success!");
toast.error("Error occurred");

// After:
toast.success(m.success_message());
toast.error(m.error_message());
```

### Button States
```typescript
// Before:
{isSubmitting ? "Submitting..." : "Submit"}

// After:
{isSubmitting ? m.submitting() : m.submit()}
```

### Form Labels
```typescript
// Before:
<FormLabel>Email Address *</FormLabel>

// After:
<FormLabel>{m.email_address()}</FormLabel>
```

### Placeholders
```typescript
// Before:
<Input placeholder="Enter your name" />

// After:
<Input placeholder={m.your_name()} />
```

## Adding New Translations

If you need a translation key that doesn't exist:

1. Add it to both `packages/i18n/messages/en.json` and `id.json`:

```json
{
  "my_new_key": "My English translation",
  ...
}
```

2. Rebuild the i18n package:
```bash
cd packages/i18n && bun run build
```

3. Use it in your component:
```typescript
m.my_new_key()
```

## Tips

1. **Use descriptive key names** that indicate where they're used (e.g., `account_deletion_email_label`)
2. **Keep translations concise** - avoid overly long keys
3. **Test both languages** before committing
4. **Don't translate**:
   - API endpoints
   - Error codes
   - Technical identifiers
   - Email addresses
5. **Do translate**:
   - All user-visible text
   - Form labels and placeholders
   - Validation messages
   - Button text
   - Toast notifications
   - Descriptions and help text

## Example: Complete Component Update

See `apps/web/src/components/account-deletion-form.tsx` for a reference implementation (partial).

## Questions?

Check the existing translated components for examples:
- `components/dialogs/sign-up-dialog.tsx`
- `components/dialogs/ban-user.tsx`
- `components/dialogs/invite-user.tsx`
