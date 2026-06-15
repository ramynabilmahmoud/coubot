# Implementation Plan

## Part 1 — Complete Localization (EN + AR)

### 1.1 New keys to add to both ARB files

| Key | English | Arabic |
|-----|---------|--------|
| `myOrders` | My Orders | طلباتي |
| `favourites` | Favourites | المفضلة |
| `settings` | Settings | الإعدادات |
| `logOut` | Log Out | تسجيل الخروج |
| `appearance` | Appearance | المظهر |
| `darkMode` | Dark Mode | الوضع الداكن |
| `language` | Language | اللغة |
| `notifications` | Notifications | الإشعارات |
| `pushNotifications` | Push Notifications | الإشعارات الفورية |
| `about` | About | حول |
| `appVersion` | App Version | إصدار التطبيق |
| `active` | Active | نشطة |
| `completed` | Completed | مكتملة |
| `cancelled` | Cancelled | ملغاة |
| `noActiveOrders` | You don't have any\nactive orders at this time | ليس لديك أي\nطلبات نشطة في الوقت الحالي |
| `reorder` | Reorder | إعادة الطلب |
| `review` | Review | تقييم |
| `leaveAReview` | Leave a Review | أضف تقييماً |
| `howWasYourOrder` | How was your order? | كيف كان طلبك؟ |
| `cancel` | Cancel | إلغاء |
| `submit` | Submit | إرسال |
| `reviewAddedSuccessfully` | Review added successfully | تمت إضافة التقييم بنجاح |
| `noFavouritesYet` | No favourites yet | لا توجد مفضلة بعد |
| `tapHeartToSaveFavourites` | Tap the heart on any item to save it here | اضغط على القلب في أي عنصر لحفظه هنا |
| `onSale` | ON SALE | تخفيض |
| `quantity` | Quantity | الكمية |
| `addToCart` | ADD TO CART | أضف إلى السلة |
| `noItemsAvailable` | No items available | لا توجد عناصر متاحة |
| `noProductsFound` | No products found | لا توجد منتجات |
| `searchProducts` | Search products... | ابحث عن منتجات... |
| `seeAll` | See all | عرض الكل |
| `orderPlacedSuccessfully` | Order placed successfully! | تم تقديم طلبك بنجاح! |
| `failedToPlaceOrder` | Failed to place order. Please try again. | فشل تقديم الطلب. حاول مرة أخرى. |

---

### 1.2 Code changes per file

#### `lib/l10n/intl_en.arb` + `lib/l10n/intl_ar.arb`
Append all 33 keys above. Regenerate with `flutter pub run intl_utils:generate`.

#### `lib/features/orders/presentation/screens/orders_screen.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'My Orders'` (AppBar) | `S.of(context).myOrders` |
| `'Active'` (tab) | `S.of(context).active` |
| `'Completed'` (tab) | `S.of(context).completed` |
| `'Cancelled'` (tab) | `S.of(context).cancelled` |
| `"You don't have any\nactive orders..."` | `S.of(context).noActiveOrders` |
| `'Reorder'` (button) | `S.of(context).reorder` |
| `'Review'` (button) | `S.of(context).review` |
| `'Leave a Review'` (dialog title) | `S.of(context).leaveAReview` |
| `'How was your order?'` (hint) | `S.of(context).howWasYourOrder` |
| `'Cancel'` (dialog action) | `S.of(context).cancel` |
| `'Submit'` (dialog action) | `S.of(context).submit` |
| `'Review added successfully ✅'` (snackbar) | `S.of(context).reviewAddedSuccessfully` |

#### `lib/features/profile/presentation/screens/profile_screen.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'Profile'` (AppBar) | `S.of(context).profile` |
| `'My Orders'` (tile) | `S.of(context).myOrders` |
| `'Favourites'` (tile) | `S.of(context).favourites` |
| `'Settings'` (tile) | `S.of(context).settings` |
| `'Log Out'` (tile) | `S.of(context).logOut` |

#### `lib/features/profile/presentation/screens/settings_screen.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'Settings'` (AppBar) | `S.of(context).settings` |
| `'Appearance'` (section) | `S.of(context).appearance` |
| `'Dark Mode'` (tile) | `S.of(context).darkMode` |
| `'Language'` (section + tile) | `S.of(context).language` |
| `'Notifications'` (section) | `S.of(context).notifications` |
| `'Push Notifications'` (tile) | `S.of(context).pushNotifications` |
| `'About'` (section) | `S.of(context).about` |
| `'App Version'` (tile) | `S.of(context).appVersion` |
- Keep `'EN'` / `'AR'` chip labels as-is (they are language codes, not translated text).

#### `lib/features/profile/presentation/screens/favourites_screen.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'Favourites'` (AppBar) | `S.of(context).favourites` |
| `'No favourites yet'` | `S.of(context).noFavouritesYet` |
| `'Tap the heart on any item to save it here'` | `S.of(context).tapHeartToSaveFavourites` |

#### `lib/features/home/presentation/pages/product_details_screen.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'ON SALE'` (badge) | `S.of(context).onSale` |
| `'Quantity'` (label) | `S.of(context).quantity` |
| `'ADD TO CART'` (button) | `S.of(context).addToCart` |

#### `lib/features/home/presentation/widgets/product_card_small.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'On sale'` | `S.of(context).onSale` |

#### `lib/features/home/presentation/pages/home_screen_body.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'No items available'` | `S.of(context).noItemsAvailable` |
| `'No products found'` | `S.of(context).noProductsFound` |

#### `lib/features/home/presentation/widgets/search_bar_widget.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'Search products...'` (hintText) | `S.of(context).searchProducts` |

#### `lib/core/widgets/section_header.dart`
| Hardcoded string | Replacement |
|-----------------|-------------|
| `'See all'` | `S.of(context).seeAll` |

---

## Part 2 — Checkout Creates an Order in Supabase

### 2.1 Current state
`cart_mobile_screen.dart` line 135: `onPressed: () { // later: checkout }` — does nothing.

### 2.2 Database tables
- **`orders`**: `id`, `customer_id`, `status`, `total_price`, `created_at`, `notes`
- **`order_products`**: `order_id`, `product_id`, `quantity`

Both tables already exist (used by `orders_screen.dart`). No schema migration needed.
The `status` value `'pending'` already matches the active-tab filter in `OrdersScreen`.

### 2.3 Changes

#### `lib/features/cart/presentation/cubit/cart_cubit.dart`
Add a `checkout()` method:
```dart
Future<bool> checkout() async {
  final current = state;
  if (current is! CartLoaded || current.items.isEmpty) return false;

  try {
    final client = Supabase.instance.client;
    final userId = client.auth.currentUser!.id;

    // Insert order row, status defaults to 'pending'
    final orderRow = await client
        .from('orders')
        .insert({
          'customer_id': userId,
          'status': 'pending',
          'total_price': current.total,
        })
        .select('id')
        .single();

    final orderId = orderRow['id'] as int;

    // Insert one row per cart item
    await client.from('order_products').insert(
      current.items.map((item) => {
        'order_id': orderId,
        'product_id': item.productId,
        'quantity': item.quantity,
      }).toList(),
    );

    await clearCart();
    return true;
  } catch (e) {
    emit(CartError(e.toString()));
    return false;
  }
}
```

#### `lib/features/cart/presentation/screens/cart_mobile_screen.dart`
Replace the empty `onPressed` callback:
```dart
onPressed: () async {
  final success = await context.read<CartCubit>().checkout();
  if (!context.mounted) return;
  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).orderPlacedSuccessfully)),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).failedToPlaceOrder)),
    );
  }
},
```

---

## Execution Order

1. Update `intl_en.arb` — append 33 new keys.
2. Update `intl_ar.arb` — append 33 new keys with Arabic values.
3. Run `flutter pub run intl_utils:generate` to regenerate `lib/generated/`.
4. Update all 9 UI files to replace hardcoded strings.
5. Add `checkout()` to `CartCubit`.
6. Wire checkout button in `cart_mobile_screen.dart`.
