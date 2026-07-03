# Profile Screen Name Text Theme Fix

## Bug

`profile_screen.dart:66` — name `Text` hardcodes `color: AppColors.text`
(`0xFF1D1B1E`, near-black). In dark theme the screen background flips dark
but this text stays hardcoded dark → unreadable name.

`AppColors` already defines dark-mode counterparts (`textDark`
`0xFFF2EBF0`, `mutedTextDark` `0xFFAA9AA8`) but the name `Text` never
references them — it isn't theme-aware at all.

## Fix

- Add `final cs = Theme.of(context).colorScheme;` to `ProfileScreen.build`
  (same pattern already used in `_ProfileTile`).
- Name `Text` color: `AppColors.text` → `cs.onSurface` (resolves to
  light/dark automatically via the app's `ThemeData`).

## Not changed

- Email text (`AppColors.mutedText`) has the same latent bug but wasn't
  in scope of this request — flagged, not touched.
- Avatar, tiles, layout — untouched.
