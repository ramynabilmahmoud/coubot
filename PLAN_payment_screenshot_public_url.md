# Plan: Make payment screenshot fetchable as a URL

## Root cause
`payment-screenshots` bucket was created **private** (`public: false`), and `CheckoutCubit.submitOrder()` stores only the raw storage **path** (e.g. `6a8b2781.../1783029840612.jpg`) in `orders.payment_screenshot_url` — not a URL at all. A private bucket requires either an authenticated SDK call or a signed URL to fetch; a plain path can't be opened directly, and your admin website has no way to hit it.

This app already has a working precedent: the `media` bucket (used for product/category images) is **public**, and the DB stores full public URLs like `https://fplsrounvbbxgnrcajag.supabase.co/storage/v1/object/public/media/products/....jpg` — directly fetchable by anyone, which is exactly what a website needs.

## Fix
1. **Make `payment-screenshots` public** (matches the `media` bucket convention already used elsewhere in this app):
   ```sql
   update storage.buckets set public = true where id = 'payment-screenshots';
   ```
   The existing INSERT RLS policy (upload only to your own `auth.uid()` folder) stays — that still governs who can *upload*. Public only affects *reads*, which is what we want (no auth needed to view).

2. **Backfill existing rows** that already have a bare path stored, converting them to full public URLs:
   ```sql
   update public.orders
   set payment_screenshot_url = 'https://fplsrounvbbxgnrcajag.supabase.co/storage/v1/object/public/payment-screenshots/' || payment_screenshot_url
   where payment_screenshot_url is not null
     and payment_screenshot_url not like 'http%';
   ```

3. **Client-side fix** (`lib/features/checkout/presentation/cubit/checkout_cubit.dart`): after uploading, call `client.storage.from('payment-screenshots').getPublicUrl(path)` and store that full URL instead of the raw path, so all future orders are correct from the start.

## Who does what
- Step 3 (Dart code) — I do this now.
- Steps 1 and 2 (SQL) — my Supabase MCP connection dropped mid-session and the CLI needs `supabase login` (interactive, can't be done for you) — **you'll need to run these two statements yourself** in the Supabase SQL editor (or tell me once you've run `supabase login` locally and I can run them via CLI instead).
