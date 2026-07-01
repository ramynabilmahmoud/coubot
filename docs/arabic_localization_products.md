# Arabic Localization — Products

## Current State

| Layer | Status |
|---|---|
| `public.products.name_ar` | **Missing** — column does not exist |
| `public.products.description_ar` | **Missing** — column does not exist |
| `ProductModel.fromJson` | Ready — reads `name_ar` and `description_ar` from JSON |
| `ProductEntity.localizedName(lang)` | Ready — returns `nameAr` when `lang == 'ar'` and `nameAr` is non-null |
| `ProductEntity.localizedDescription(lang)` | Ready — same pattern |
| UI widgets | Ready — `ProductCardLarge`, `ProductCardSmall`, `ProductsDetailsScreen` all call `localizedName(lang)` |

All 193 products currently have Arabic text in the `name` column. `description` is also Arabic where present.

## Migration Plan

### Step 1 — Add columns

```sql
ALTER TABLE public.products
  ADD COLUMN IF NOT EXISTS name_ar        TEXT,
  ADD COLUMN IF NOT EXISTS description_ar TEXT;
```

### Step 2 — Seed Arabic data from existing name/description

Since current `name` and `description` are already in Arabic, copy them directly:

```sql
UPDATE public.products
SET
  name_ar        = name,
  description_ar = description
WHERE name_ar IS NULL;
```

### Step 3 — Verify

```sql
SELECT id, name, name_ar, description, description_ar
FROM public.products
WHERE name_ar IS NOT NULL
LIMIT 5;
```

Expected: `name` and `name_ar` identical (both Arabic) for all rows.

## How the App Uses This

```
Flutter build locale → MainCubit.currentLangCode ('ar' | 'en')
    ↓
ProductEntity.localizedName('ar')
    → nameAr != null && nameAr.isNotEmpty → return nameAr  ✓ Arabic
    → else → return name (fallback)
```

When user switches to Arabic in Settings → `MainCubit` updates locale → widgets rebuild → `localizedName('ar')` returns `nameAr`.

## Verification Steps

1. Run app in Arabic language mode (Settings → Language → Arabic)
2. Open Home screen — product cards should show Arabic names
3. Open product details — title and description should be Arabic
4. Switch to English — should fall back to `name` column (also Arabic for now — English translations are a future task)

## Future Work

- Add English translations to the `name` column (currently Arabic)
- `name_ar` will then serve as the explicit Arabic override, `name` as the English default
