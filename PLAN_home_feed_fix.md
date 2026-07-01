# Plan: Fix HomeFeed Loading Error

## Problem

`HomeCubit` always lands on `HomeError` after login.

Root cause chain:
1. `_getCategories()` selects `name_ar, icon_key, media_source` from `categories`
2. Those three columns did not exist in the DB
3. PostgREST returns `42703: column categories.name_ar does not exist`
4. Exception propagates → `HomeError` state

## Steps

### ✅ 1. Add missing columns to `categories`
Migration `add_categories_i18n_and_icon_columns`:
```sql
ALTER TABLE public.categories
  ADD COLUMN IF NOT EXISTS name_ar     text,
  ADD COLUMN IF NOT EXISTS icon_key    text,
  ADD COLUMN IF NOT EXISTS media_source text;
```
Status: **applied**

### ✅ 2. Fix RLS on `tenant_sequences`
Migration `enable_rls_tenant_sequences`:
- Enable RLS
- SELECT policy for active tenant members
- Writes go through `generate_order_number` (SECURITY DEFINER) — unaffected
Status: **applied**

### ✅ 3. Reload PostgREST schema cache
```sql
NOTIFY pgrst, 'reload schema';
```
PostgREST caches the schema at startup. Adding columns requires a cache reload
or the old schema stays active and the new columns appear missing.
Status: **sent**

### 4. Hot-restart app and verify
- `HomeFeed` should load: categories + top items
- `HomeLoaded` state expected in cubit logs
- If still failing, check RLS policies on `categories` table

### 5. (Optional) Populate `name_ar` / `icon_key` data
The columns are now nullable. Existing rows have `NULL` values.
- Flutter falls back to `name` when `name_ar` is null (`localizedTitle` in `CategoryEntity`)
- `iconKey` defaults to `'grid'` when null (datasource line 82)
- No UI breakage expected, but populate via Supabase dashboard when ready

## Files touched

| File | Change |
|------|--------|
| `lib/features/home/data/datasources/home_remote_datasource.dart` | No change needed — query was correct |
| DB `categories` table | Added `name_ar`, `icon_key`, `media_source` columns |
| DB `tenant_sequences` table | Enabled RLS + SELECT policy |
