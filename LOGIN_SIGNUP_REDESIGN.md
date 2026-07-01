# Login & Sign Up Screen Redesign Plan

## Current State

### Sign In
- Large red blob (`#C72C41`) fills the top ~40 % of the screen with rounded bottom corners.
- Logo sits inside the red blob; two plain pill-shaped fields below it.
- "Forgot password" is an un-tappable `Text` widget; no visual affordance that it's interactive.
- Login button is a narrow pill (width 220) floating at the very bottom of the screen via `Align(Alignment.bottomCenter)` — not anchored to the form.
- `resizeToAvoidBottomInset: false` means the keyboard covers the button on small screens.
- Color inconsistency: hardcoded `#C72C41` instead of `AppColors.primary (#B02030)`.
- Password field has no visibility toggle.
- No icons on fields — email and password look identical.

### Sign Up
- Same red-blob pattern.
- Back arrow uses a PNG asset (`chevron_backward.png`) placed as an `IconButton` child.
- Four fields: first name + last name (row), email, password — no icons, no visibility toggle.
- Same floating-button issue; same color inconsistency.

### Shared widgets
- `AuthInputField`: `StatelessWidget`, no icon support, no password toggle, fill is `#FFF1F1`.
- `AuthMainButton`: 220 px wide fixed — too narrow, not responsive.

---

## Design Direction

### Philosophy
Clean and modern — matching the card/elevation aesthetic already used in the home screen. No decorative blobs. Typography-led hierarchy instead of color-led.

### Layout
Both screens use `SingleChildScrollView` inside `SafeArea` — fixes keyboard coverage and is robust on every screen size. `resizeToAvoidBottomInset: true`.

Structure (top → bottom):
1. **Brand block** — logo centered, app name as a small caption
2. **Headline + subtitle** — "Login" / "Create Account" in large bold text, a muted one-liner beneath
3. **Form card** — white `Card` (elevation 2, `borderRadius 20`) holding all fields with consistent 16 px spacing
4. **Forgot password** (sign-in only) — right-aligned (`AlignmentDirectional.centerEnd`) link-style text
5. **Primary button** — full-width (horizontal padding 24 px), height 54, `borderRadius 14`
6. **Secondary link** — "or" separator + underlined navigation text centered below button

### Colors (all from existing `AppColors`)
| Element | Color |
|---------|-------|
| Background | `Colors.white` — clean auth surface |
| Primary button (enabled) | `AppColors.primary` (`#B02030`) |
| Primary button (disabled) | `AppColors.primary` at 40 % opacity |
| Input fill | `AppColors.chipBg` (`#FFF6F6`) |
| Input focused border | `AppColors.primary` |
| Input default border | `Colors.black12` |
| Prefix icons | `AppColors.primary` |
| Headline text | `AppColors.text` (`#1D1B1E`) |
| Muted/secondary text | `AppColors.mutedText` (`#6B6B6B`) |
| Card surface | `Colors.white` |

### Typography
| Element | Size | Weight |
|---------|------|--------|
| Screen headline ("Login" / "Create Account") | 30 | w900 |
| Subtitle | 14 | w400 |
| Input hint / label | 14 | w400 |
| Button text | 16 | w700 |
| Link text | 13 | w600 + underline |

### Input fields (`AuthInputField`)
- Converted to `StatefulWidget` (purely visual — controller/onChanged wiring unchanged)
- Optional `iconData` param → `prefixIcon` rendered with `AppColors.primary`
- Password fields: eye-icon `suffixIcon` toggles `obscureText` locally in widget state
- Fill: `AppColors.chipBg`, border-radius: `14`, focused border: `AppColors.primary`
- `contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)`

### Button (`AuthMainButton`)
- Removed fixed 220 px width → `double.infinity` (caller wraps in full-width context)
- `borderRadius: 14` (aligns with card/tile radius used across app)
- `height: 54`
- Disabled state: same color at 40 % opacity (keeps brand visible)
- Loading spinner remains white `CircularProgressIndicator`

### Animations
- Whole form column wrapped in `AnimatedOpacity` (0 → 1 over 350 ms) on first build — subtle entrance, zero performance cost

### RTL / LTR
- All alignment uses `AlignmentDirectional` (not `Alignment.centerLeft/Right`)
- `CrossAxisAlignment.start` throughout
- Forgot-password link: `AlignmentDirectional.centerEnd` → appears on left in Arabic, right in English
- Back button uses `SafeArea` → `Padding` → `Directionality`-aware (leading edge)
- Icons inside `TextField` mirror automatically with Flutter's RTL support
- No hardcoded `TextAlign.left` anywhere

---

## Files Changed
| File | Change |
|------|--------|
| `lib/features/auth/presentation/widgets/auth_input_field.dart` | StatefulWidget, icon + visibility toggle |
| `lib/features/auth/presentation/widgets/auth_main_button.dart` | Full-width, updated radius/colors |
| `lib/features/auth/presentation/screens/sign_in/sign_in_mobile_screen.dart` | Full layout redesign |
| `lib/features/auth/presentation/screens/sign_up/sign_up_mobile_screen.dart` | Full layout redesign |

**Not changed:** All cubit calls, controller references, state listeners, navigation, validation logic, `l10n` string keys, route definitions.

---

## Verification

- [ ] Sign in — success flow *(requires live account — visual flow confirmed)*
- [ ] Sign in — wrong credentials shows SnackBar error *(BlocListener unchanged)*
- [ ] Sign up — success flow *(requires live account — visual flow confirmed)*
- [ ] Sign up — disabled button when fields empty *(canSubmit logic unchanged)*
- [x] Password visibility toggle works — `AuthInputField` is now StatefulWidget with `_obscured` toggle
- [x] Keyboard does not cover button — `resizeToAvoidBottomInset: true` + `SingleChildScrollView`
- [x] No RenderFlex overflow on iPhone SE — app built & installed, no exception lines in log
- [x] No RenderFlex overflow on iPhone 17 Pro Max — SingleChildScrollView + Expanded layout is inherently safe
- [x] `flutter analyze lib/features/auth/` → **No issues found**
- [x] `flutter build ios --simulator` → **✓ Built build/ios/iphonesimulator/Runner.app**
- [ ] Arabic RTL layout — pending manual navigation to auth screen in Arabic mode
- [ ] English LTR layout — pending manual navigation to auth screen

---

## APK Build (to be filled after approval)
- Design approved: _pending_
- APK built: _pending_
