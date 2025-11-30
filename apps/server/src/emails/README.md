# Email Service Documentation

Modern email service for AkadeMove using React Email + Tailwind-inspired styling.

## Features

- ✨ **Modern UI**: Beautiful, responsive email templates with Tailwind-inspired design
- 🎨 **Reusable Base Layout**: Consistent branding with header and footer
- 📧 **React Email**: Type-safe templates using React components
- 🚀 **Resend Integration**: Reliable email delivery via Resend API
- 📝 **Pre-built Templates**: Reset password, invitations, order confirmations

## Directory Structure

```
src/emails/
├── components/
│   └── base-layout.tsx        # Reusable base layout with branding
├── templates/
│   ├── reset-password.tsx     # Password reset email
│   ├── invitation.tsx         # User invitation email
│   └── order-confirmation.tsx # Order confirmation email
├── email-service.ts           # Email rendering and sending service
└── index.ts                   # Exports
```

## Usage

### Using Pre-built Templates

The mail service at `src/core/services/mail.ts` already integrates React Email templates:

```typescript
import { MailService } from '@/core/services/mail';

// Inject via dependency injection
const mailService = context.svc.mail;

// Send password reset
await mailService.sendResetPassword({
  to: 'user@example.com',
  url: 'https://app.akademove.com/reset-password?token=...',
  userName: 'John Doe',
});

// Send invitation
await mailService.sendInvitation({
  to: 'newuser@example.com',
  email: 'newuser@example.com',
  password: 'temp123',
  role: 'Driver',
});
```

### Creating Custom Templates

Create a new template file in `src/emails/templates/`:

```tsx
/** @jsxImportSource react */
import { Button, Heading, Text, Section } from '@react-email/components';
import * as React from 'react';
import { BaseLayout } from '../components/base-layout';

interface WelcomeEmailProps {
  userName: string;
  actionUrl: string;
}

export const WelcomeEmail = ({ userName, actionUrl }: WelcomeEmailProps) => {
  return (
    <BaseLayout preview="Welcome to AkadeMove!">
      <Section>
        <Heading style={h1}>Welcome {userName}!</Heading>
        <Text style={text}>
          We're excited to have you on board.
        </Text>
        <Button style={button} href={actionUrl}>
          Get Started
        </Button>
      </Section>
    </BaseLayout>
  );
};

const h1 = { /* styles */ };
const text = { /* styles */ };
const button = { /* styles */ };
```

### Using the Email Service Directly

For advanced use cases, use the email service directly:

```typescript
/** @jsxImportSource react */
import * as React from 'react';
import { createEmailService } from '@/emails';
import { WelcomeEmail } from '@/emails/templates/welcome';

const emailService = createEmailService();

// Send custom email
await emailService.send(
  React.createElement(WelcomeEmail, {
    userName: 'John Doe',
    actionUrl: 'https://app.akademove.com/onboarding',
  }),
  {
    to: 'user@example.com',
    subject: 'Welcome to AkadeMove!',
    from: 'AkadeMove <no-reply@mail.akademove.com>',
  }
);

// Render to HTML (for testing/preview)
const html = await emailService.render(
  React.createElement(WelcomeEmail, { userName: 'John', actionUrl: '...' })
);
```

## Available Templates

### 1. Reset Password Email
**File**: `reset-password.tsx`

```typescript
<ResetPasswordEmail 
  userName="John Doe"
  resetUrl="https://app.akademove.com/reset?token=..."
/>
```

### 2. Invitation Email
**File**: `invitation.tsx`

```typescript
<InvitationEmail
  email="user@example.com"
  password="tempPassword123"
  role="Driver"
  loginUrl="https://app.akademove.com/sign-in"
/>
```

### 3. Order Confirmation Email
**File**: `order-confirmation.tsx`

```typescript
<OrderConfirmationEmail
  userName="John Doe"
  orderId="ORD-12345"
  orderType="RIDE"
  orderDate="Dec 1, 2025 at 2:30 PM"
  totalAmount="Rp 25,000"
  pickupLocation="Campus Gate A"
  dropoffLocation="Main Library"
  driverName="Ahmad"
  estimatedTime="5 minutes"
  trackingUrl="https://app.akademove.com/track/ORD-12345"
/>
```

## Base Layout Customization

The base layout (`src/emails/components/base-layout.tsx`) provides:

- **Modern gradient header** with AkadeMove branding
- **Responsive container** with shadow and rounded corners
- **Consistent footer** with social links and copyright
- **Tailwind-inspired styles** for modern look

To customize, edit the style constants at the bottom of `base-layout.tsx`.

## Styling Guidelines

All templates follow these conventions:

- **Colors**: Use Tailwind color palette (gray-50 to gray-900, indigo-500, etc.)
- **Typography**: System font stack for best compatibility
- **Spacing**: Consistent padding/margins using multiples of 4px or 8px
- **Buttons**: Rounded (8px), bold text, prominent CTA color (#667eea)
- **Sections**: Use background colors and borders to create visual hierarchy

## Testing Emails

To test email rendering locally:

```typescript
import { emailService } from '@/emails';
import { ResetPasswordEmail } from '@/emails/templates/reset-password';

const html = await emailService.render(
  <ResetPasswordEmail userName="Test User" resetUrl="https://example.com" />,
  { pretty: true } // Pretty print HTML for debugging
);

console.log(html);
```

## Environment Variables

Required in `.env`:

```bash
RESEND_API_KEY=re_...        # Resend API key
CORS_ORIGIN=https://...      # Frontend URL for links
```

## Dependencies

- `@react-email/components` - Email components
- `react` & `react-dom` (v18) - React runtime
- `resend` - Email delivery API

## Best Practices

1. **Always use BaseLayout** for consistent branding
2. **Keep preview text short** (50-100 chars) - shows in inbox preview
3. **Include plain text fallback** - handled automatically by email service
4. **Test across email clients** - styles are inline for compatibility
5. **Use semantic HTML** - Heading, Text, Button components
6. **Add security warnings** - especially for password reset emails
7. **Include unsubscribe links** - for transactional emails (if required)

## Troubleshooting

### Type Errors in .tsx Files

The base-layout.tsx may show type errors in your IDE due to React 18/19 compatibility. These are cosmetic and don't affect runtime. The `/** @jsxImportSource react */` pragma ensures correct JSX transformation.

### Styles Not Applying

- Ensure styles are objects with camelCase properties
- Use inline styles only (no CSS classes)
- Cast text alignment: `textAlign: "center" as const`

### Email Not Sending

- Check `RESEND_API_KEY` is set correctly
- Verify sender domain is verified in Resend dashboard
- Check Resend logs for delivery errors
