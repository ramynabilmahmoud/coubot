# Plan: Theme Text Colors, Realtime Notifications, Checkout Payment Flow

Confirmed with user:
- Halls: fixed list of 4 — `A101`, `A102`, `A103`, `A104` (not 6, confirmed).
- Notifications: Supabase Realtime (websocket, same mechanism already used in `orders_screen.dart`) + local notification display, **not** true FCM/APNs push. Will only fire while the app process is alive (foreground or backgrounded) — not when fully killed. User explicitly accepted this tradeoff ("app should only receive notifications", SSE-like).
- Payment numbers (hardcoded): E-Wallet `01094419501`, Instapay `01149935742`.

---

## 1. Text color respects theme (white text in dark mode, dark text in light mode)

**Root cause:** `AppTheme`/`AppThemeDark` (`lib/config/themes/app_theme.dart`, `app_theme_dark.dart`) correctly configure `textTheme` per brightness, but most screens don't use `Theme.of(context).textTheme`. Instead they use `const TextStyle(...)` literals with no color (defaults to black), or hardcode light-only `AppColors.text`/`AppColors.mutedText`. `orders_screen.dart` also has raw `Color(0xFF...)` literals for status text, bypassing `AppColors` entirely.

**Steps:**
1. Add a theme-aware color helper (extension on `BuildContext` or static functions in `lib/config/themes/app_colors.dart`):
   ```dart
   Color textColor(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? AppColors.textDark : AppColors.text;
   Color mutedTextColor(BuildContext c) => Theme.of(c).brightness == Brightness.dark ? AppColors.mutedTextDark : AppColors.mutedText;
   ```
2. Sweep and fix every file using hardcoded/no-color text styles (identified so far):
   - `cart_mobile_screen.dart`, `orders_screen.dart`, `product_card_large.dart`, `home_app_bar.dart`, `product_details_screen.dart`, `sign_in_mobile_screen.dart`, `settings_screen.dart`, `profile_screen.dart`, `favourites_screen.dart`, `cart_item_card_widget.dart`, `search_bar_widget.dart`, `custom_button.dart`, `custom_textfield.dart`, `auth_main_button.dart`, `price_rating_row.dart`, plus any others turned up during the sweep.
   - Replace `AppColors.text` / `AppColors.mutedText` (light-only) with the new helper, or with `Theme.of(context).textTheme.*` where a named style fits.
   - Replace `orders_screen.dart`'s raw `Color(0xFFC72C41)` etc. used for text with theme-aware equivalents.
3. Resolve the duplicate `AppColors` class problem: `lib/config/themes/app_colors.dart` (full, light+dark pairs) vs `lib/core/utils/app_colors.dart` (partial, light-only). Standardize on the full one; update the 2 importers (`theme_helper.dart`, `snack_x.dart`) or delete the redundant one once unused.
4. Manually verify via `/run` — toggle theme switch in Settings, walk through Home, Cart, Orders, Profile, Sign In/Up, Favourites, checking every text is legible in both modes.

---

## 2. Realtime notifications (Supabase Realtime + local notification)

**Approach:** reuse the existing `orders_screen.dart` realtime pattern (`supabase.channel(...).onPostgresChanges(...)`) but make it global and surface a local notification, not just an in-screen refresh.

**Steps:**
1. Add `flutter_local_notifications` to `pubspec.yaml`.
2. Create `lib/core/services/notification_service.dart`:
   - Initializes `flutter_local_notifications` plugin, requests notification permission (Android 13+, iOS).
   - Exposes `showNotification(title, body)`.
3. Create a global `NotificationsCubit` (or plain service singleton via `get_it`) that, once a user is authenticated:
   - Opens a Supabase Realtime channel on `orders` filtered by `customer_id = currentUser.id`.
   - On `UPDATE` (status change) or `INSERT`, calls `NotificationService.showNotification(...)` with a message built from the new status (e.g. "Order #12 is now preparing").
4. Register/start this listener once after login (e.g. in `MainCubit` or `AppLayoutScreen` init) and cancel the channel subscription on logout/dispose.
5. Add to `MultiBlocManager` if it needs to live at app root scope.
6. Test: change an order's `status` via SQL/Supabase dashboard while app is running (foreground and backgrounded) and confirm a local notification appears.
7. Document limitation in-app/README: notifications only fire while the app process is alive; won't wake the app from fully killed state (would require FCM/APNs for that).

---

## 3. Checkout flow: hall selection → payment method → payment details + screenshot upload

**New screens (auto_route, following the `CartScreen`/`CartRoute` pattern):**
1. `CheckoutLocationScreen` — hall picker (`A101`–`A104`, fixed list, single-select) + payment method picker (`E-Wallet` / `Instapay`, single-select). "Next" enabled once both chosen.
2. `CheckoutPaymentScreen` — shows the target number for the chosen method (E-Wallet: `01094419501`, Instapay: `01149935742`), an image picker to attach the transaction screenshot, and a "Place Order" button.

**Steps:**
1. Add `image_picker` to `pubspec.yaml` (no existing image upload pattern in the app — building from scratch).
2. Supabase migration:
   - Add columns to `orders`: `hall text`, `payment_method text`, `payment_screenshot_url text`.
   - Create a Storage bucket (e.g. `payment-screenshots`), private, with an RLS policy so a user can only upload/read their own files (path prefixed by their `customer_id`).
3. Add routes: `CheckoutLocationRoute`, `CheckoutPaymentRoute` in `app_router.dart` + `app_paths.dart`; regenerate with `build_runner`.
4. Change the Cart screen's "Checkout" button (`cart_mobile_screen.dart`) to navigate to `CheckoutLocationRoute` instead of calling `CartCubit.checkout()` directly.
5. Add a small `CheckoutCubit` (lightweight, matching `CartCubit`'s current direct-Supabase-call style — not the full clean-architecture `home` pattern, to stay consistent with cart/orders) holding draft state: selected hall, selected payment method, picked image file.
6. On "Place Order":
   - Upload the picked image to the `payment-screenshots` bucket, get its URL.
   - Insert into `orders`: `customer_id`, `status: 'pending'`, `total_price`, `hall`, `payment_method`, `payment_screenshot_url`.
   - Insert cart items into `order_products` (reuse existing logic from `CartCubit.checkout()`).
   - Clear the cart, navigate to Orders tab or a confirmation screen.
7. Test end-to-end: Cart → Checkout → pick hall → pick payment method → Next → see correct number for method → upload screenshot → Place Order → verify new row in `orders` (status `pending`, correct hall/payment_method) and the screenshot is reachable in Storage.

---

## Suggested order of execution
1. Theme fix (isolated, no schema/backend changes, quick win).
2. Checkout flow (needs migration + storage bucket — do schema work once).
3. Realtime notifications (independent, can run in parallel with checkout if desired, but simplest to do last since it's additive).
