# Sign In / Sign Up Mobile Overflow Fix

## Problem

Both `sign_in_mobile_screen.dart` and `sign_up_mobile_screen.dart` build a
`Stack` with:

1. A red top `Container` with a **fixed** `height: 480` holding a `Column`
   (logo, headline, form fields, primary button, "or / sign up" row).
2. A second, separate bottom section (`Align(bottomCenter)` +
   `Padding(bottom: 100)` + `Column`) containing a **duplicate** primary
   button, "or" text, and sign-up/login link, using the same controllers.

Root causes of the overflow (`RenderFlex overflowed by X pixels`):

- The red `Container` height is hardcoded to `480`, but its `Column`
  content (with keyboard-safe padding, error labels, spacing) exceeds
  480px on smaller devices (e.g. iPhone SE, small Android) → vertical
  overflow inside the container.
- `resizeToAvoidBottomInset: false` means the keyboard does not resize the
  view, so focusing an input can push fixed-position content (bottom
  `Align`) off-screen / overlapping the keyboard instead of scrolling.
- `sign_up_mobile_screen.dart` additionally renders a **second, dead copy**
  of the First Name / Last Name / Email / Password fields directly under
  the form card (lines ~196-244), duplicating controllers and inflating
  the top Column's height even further.
- Neither screen wraps its top-section `Column` in a `SingleChildScrollView`,
  so there is no scroll fallback when content legitimately exceeds the
  viewport.

## Fix Plan

1. **sign_up_mobile_screen.dart**: delete the dead duplicate field block
   (Row of first/last name, email field, password field placed after the
   form card, ~lines 196-244) — the real fields already live inside the
   form card above.
2. Replace the fixed-height red `Container` (`height: 480`) with one sized
   by its content (remove fixed `height`, keep padding/decoration), and
   wrap the screen body in a `SingleChildScrollView` so content can scroll
   instead of overflowing on small screens / when the keyboard opens.
3. Remove the redundant bottom `Align` duplicate button/link sections in
   both screens (the in-flow button + "or" + link inside the top Column
   already cover this) — having both is dead UI and a second overflow
   source.
4. Set `resizeToAvoidBottomInset: true` (default) so the keyboard doesn't
   collide with fixed-position content.
5. Verify both screens render without overflow at small viewport sizes
   (e.g. 360x640) and with the keyboard open on an input field.
