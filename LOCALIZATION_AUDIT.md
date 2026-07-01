# Coubot – Localization Audit

**Date:** 2026-06-18  
**Languages:** EN (English) · AR (Arabic)  
**Tool:** `flutter_intl` (plugin-based, ARB → generated `lib/generated/intl/messages_ar.dart`)

---

## How localization works in this project

```
lib/l10n/intl_en.arb   ─── flutter_intl generates ──▶  lib/generated/intl/messages_en.dart
lib/l10n/intl_ar.arb   ─────────────────────────────▶  lib/generated/intl/messages_ar.dart
                                                         lib/generated/l10n.dart  (S class)
```

`S.of(context).key` looks up the current locale's message map at runtime.  
`MainCubit.changeLang()` calls `S.load(Locale(code))` which reloads the map.  
`AppLayoutScreen` rebuilds via `BlocBuilder<MainCubit>` (fixed in this session).

---

## Issue 1 — Missing Arabic translations in `intl_ar.arb` (CRITICAL)

The file at `lib/l10n/intl_ar.arb` contains **104 keys**. Only **28** are actually translated to Arabic. The remaining **76** still carry the English value and will therefore display in English when AR locale is active.

### Untranslated keys grouped by feature

#### Bottom Navigation Bar *(visible on every screen)*
| Key | Current AR value | Required Arabic |
|-----|-----------------|-----------------|
| `home` | `"Home"` | `"الرئيسية"` |
| `orders` | `"Orders"` | `"الطلبات"` |
| `profile` | `"Profile"` | `"الملف الشخصي"` |

#### Cart Screen
| Key | Current AR value | Required Arabic |
|-----|-----------------|-----------------|
| `myCart` | `"My Cart"` | `"سلتي"` |
| `checkout` | `"Checkout"` | `"إتمام الطلب"` |
| `total` | `"Total"` | `"الإجمالي"` |
| `delivery` | `"Delivery"` | `"التوصيل"` |
| `subtotal` | `"Subtotal"` | `"المجموع الفرعي"` |
| `cartIsEmpty` | `"Cart is empty"` | `"السلة فارغة"` |

#### Auth – Sign In / Sign Up
| Key | Current AR value | Required Arabic |
|-----|-----------------|-----------------|
| `email` | `"Email"` | `"البريد الإلكتروني"` |
| `password` | `"Password"` | `"كلمة المرور"` |
| `forgotPassword` | `"Forgot password?"` | `"نسيت كلمة المرور؟"` |
| `login` | `"Login"` | `"تسجيل الدخول"` |
| `firstName` | `"First Name"` | `"الاسم الأول"` |
| `lastName` | `"Last Name"` | `"اسم العائلة"` |
| `or` | `"OR"` | `"أو"` |
| `signUpIfYoureNew` | `"Sign up if you're new"` | `"سجّل إذا كنت جديداً"` |
| `username` | `"User-name"` | `"اسم المستخدم"` |
| `signUp` | `"Sign Up"` | `"إنشاء حساب"` |
| `loginInIfYouHaveAnAccount` | `"Login in if you have an account"` | `"تسجيل الدخول إذا كان لديك حساب"` |
| `resendCode` | `"Resend Code"` | `"إعادة إرسال الرمز"` |
| `confirm` | `"Confirm"` | `"تأكيد"` |
| `codeSent` | `"Code Sent"` | `"تم إرسال الرمز"` |
| `continueWithEmail` | `"Continue with E-mail"` | `"المتابعة بالبريد الإلكتروني"` |
| `yourFavoriteFoodndeliveredToYou` | `"Your favorite food\nDelivered to you"` | `"طعامك المفضل\nيصلك إليك"` |
| `sendAgain` | `"Send Again"` | `"إعادة الإرسال"` |
| `enterTheEmailCode` | `"Enter the Email Code"` | `"أدخل رمز البريد الإلكتروني"` |
| `justWaitASecond` | `"Just Wait a Second"` | `"انتظر لحظة"` |

#### Validation & Error Messages
| Key | Current AR value | Required Arabic |
|-----|-----------------|-----------------|
| `emailIsRequired` | `"Email is required."` | `"البريد الإلكتروني مطلوب."` |
| `pleaseEnterAValidEmailAddress` | `"Please enter a valid email address."` | `"الرجاء إدخال بريد إلكتروني صحيح."` |
| `passwordIsRequired` | `"Password is required."` | `"كلمة المرور مطلوبة."` |
| `passwordMustBeAtLeastNumberCharacters` | `"Password must be at least {minLength} characters."` | `"يجب أن تحتوي كلمة المرور على {minLength} أحرف على الأقل."` |
| `firstNameIsRequired` | `"First name is required."` | `"الاسم الأول مطلوب."` |
| `secondNameIsRequired` | `"Second name is required."` | `"الاسم الثاني مطلوب."` |
| `confirmPasswordIsRequired` | `"Confirm password is required"` | `"تأكيد كلمة المرور مطلوب"` |
| `passwordsDoNotMatch` | `"Passwords do not match"` | `"كلمتا المرور غير متطابقتين"` |
| `passwordUpdatedSuccessfully` | `"Password updated successfully"` | `"تم تحديث كلمة المرور بنجاح"` |
| `invalidCurrentPassword` | `"Invalid current password."` | `"كلمة المرور الحالية غير صحيحة."` |
| `signInFailedPleaseTryAgain` | `"Sign in failed, please try again"` | `"فشل تسجيل الدخول، يرجى المحاولة مرة أخرى"` |
| `anErrorOccurred` | `"An error occurred"` | `"حدث خطأ"` |
| `somethingWentWrongPleaseTryAgainLater` | `"Something went wrong, please try again later"` | `"حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقاً"` |
| `authenticationError` | `"Authentication Error"` | `"خطأ في المصادقة"` |
| `checkYourEmailForTheConfirmationLink` | `"Check your email for the Confirmation link"` | `"تحقق من بريدك الإلكتروني للرابط التأكيدي"` |
| `error` | `"Error"` | `"خطأ"` |
| `wait` | `"Wait ..."` | `"جاري التحميل..."` |
| `noInternetConnection` | `"No internet connection"` | `"لا يوجد اتصال بالإنترنت"` |
| `unknownErrorOccurred` | `"Unknown error occurred"` | `"حدث خطأ غير معروف"` |
| `internalServerError` | `"Internal server error"` | `"خطأ في الخادم الداخلي"` |
| `oppsThereWasAnErrorPleaseTryAgain` | `"opps there was an error, please try again"` | `"عذراً، حدث خطأ، يرجى المحاولة مرة أخرى"` |
| `emailHasBeenUpdatedSuccessfully` | `"Email Has Been Updated Successfully"` | `"تم تحديث البريد الإلكتروني بنجاح"` |
| `noCurrentUserFoundOrCurrentUsersEmailIsNull` | `"No current user found..."` | `"لم يتم العثور على مستخدم حالي..."` |
| `no` | `"No"` | `"لا"` |
| `endThisProcess` | `"End This Process"` | `"إنهاء هذه العملية"` |
| `phoneNumberIsRequired` | `"Phone number is required"` | `"رقم الهاتف مطلوب"` |
| `pleaseEnterAValidPhoneNumber` | `"Please enter a valid phone number"` | `"الرجاء إدخال رقم هاتف صحيح"` |
| `addAdditionalDetails` | `"Add Additional Details"` | `"أضف تفاصيل إضافية"` |
| `signinWithAppleIdWasCanceledOrFailed` | `"Sign-in with Apple ID was canceled or failed."` | `"تم إلغاء تسجيل الدخول بمعرف Apple أو فشل."` |
| `errorCreatingChat` | `"Error creating chat"` | `"خطأ في إنشاء المحادثة"` |
| `noNotificationsAvailable` | `"No notifications available."` | `"لا توجد إشعارات متاحة."` |
| `failedToLoadNotifications` | `"Failed to load notifications:"` | `"فشل تحميل الإشعارات:"` |

#### Network/API Errors (lower priority — usually logged, rarely shown to user)
| Key | Current AR value |
|-----|-----------------|
| `connectionTimeoutWithApiserver` | still English |
| `sendTimeoutWithApiserver` | still English |
| `receiveTimeoutInConnectionWithApiserver` | still English |
| `badCertificateWithApiserver` | still English |
| `badResponseFromApiserver` | still English |
| `requestToApiserverWasCancelled` | still English |
| `connectionErrorWithApiserver` | still English |

---

## Issue 2 — Category names are DB-driven with no Arabic support (MEDIUM)

**File:** `lib/features/home/data/datasources/home_remote_datasource.dart:80`  
**Entity:** `lib/features/home/domain/entities/category_entity.dart`

Categories are fetched from the `categories` Supabase table. The `name` column is English-only. The `CategoryEntity` has a single `title` field with no `titleAr` equivalent.

When AR locale is active, section headers on the Home screen still show English category names (e.g., "Burgers", "Dinks").

**Fix options:**
- **Option A (recommended):** Add `name_ar TEXT` column to the `categories` table. Fetch both `name` and `name_ar`. Add `titleAr` to `CategoryEntity`. Pick the right one based on `MainCubit.currentLangCode`.
- **Option B (no DB change):** Add a local lookup map in the app (`const Map<String, String> _categoryArNames`) keyed by English name. Fragile if DB names change.

---

## Issue 3 — Hardcoded English string in orders_screen.dart (LOW)

**File:** `lib/features/orders/presentation/screens/orders_screen.dart:436`

```dart
const SnackBar(content: Text('Coming soon'))
```

This string is not localized. Add a `comingSoon` key to both ARB files.

---

## Summary of files to change

| File | Action |
|------|--------|
| `lib/l10n/intl_ar.arb` | Translate all 76 missing keys |
| `lib/generated/intl/messages_ar.dart` | Regenerate (auto via `flutter pub get` with flutter_intl plugin) |
| `lib/features/home/domain/entities/category_entity.dart` | Add `titleAr` field |
| `lib/features/home/data/datasources/home_remote_datasource.dart` | Fetch `name_ar`, populate `titleAr` |
| `lib/features/home/presentation/pages/home_screen_body.dart` | Use `titleAr` when locale is AR |
| `lib/features/orders/presentation/screens/orders_screen.dart:436` | Replace `'Coming soon'` with `S.of(context).comingSoon` |
| `lib/l10n/intl_en.arb` | Add `comingSoon` key |
| `lib/l10n/intl_ar.arb` | Add `comingSoon` Arabic translation |
| `supabase/seed.sql` | Add `name_ar` to categories INSERT (if Option A chosen) |

---

## Already translated correctly ✓

`myOrders`, `favourites`, `settings`, `logOut`, `appearance`, `darkMode`, `language`, `notifications`, `pushNotifications`, `about`, `appVersion`, `active`, `completed`, `cancelled`, `noActiveOrders`, `reorder`, `review`, `leaveAReview`, `howWasYourOrder`, `cancel`, `submit`, `reviewAddedSuccessfully`, `noFavouritesYet`, `tapHeartToSaveFavourites`, `onSale`, `quantity`, `addToCart`, `noItemsAvailable`, `noProductsFound`, `searchProducts`, `seeAll`, `orderPlacedSuccessfully`, `failedToPlaceOrder`
