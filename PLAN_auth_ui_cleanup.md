# Sign In / Sign Up UI Cleanup

Follow-up to [PLAN_auth_overflow_fix.md](PLAN_auth_overflow_fix.md). The overflow
is fixed, but the screens still carry duplicated widgets from the previous
redesign attempt, which now visibly render as two login/sign-up buttons.
Screenshot reference: red banner (logo, email, password, forgot password)
→ white area with a single wide pill button, "OR", link — no second button
visible inside the red banner (it's clipped by the fixed-height scroll fix).

## Changes (both `sign_in_mobile_screen.dart` and `sign_up_mobile_screen.dart`)

1. **Remove the duplicate button block** inside the red banner's `Column`
   (the `BlocBuilder` → `AuthMainButton` + "or" `Row` + sign-up/login link
   that currently sits right after the password/forgot-password field, still
   inside the fixed-height red `Container`). The screenshot's visible button
   is the *other* one, in the bottom `Align` section — that one stays.
   - Sign-up additionally has a **dead duplicate field block** (first/last
     name, email, password re-rendered with `textColor: Colors.black`,
     right after the real form card) — delete that too, same as the button.
2. **Reduce top padding** in the red banner: currently `Container` padding
   top is `60` plus a `SizedBox(height: 60)` before the logo = 120px of
   empty space above the logo. Cut the leading `SizedBox` down to `20` so
   the logo sits closer to the back-arrow/top edge.
3. **Widen the primary button** in the bottom section: it currently uses a
   fixed `width: 250`, centered, leaving large uneven side gaps. Replace
   the fixed width with `double.infinity` wrapped in
   `Padding(horizontal: 24)` (same horizontal margin as the email/password
   fields above), so the button aligns with the fields instead of floating
   as a narrow pill.

## Not changed

- Colors, fonts, border radius, the red banner shape, field styling.
- Cubit wiring, validation logic, navigation.
