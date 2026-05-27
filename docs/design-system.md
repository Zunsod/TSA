# Design System

## Fonts

| Хувьсагч     | Font                | Хэрэглээ                 |
| ------------ | ------------------- | ------------------------ |
| `font-serif` | PT Serif (400, 700) | Heading h1–h6, брэнд нэр |
| `font-sans`  | Inter (300–700)     | Body, товч, label        |

```css
/* globals.css */
--font-serif: "Playfair Display", Georgia, serif;
--font-sans: "Inter", -apple-system, sans-serif;
html {
  font-size: 18px;
}
/* body: font-sans + color-charcoal + bg-cream */
```

## Typography Scale (Mobile-first)

| Element | Default (375px) | sm: (640px+) | md: (768px+) |
| ------- | --------------- | ------------ | ------------ |
| `h2`    | `text-2xl`      | `text-4xl`   | `text-5xl`   |
| `p`     | `text-sm`       | `text-xl`    | —            |

```jsx
// ✅ Зөв жишээ
<h2 className="font-serif text-2xl sm:text-4xl md:text-5xl text-charcoal leading-tight font-semibold">
<p className="text-sm sm:text-xl text-charcoal leading-relaxed">
```

## Color Palette

| Нэр           | Class              | HEX       | Хэрэглээ         |
| ------------- | ------------------ | --------- | ---------------- |
| cream         | `bg-cream`         | `#FAF8F5` | Body background  |
| cream-dark    | `bg-cream-dark`    | `#F5F0E8` | Section bg       |
| beige         | `bg-beige`         | `#EDE8DE` | Card, border     |
| emerald       | `bg/text-emerald`  | `#2D6A4F` | Brand, CTA       |
| emerald-dark  | `bg-emerald-dark`  | `#1B4332` | Hover            |
| emerald-light | `bg-emerald-light` | `#40916C` | Accent           |
| gold          | `text-gold`        | `#B8860B` | Badge, highlight |
| gold-light    | `text-gold-light`  | `#D4A843` | Gold hover       |
| charcoal      | `text-charcoal`    | `#2D2D2D` | Main text        |
| muted         | `text-muted`       | `#6B7280` | Sub text         |
| olive         | `text-olive`       | `#5C6B3C` | Nature accent    |
| olive-dark    | `text-olive-dark`  | `#3D4A28` | Olive hover      |

```css
/* globals.css @theme */
--color-cream: #faf8f5;
--color-cream-dark: #f5f0e8;
--color-beige: #ede8de;
--color-emerald: #2d6a4f;
--color-emerald-dark: #1b4332;
--color-emerald-light: #40916c;
--color-gold: #b8860b;
--color-gold-light: #d4a843;
--color-charcoal: #2d2d2d;
--color-muted: #6b7280;
--color-olive: #5c6b3c;
--color-olive-dark: #3d4a28;
```

## Border Radius — Sharp Edge Policy

**Шийдвэр:** Бүх товч, карт, input, modal, badge — `rounded-none` (border-radius: 0). Premium, architectural харагдах байдлыг зорьж байна.

| Элемент              | Class         |
| -------------------- | ------------- |
| Button               | `rounded-none` |
| Card / Panel         | `rounded-none` |
| Input / Select       | `rounded-none` |
| Modal / Dialog       | `rounded-none` |
| Badge / Tag          | `rounded-none` |
| Image container      | `rounded-none` |

```jsx
// ✅ Зөв
<Button className="rounded-none ...">Захиалга өгөх</Button>
<div className="rounded-none border border-beige ...">Card</div>

// ❌ Буруу — rounded-* ашиглахгүй
<Button className="rounded-md ...">...</Button>
```

> Зөвхөн avatar/profile зураг болон тусгай тохиолдолд `rounded-full` зөвшөөрнө.

## UX Rules

- Товчны min height: **44px** (iOS/Android touch target стандарт)
- Алхам бүрт **"← Буцах"** товч
- Progress: `● ● ○` (3 алхам)
- Утасны дугаар **+976** урьдчилан бөглөгдсөн
- Navbar-д **"☎ Захиалах"** товч үргэлж харагдах
- Loading state бүх товчинд
- Min font: `text-sm` mobile, `text-lg`+ desktop

## Breakpoints

| Tailwind | px      |           |
| -------- | ------- | --------- |
| default  | 375px+  | iPhone SE |
| `sm:`    | 640px+  | Том утас  |
| `md:`    | 768px+  | Tablet    |
| `lg:`    | 1024px+ | Desktop   |
