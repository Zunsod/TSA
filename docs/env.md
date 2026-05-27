# Environment Variables (`.env`)

```bash
# Database
DATABASE_URL="postgresql://..."

# Supabase
NEXT_PUBLIC_SUPABASE_URL=""
NEXT_PUBLIC_SUPABASE_ANON_KEY=""
SUPABASE_SERVICE_ROLE_KEY=""

# NextAuth
NEXTAUTH_SECRET=""
NEXTAUTH_URL="http://localhost:3000"

# QPay — prod only
QPAY_USERNAME=""
QPAY_PASSWORD=""
QPAY_INVOICE_CODE=""
QPAY_BASE_URL="https://merchant.qpay.mn/v2"

# SMS — prod only
SMS_API_KEY=""
SMS_SENDER_ID=""

# Email — dev only (Nodemailer + Ethereal)
# Preview: https://ethereal.email — бодит илгээхгүй
EMAIL_DEV_HOST="smtp.ethereal.email"
EMAIL_DEV_PORT="587"
EMAIL_DEV_USER=""
EMAIL_DEV_PASS=""
EMAIL_DEV_FROM="noreply@anandkhujirt.dev"

# Admin
ADMIN_SECRET=""
```
