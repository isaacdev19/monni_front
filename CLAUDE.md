# monni — personal finance app (Flutter)

monni is a personal finance app. Spanish UI, COP currency. Local-first now, cloud later.
Repo name: `monni` (decided Nov 17, 2026). The old name "Mis Finanzas" / "mis-finanzas-mobile" is retired; do not use it.

## Language rules
- ALL code in English: folders, packages, classes, tables, routes, comments, commits.
- UI strings in Spanish, through ARB files (set up in sprint 2). No hardcoded UI strings once ARB exists.

## Stack
Flutter + Dart. Android and iOS first, web later (same app).
Drift (SQLite), Riverpod, go_router, intl, uuid, google_fonts, build_runner + drift_dev,
flutter_test, Melos + pub workspaces, GitHub + GitHub Actions. fl_chart arrives in v1.1.
Future cloud: Supabase (Postgres) + own sync by `updatedAt`, or PowerSync. Decided later, do not prepare it beyond the data rules below.

## Monorepo layout (mobile front only)
```
monni/
├── pubspec.yaml          workspace root + Melos scripts: analyze, test, format, gen
├── app/                  bootstrap, routes (go_router), DI (Riverpod)
├── shared/
│   ├── core/             money, dates, errors, EntitlementService interface (pure Dart)
│   ├── design_system/    theme and components, NO business logic
│   ├── infrastructure/   Drift database and ALL tables; later network, Supabase, payments
│   └── analytics/        interface + empty implementation
├── features/             home, transactions, budget, recurring, categories, settings
└── .github/workflows/ci.yaml
```
### Package naming
- Packages in `features/` use the `monni_` prefix: `monni_home`, `monni_transactions`, `monni_budget`, `monni_recurring`, `monni_categories`, `monni_settings`.
- Packages in `shared/` have NO prefix: `core`, `design_system`, `infrastructure`, `analytics`.
- The `app/` package keeps the name `app`.
- Mark every package `publish_to: none` so names never collide with pub.dev.

Each feature is a package: `lib/<feature>.dart` (public API) + `lib/src/{domain,data,ui}`.
The public API file uses the package name, e.g. `monni_transactions/lib/monni_transactions.dart`.
Use cases only where there is real logic (e.g. mark recurring item as paid, month summary).

## Dependency rules (never break these)
1. Only downward: app -> features -> shared. `shared` never knows features.
2. `ui` and `data` depend on `domain`. `domain` is pure Dart.
3. A feature only uses the PUBLIC API of a lower feature:
   home -> budget, recurring, transactions; budget and recurring -> transactions; transactions -> categories.
4. Nobody imports another feature's `src/`.
5. Navigation belongs to `app`. Features navigate by string route (e.g. `/transactions/new`).
6. Screens talk to repositories, never to the database directly.

## Data rules (cloud-ready)
- Ids are UUIDs. Every table has `id`, `createdAt`, `updatedAt`, `deletedAt` (soft delete).
- Money is an integer in pesos. Never double. `amount` is always > 0; `kind` gives the sign.
- Months are strings `YYYY-MM`.

## Data model (4 tables)
- `categories`: name, kind (expense|income), icon, sortOrder, isArchived
- `transactions`: kind, amount, categoryId, date, note, isFixed, recurringItemId (optional)
- `recurring_items`: name, kind, amount, categoryId, dayOfMonth (1-31), startMonth, endMonth (optional), isActive
- `budgets`: month, categoryId, limitAmount; unique on (month, categoryId)

## Business rules
- Month available = income − expenses (excluding soft-deleted).
- Budget usage = spent / limit. Normal < 85%; "near limit" from 85% up to the limit; "exceeded" above it.
- Month pace = current day / days in month.
- A recurring item is paid if a transaction of that month has its `recurringItemId`.
  "Mark as paid" creates it (amount adjustable for that month only); "Undo" soft-deletes it.
- Day 29/30/31 in shorter months -> last day of the month.
- Month without budget -> copy previous month's budget.
- Categories with transactions are archived, never deleted.

## MVP product decisions (Nov 17, 2026)
- COP is the only currency. `Money` is an integer number of pesos. No currency field in the MVP.
- No wallets or accounts in the MVP. Later they arrive as an `accountId` field; do not add it now.
- Credit cards: the user registers the purchase when it happens. Paying the card bill is NOT recorded as an expense (it would double count).
  The MVP has no "debt payment" concept and no special category for it. Do not add one.
  The user is told in help / first-use copy not to register the card bill payment.

## Monetization (freemium)
Whole MVP is free. Code asks "is premium?" ONLY through `EntitlementService` (interface in `shared/core`).
In the MVP the implementation always answers yes. No in-app payments in sprints 1-6.

## Design
Source of truth: Figma Design file "Monni — Finance App (MVP)", fileKey `OK2kmRk1s8PkMF7q22Wz3o`
(account "Big Isaac" only, never the company account).
- Figma MCP returns React/Tailwind by default. Use it as a visual reference ONLY. Never port that code.
- Tokens below go to `shared/design_system` (Material 3 ThemeData + ThemeExtension for colors/shadows).
- Fonts: Inter (body, labels) and Space Grotesk (titles, amounts, brand). Space Grotesk has only Light/Regular/Medium/Bold.
- Amounts use tabular figures (`FontFeature.tabularFigures()`).
- Minimum text size 11 px. Text contrast >= 4.5:1.

### Color tokens
- text: primary #22251f · secondary #60645c · tertiary #6f736c · placeholder #b4b6af · strong-muted #61655e · sage #606e62 · inverse #ffffff · icon #44483f
- bg: app #f8f7f2 · surface #ffffff · nav #fffffd · sunken #edeee8 · field-icon #f0f1ec · track #e6e8e2 · control-off #d7d9d3 · badge #dedfd9 · scrim #1b1f19
- border: divider #e8e9e2 · card #ebebe5 · control #e2e3dd · selected #87a291
- brand: green #2e6b4d · green-card #2e674b · green-soft #dcebdd · green-pale #e2eee3 · coral #dd725f · coral-soft #f8ded8
- status: ok #68a178 · warn #d3ae4f · over #dc705e · danger-text #c75949 · expense #c96756 · income #5e9170
- chart: on-green #b9d7bd
- category tones (icon / bg): lilac #76619b/#eee9f6 · blue #4f7390/#e3eef4 · yellow #94752d/#f5eccd · green #52755e/#e3eee4 · mint #377059/#dceee4 · coral #b86252/#f7e2dc

### Shadows (x offset 0, no spread; y / blur, color, opacity)
card 6/17 #2b3228 3.5% · raised 13/28 #2e674b 19% · button 10/22 #2e6b4d 20% · selected 5/14 #2e6b4d 8% · segment 3/12 #2b3027 8% · sheet 24/60 #191f17 24%

Full text styles table (38 styles) lives in the Figma file and the project context document. Read it from Figma when building `design_system`.

## Git workflow
- `main` is protected. One branch per task (`feature/add-transaction`). PR with green CI.
- Commits in English with prefix: `feat:`, `fix:`, `docs:`, `chore:`.
- Never commit `*.g.dart`, keys or secrets.

## Working agreement for Claude Code
- Plan first (plan mode) for any task that touches more than one package. Wait for approval.
- Small tasks, one Notion card each. Do not build screens that are not in the current sprint.
- Any money, budget or date logic needs unit tests in the same change.
- After edits run: `melos run format_fix`, `melos run analyze`, `melos run test`. Fix before reporting done.
  `melos run format` only checks formatting (used by CI); `format_fix` writes the changes.
- Respect the dependency rules above. If a task needs to break one, stop and ask.
- Do not rename packages, the repo or the product name without asking.
