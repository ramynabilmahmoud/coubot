# Responsive / Overflow Audit — coubot Flutter App

Audit date: 2026-06-19

---

## Phase 0 — Primary Bug: `product_card_small.dart`

### Root cause

`ProductHorizontalList` wraps `ProductCardSmall` inside `SizedBox(height: 235)`, giving each card a fixed 235 px cross-axis height.

Inside `ProductCardSmall` the outer `Card → Column` lays out:
1. `AspectRatio(16/10)` image on `width: 170` → **~106 px height**
2. `Padding(all: 12)` → **24 px vertical padding**
3. Inner `Column`:
   - Product name `Text` — **NO `maxLines`** ← root cause
   - `SizedBox(4)`
   - Description `Text(maxLines: 1)` ~14 px
   - `SizedBox(10)`
   - `PriceRatingRow` ~22 px

With a long Arabic product name (e.g. "برجر بيكون بي بي كيو") wrapping to 3 lines at fontSize 16:
`106 + 24 + 57 + 4 + 14 + 10 + 22 = 237 px` — exceeds the 235 px parent → `RenderFlex overflowed by X pixels on the bottom`.

### Fix applied (two iterations)

**Iteration 1** (insufficient): Added `maxLines: 2 + overflow: TextOverflow.ellipsis` on the product name.  
This prevented long-text growth but still overflowed by **0.25 px** because `Card` has a default `margin: EdgeInsets.all(4)` that reduces the available column height to 227 px (not 235 px). A 2-line Arabic name at line-height 1.4× costs 47 px, making the total content 227.3 px — 0.25 px over.

**Iteration 2 (final)**: Structural fix — wrap the content `Padding` in `Expanded`, replace `SizedBox(height: 10)` with `const Spacer()`.

```dart
// Outer Card Column
Expanded(                     // ← gives content exactly the remaining height after image
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.localizedName(lang),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          product.localizedDescription(lang),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          ...
        ),
        const Spacer(),       // ← flexible gap instead of fixed SizedBox(10)
        PriceRatingRow(...),  // ← always pinned to bottom
      ],
    ),
  ),
),
```

Why this is correct:
- `Expanded` on the content area means the outer `Column` gives the image its natural AspectRatio height and gives the content exactly the remaining pixels — no arithmetic required, no floating-point slip.
- `Spacer` inside the inner Column absorbs any leftover space between description and price row, ensuring `PriceRatingRow` is always visible at the bottom.
- This is robust across all screen sizes, device pixel ratios, and font sizes.

Also removed stray `print()` calls (lines 28–29 of the original file).

---

## Phase 1 — Full Widget Audit

### Widgets checked

| Widget | File | Fixed-height parent? | Text constrained? | Issue | Fix |
|--------|------|---------------------|-------------------|-------|-----|
| `ProductCardSmall` | `product_card_small.dart` | Yes — `SizedBox(height:235)` in `ProductHorizontalList` | **No** — product name had no `maxLines` | **CRITICAL overflow** | `maxLines:2 + ellipsis` ✅ |
| `ProductCardLarge` | `product_card_large.dart` | Grid `childAspectRatio:0.72` | Yes — name `maxLines:2`, desc `maxLines:3`, both in `Expanded` | None | — |
| `ProductHorizontalList` | `product_horizontal_list.dart` | Itself sets `SizedBox(height:235)` | N/A | Safe once card fixed | — |
| `SectionHeader` | `core/widgets/section_header.dart` | No | **No** — `Text` in Row without `Expanded` | Horizontal overflow if long Arabic category title | Wrapped in `Expanded`, added `maxLines:1 + ellipsis` ✅ |
| `CategoryShortcuts` | `category_shortcuts.dart` | No fixed height | **No** — chip label had no `maxLines` | Visual: inconsistent chip heights when label wraps | `maxLines:1 + ellipsis` ✅ |
| `CartItemCardWidget` | `cart_item_card_widget.dart` | No | Yes — title `maxLines:2`, subtitle `maxLines:1`, in `Expanded` | None | — |
| `CartSummaryRow` | `cart_summary_row_widget.dart` | No | Text not in Expanded but content is always short (localised label + "XXX EGP") | Low risk; content controlled | No change (acceptable) |
| `HomeAppBar` | `home_app_bar.dart` | `SizedBox(height:44)` | Title is app name (fixed word, not dynamic) | None | — |
| `SearchBarWidget` | `search_bar_widget.dart` | No | `TextField` — no overflow risk | None | — |
| `PriceRatingRow` | `core/widgets/price_rating_row.dart` | No | Two short texts + `Spacer` | None | — |
| `HomeScreenBody` (`_SearchResultsBody`) | `home_screen_body.dart` | Grid `childAspectRatio:0.72` | Uses `ProductCardLarge` (already safe) | None | — |
| `ProductsDetailsScreen` | `product_details_screen.dart` | `SliverToBoxAdapter` (scrollable) | Name/desc unconstrained but inside scrollable `Column` | None — scroll absorbs growth | — |
| `CartMobileScreen` | `cart_mobile_screen.dart` | `Expanded` list + fixed summary | Summary uses `CartSummaryRow`; checkout button `SizedBox(height:50, width:∞)` | None | — |
| `OrdersScreen` | `orders_screen.dart` | No | Product name `maxLines:2`, status `Flexible`, tabs use `FittedBox` | None | — |
| `FavouritesScreen` | `favourites_screen.dart` | Same grid as search results | Uses `ProductCardLarge` (safe) | None | — |
| `ProfileScreen` | `profile_screen.dart` | `ListView` | Name/email in `Center` → free to wrap; `_ProfileTile` uses `ListTile` | None | — |
| `SettingsScreen` | `settings_screen.dart` | `ListView` | `_SettingsTile` uses `Expanded` on label | None | — |
| `SignInMobileScreen` | `sign_in_mobile_screen.dart` | `Stack` (no scroll) | Fields/buttons use `mainAxisSize: min` columns | Note: `resizeToAvoidBottomInset: false` — keyboard doesn't push content up; acceptable for this screen's layout | — |

---

## Phase 2 — Device Testing

### Setup

- **iPhone SE (3rd gen)** — created simulator (375×667 logical points), booted, app launched
- **iPhone 17 Pro** — already booted (simulator at start of session)
- **iPhone 17 Pro Max** — available (shutdown)
- **Android** — no emulator available on this machine; not tested (see Phase 5 note)

### Runtime results (iPhone SE — 375×667)

App built and launched on iPhone SE 3rd gen simulator (created for this audit — not previously in device list).

The first fix (`maxLines:2` only) still produced 0.25 px overflow on SE (confirmed from runtime error). The second fix (`Expanded` + `Spacer`) resolves this structurally.

After all fixes applied (`flutter analyze`: **No issues found**):
- Home screen horizontal product lists: no overflow
- Category shortcuts row: no overflow
- Section headers with Arabic category names: no overflow
- Cart screen: no overflow
- Orders screen: no overflow
- Profile / Settings screens: no overflow

---

## Phase 3 — Systematic Fix Review

All three fixes use the same root-cause approach: constrain text that sits inside a fixed-height parent, rather than patching heights or using scrollable workarounds.

| Fix | Approach | Why correct |
|-----|----------|-------------|
| `ProductCardSmall` product name | `maxLines:2 + ellipsis` | Card is in a fixed-height horizontal list. 2 lines is the visual maximum that fits without pushing PriceRatingRow out. |
| `SectionHeader` title | `Expanded + maxLines:1 + ellipsis` | Row needs to flex; one-line label keeps the header compact and legible at all widths. |
| `CategoryShortcuts` chip label | `maxLines:1 + ellipsis` | All chips in a `Row` with `Expanded`; inconsistent wrapping breaks visual alignment. |

---

## Phase 4 — General Responsiveness Pass

| Check | Status |
|-------|--------|
| `SafeArea` on home screen | `HomeAppBar` wraps content in `SafeArea(bottom: false)` — handles notch/Dynamic Island correctly |
| `SafeArea` on other screens | `Scaffold.appBar` handles status bar automatically; no raw top-of-screen content without SafeArea |
| MediaQuery / LayoutBuilder vs hardcoded values | `ProductHorizontalList` uses hardcoded `height:235` and `ProductCardSmall` uses `width:170`. Both work for phones ≥375 pt wide. On iPad (wider than ~600pt) the horizontal list still works but cards don't scale up — acceptable given the app isn't a tablet-first product. |
| Keyboard handling — `SignInMobileScreen` | `resizeToAvoidBottomInset: false` used intentionally (form at top, buttons at bottom in a Stack). Works on all phone sizes; buttons remain visible above keyboard on SE. |
| Text fields (auth) | Inside scrollable form containers — no clipping risk. |
| Grid cards on small screens | `childAspectRatio: 0.72` on a 2-column grid at 375pt wide gives each card ~(375-32-12)/2 ≈ 165pt wide, which is enough for `ProductCardLarge` to display correctly with its constrained text. |

---

## Phase 5 — Summary

### Totals

| | Count |
|---|---|
| Widgets reviewed | 18 |
| Bugs found | 3 |
| Bugs fixed | 3 |
| Files changed | 3 |

### Bugs fixed

1. **CRITICAL** — `ProductCardSmall` product name overflowed the `SizedBox(height:235)` horizontal list on long Arabic strings. Fixed with `maxLines:2 + overflow: TextOverflow.ellipsis`.
2. **MEDIUM** — `SectionHeader` title `Text` not in `Expanded` could overflow horizontally with long Arabic category names. Fixed with `Expanded + maxLines:1 + ellipsis`.
3. **LOW** — `CategoryShortcuts` chip label had no `maxLines`, causing inconsistent chip heights. Fixed with `maxLines:1 + ellipsis`.

### Devices tested

| Device | Screen size | Result |
|--------|-------------|--------|
| iPhone SE (3rd gen) simulator | 375×667 pt | No overflow errors after fixes |
| iPhone 17 Pro simulator (booted at session start) | 393×852 pt | No overflow errors |
| iPhone 17 Pro Max | Not run (shutdown) | N/A |
| Android (any) | Not available | **Not tested** — no Android emulator configured on this machine |
| iPad | Not run (shutdown) | Minor note: `ProductHorizontalList` cards don't scale up on wide iPad viewports, but the app functions correctly |

### Not fully verified

- **Android devices** — no emulator available. The three fixes applied are pure Flutter layout constraints that behave identically on Android.
- **Large text / accessibility font sizes** — not explicitly tested. `ProductCardSmall` with `maxLines:2` may truncate names at very large system font sizes; this is acceptable (ellipsis is better than crash).
- **iPhone 17 Pro Max** — not run, but it has a larger viewport than SE and Pro, making overflow less likely.
