# Booking Flow

## Wizard — 3 алхам

### Step 1: Захиалгын мэдээлэл
- Тээвэр: PRIVATE | BUS (BUS → Да/Лх/Бя огноо идэвхтэй)
- Огноо: date range picker
- Насанд хүрэгчдийн тоо [+/-]
- Хүүхдийн тоо [+/-] → нас, ор, эмчилгээ тохиргоо
- Өрөөний тоо [+/-]

### Step 2: Өрөө сонгох
- Алгоритм: нийт хүн ÷ өрөөний тоо = дундаж → орны тоо ойр өрөө эхэнд
- Үнэ: хямдаас үнэтэй эрэмблэсэн
- Сонгохоор → BookingSession үүснэ (10 мин lock)

### Step 3: Баталгаажуулалт
- Овог*, Нэр*, Утас* (+976 урьдчилан бөглөгдсөн), И-мэйл (optional)
- UI hint: "📧 И-мэйл (захиалгаа дараа харахад шаардлагатай)"
- Захиалгын хураангуй харуулна
- "Төлбөр баталгаажуулах" товч → processPayment()

## Availability Lock

```
Step 2 орохоор → BookingSession (expiresAt = now + 10min)
QPay confirmed → Booking CONFIRMED → Session устана
10 мин дуусаад PENDING → Session устана → өрөө чөлөөлөгдөнө
```

## QPay Flow (`src/lib/qpay.ts`)

```typescript
export async function processPayment(bookingId: string) {
  if (process.env.NODE_ENV === "development") {
    // Mock: QPay дуудахгүй, шууд confirm
    await prisma.booking.update({
      where: { id: bookingId },
      data: { status: "CONFIRMED", paidAt: new Date() },
    });
    await notify(bookingId); // → email
    return { success: true, mock: true };
  }
  // Prod: QPay invoice → QR → webhook confirm
  const invoice = await createQPayInvoice(bookingId);
  return { success: false, invoiceId: invoice.id, qrImage: invoice.qr };
}
```

## Notification (`src/lib/notify.ts`)

```typescript
export async function notify(bookingId: string) {
  const booking = await prisma.booking.findUnique({
    where: { id: bookingId }, include: { rooms: true },
  });
  if (process.env.NODE_ENV === "development") {
    // Ethereal SMTP — бодит илгээхгүй, preview: https://ethereal.email
    await sendEmail({ to: booking.guestEmail ?? "dev@localhost", ... });
  } else {
    await sendSMS({ to: booking.guestPhone, ... });
  }
}
```

## Guest User Upsert (booking submit үед)

```typescript
const user = await prisma.user.upsert({
  where: { phone: normalizePhone(formData.phone) },
  update: { email: formData.email ?? undefined },
  create: {
    phone: normalizePhone(formData.phone),
    firstName: formData.firstName,
    lastName: formData.lastName,
    email: formData.email ?? null,
    // password = null → guest account
  },
});
await prisma.booking.create({ data: { userId: user.id, ... } });
```

## Phone Normalize

```typescript
function normalizePhone(phone: string): string {
  const digits = phone.replace(/\D/g, "");
  if (digits.length === 8) return `+976${digits}`;
  if (digits.startsWith("976")) return `+${digits}`;
  return `+${digits}`;
}
```

## Cancellation Flow

```
User → "Цуцлах хүсэлт"
  → 7+ хоног: анхааруулга
  → <7 хоног: суутгал alert
  → CancellationRequest үүснэ
  → Admin: Зөвшөөрөх / Татгалзах
  → notify() → хэрэглэгчид мэдэгдэл
```
