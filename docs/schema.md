# Schema & Types

## Prisma Schema (`prisma/schema.prisma`)

```prisma
model User {
  id        String   @id @default(cuid())
  phone     String   @unique
  lastName  String
  firstName String
  email     String?
  role      Role     @default(USER)
  bookings  Booking[]
  createdAt DateTime @default(now())
}

enum Role { USER ADMIN }

model Room {
  id            String      @id @default(cuid())
  name          String
  type          RoomType
  bedCount      Int
  pricePerNight Int
  floor         Int
  building      String      // "main" | "extension"
  roomNumber    String
  description   String?
  images        String[]
  isActive      Boolean     @default(true)
  bookings      BookingRoom[]
  locks         RoomLock[]
}

enum RoomType { STANDARD SEMI_LUX LUX }

model Booking {
  id              String        @id @default(cuid())
  userId          String?
  user            User?         @relation(fields: [userId], references: [id])
  guestLastName   String
  guestFirstName  String
  guestPhone      String
  guestEmail      String?
  checkIn         DateTime
  checkOut        DateTime
  nights          Int
  transport       TransportType
  adultCount      Int
  totalPrice      Int
  status          BookingStatus @default(PENDING)
  qpayInvoiceId   String?
  qpayPaymentId   String?
  paidAt          DateTime?
  rooms           BookingRoom[]
  children        BookingChild[]
  cancellation    CancellationRequest?
  createdAt       DateTime      @default(now())
  updatedAt       DateTime      @updatedAt
}

enum TransportType { PRIVATE BUS }
enum BookingStatus { PENDING CONFIRMED CANCELLED COMPLETED }

model BookingRoom {
  id        String  @id @default(cuid())
  bookingId String
  booking   Booking @relation(fields: [bookingId], references: [id])
  roomId    String
  room      Room    @relation(fields: [roomId], references: [id])
}

model BookingChild {
  id            String  @id @default(cuid())
  bookingId     String
  booking       Booking @relation(fields: [bookingId], references: [id])
  ageMin        Int
  ageMax        Int
  hasBed        Boolean
  withTreatment Boolean @default(false)
  pricePerNight Int
}

model RoomLock {
  id        String   @id @default(cuid())
  roomId    String
  room      Room     @relation(fields: [roomId], references: [id])
  startDate DateTime
  endDate   DateTime
  reason    String?
  createdBy String
  createdAt DateTime @default(now())
}

model BookingSession {
  id        String   @id @default(cuid())
  roomIds   String[]
  checkIn   DateTime
  checkOut  DateTime
  expiresAt DateTime // now + 10 min
  createdAt DateTime @default(now())
}

model CancellationRequest {
  id         String             @id @default(cuid())
  bookingId  String             @unique
  booking    Booking            @relation(fields: [bookingId], references: [id])
  reason     String?
  status     CancellationStatus @default(PENDING)
  reviewedBy String?
  reviewedAt DateTime?
  createdAt  DateTime           @default(now())
}

enum CancellationStatus { PENDING APPROVED REJECTED }

model BusSchedule {
  id        String   @id @default(cuid())
  dayOfWeek Int[]    // [1,3,6] = Да,Лх,Бя
  isActive  Boolean  @default(true)
  updatedAt DateTime @updatedAt
}
```

## TypeScript Types (`src/types/index.ts`)

```typescript
interface BookingState {
  transport: "PRIVATE" | "BUS" | null;
  checkIn: Date | null;
  checkOut: Date | null;
  nights: number;
  adultCount: number;
  children: ChildConfig[];
  roomCount: number;
  selectedRooms: Room[];
  guestLastName: string;
  guestFirstName: string;
  guestPhone: string;
  guestEmail: string;
  totalPrice: number;
  sessionId: string | null;
}

interface ChildConfig {
  id: string;
  ageRange: "0-2" | "3-5" | "6-8" | "8-11" | "12+";
  hasBed: boolean;
  withTreatment: boolean;
}
```
