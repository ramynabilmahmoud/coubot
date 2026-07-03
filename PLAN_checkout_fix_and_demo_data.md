# Plan: Checkout back button, Supabase order-insert error, demo data reset

## 1. Missing back button on checkout screens

**Cause:** `CheckoutLocationScreen` is the *initial* child route inside `CheckoutWrapper`'s nested `AutoRouter` (see `app_router.dart`). Flutter's default `AppBar` back arrow is driven by `Navigator.canPop()` on the *nearest* Navigator, which for a nested stack's first route is always `false` — even though the outer/root stack could still pop the whole `CheckoutWrapper` off. Same risk on `CheckoutPaymentScreen` if its own stack state is inconsistent.

**Fix:** add an explicit `leading` back button to both screens that pops the current (nested) router if it can, otherwise falls back to popping the root router:
```dart
leading: IconButton(
  icon: const Icon(Icons.arrow_back),
  onPressed: () => context.router.canPop()
      ? context.router.maybePop()
      : context.router.root.maybePop(),
),
```
Files: `lib/features/checkout/presentation/screens/checkout_location_screen.dart`, `checkout_payment_screen.dart`.

## 2. Supabase error after uploading the payment screenshot

**Diagnosed from live project logs** (`fplsrounvbbxgnrcajag`, `postgres` service):
```
ERROR: null value in column "estimated_time" of relation "orders" violates not-null constraint
```
The image upload itself succeeds (200 on `/storage/v1/object/payment-screenshots/...`); the very next call, `POST /rest/v1/orders`, returns 400. Root cause: `orders` has three `NOT NULL` columns with **no default** that no insert path in the app (old `CartCubit.checkout()` or the new `CheckoutCubit.submitOrder()`) ever supplied:
- `estimated_time` (numeric, NOT NULL, no default)
- `delivery_method` (enum `delivery_methods`, NOT NULL, no default)
- `order_num` (int4, NOT NULL, no default — existing rows show it's meant to be a sequential display number, 1..15, with no DB sequence or trigger currently generating it)

**Fix — at the DB level (so every insert path is covered, not just the new one):**
```sql
-- backfill-safe sequence for order_num, continuing from the current max
create sequence if not exists orders_order_num_seq owned by public.orders.order_num;
select setval('orders_order_num_seq', (select coalesce(max(order_num), 0) from public.orders));
alter table public.orders alter column order_num set default nextval('orders_order_num_seq');

-- coubot always delivers to a hall picked in-app, so default to robot delivery
alter table public.orders alter column delivery_method set default 'coubot_dlivery';

-- placeholder prep-time estimate; staff can edit the real one from the admin dashboard
alter table public.orders alter column estimated_time set default 15;
```
No Flutter code changes needed for this part — the client insert already omits these columns, which now resolves via DB defaults instead of erroring.

## 3. Reset data for the university demo

Confirmed with user:
- Wipe **only** `orders` + `order_products` (transactional/test noise). Leave `users`/auth accounts untouched so existing login still works during the demo.
- Replace `categories` + `products` with a new, clean menu (current data has duplicate categories — two "Pizza", two "Desserts", two "Salads", two "Sandwiches" rows, and a category literally named "Dinks" — leftover from repeated test seeding).

**New menu** (6 categories, 13 products, all image URLs reused from ones already proven to load in this exact app — zero broken-image risk for the demo):

| Category | Product | Price (LE) |
|---|---|---|
| Burgers (برجر) | Classic Smash Burger, BBQ Bacon Burger, Mushroom Swiss Burger, Chicken Ranch Burger | 75 / 85 / 80 / 65 |
| Pizza (بيتزا) | Margherita, Pepperoni Feast | 90 / 105 |
| Desserts (حلويات) | Nutella Lava Cake, Cheesecake Slice | 55 / 45 |
| Drinks (مشروبات) | Mango Passion Smoothie, Strawberry Lemonade, Iced Matcha Latte | 55 / 45 / 60 |
| Salads (سلطات) | Caesar Salad | 50 |
| Sandwiches (ساندوتشات) | Club Sandwich | 65 |

Each product gets bilingual name/description (`name_ar`/`description_ar` columns already exist) and an `estimated_time`.

**Steps:**
1. `truncate order_products, orders restart identity cascade;`
2. `truncate product_media, products, categories restart identity cascade;`
3. Insert the 6 categories, then the 13 products referencing them.

## Execution order
1. DB migration for order defaults (#2) — unblocks checkout end-to-end.
2. Data reset + reseed (#3).
3. Back button fix (#1) — pure client code, independent, done alongside.
4. Rebuild app, re-test: cart → hall/payment → upload screenshot → place order should now succeed and show up with status `pending`.
