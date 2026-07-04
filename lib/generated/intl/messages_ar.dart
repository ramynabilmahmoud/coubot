// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(name, qty) => "${name} أضيف إلى السلة (x${qty})";

  static String m1(time) => "الوصول خلال ${time}";

  static String m2(minutes) => "${minutes} دقيقة";

  static String m3(orderId, status) =>
      "طلبك رقم #${orderId} أصبح الآن ${status}";

  static String m4(minLength) =>
      "يجب أن تحتوي كلمة المرور على ${minLength} أحرف على الأقل.";

  static String m5(method) => "ادفع عبر ${method}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("حول"),
        "active": MessageLookupByLibrary.simpleMessage("نشطة"),
        "addAdditionalDetails":
            MessageLookupByLibrary.simpleMessage("أضف تفاصيل إضافية"),
        "addToCart": MessageLookupByLibrary.simpleMessage("أضف إلى السلة"),
        "addedToCartWithQty": m0,
        "aiBusyTryAgain": MessageLookupByLibrary.simpleMessage(
            "Gemini مشغول حالياً. حاول مرة أخرى بعد قليل."),
        "aiPick":
            MessageLookupByLibrary.simpleMessage("اختيار الذكاء الاصطناعي"),
        "aiRecommendButton": MessageLookupByLibrary.simpleMessage("اقترح"),
        "aiRecommendationOutdatedFunction": MessageLookupByLibrary.simpleMessage(
            "دالة التوصية لا تزال تستخدم حقل الفئة القديم. أعد تشغيل أو إعادة نشر دالة Supabase، ثم حاول مرة أخرى."),
        "aiRecommendationSubtitle": MessageLookupByLibrary.simpleMessage(
            "لست متأكدًا مما تريد أكله؟\nدع الذكاء الاصطناعي يختار لك شيئًا ستحبه."),
        "aiRecommendationTitle":
            MessageLookupByLibrary.simpleMessage("توصية الذكاء الاصطناعي"),
        "aiRecommendationUnavailable": MessageLookupByLibrary.simpleMessage(
            "توصية الذكاء الاصطناعي غير متاحة"),
        "anErrorOccurred": MessageLookupByLibrary.simpleMessage("حدث خطأ"),
        "appVersion": MessageLookupByLibrary.simpleMessage("إصدار التطبيق"),
        "appearance": MessageLookupByLibrary.simpleMessage("المظهر"),
        "arrivingAnyMoment":
            MessageLookupByLibrary.simpleMessage("الوصول في أي لحظة"),
        "arrivingInTime": m1,
        "authenticationError":
            MessageLookupByLibrary.simpleMessage("خطأ في المصادقة"),
        "badCertificateWithApiserver":
            MessageLookupByLibrary.simpleMessage("شهادة الخادم غير صالحة"),
        "badResponseFromApiserver":
            MessageLookupByLibrary.simpleMessage("استجابة غير صالحة من الخادم"),
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "cancelled": MessageLookupByLibrary.simpleMessage("ملغاة"),
        "cartIsEmpty": MessageLookupByLibrary.simpleMessage("السلة فارغة"),
        "checkYourEmailForTheConfirmationLink":
            MessageLookupByLibrary.simpleMessage(
                "تحقق من بريدك الإلكتروني للرابط التأكيدي"),
        "checkout": MessageLookupByLibrary.simpleMessage("إتمام الطلب"),
        "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
        "codeSent": MessageLookupByLibrary.simpleMessage("تم إرسال الرمز"),
        "comingSoon": MessageLookupByLibrary.simpleMessage("قريباً"),
        "completed": MessageLookupByLibrary.simpleMessage("مكتملة"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmPasswordIsRequired":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور مطلوب"),
        "connectWithFacebook":
            MessageLookupByLibrary.simpleMessage("الاتصال عبر فيسبوك"),
        "connectionErrorWithApiserver":
            MessageLookupByLibrary.simpleMessage("خطأ في الاتصال بالخادم"),
        "connectionTimeoutWithApiserver":
            MessageLookupByLibrary.simpleMessage("انتهت مهلة الاتصال بالخادم"),
        "continueWithEmail":
            MessageLookupByLibrary.simpleMessage("المتابعة بالبريد الإلكتروني"),
        "coubot": MessageLookupByLibrary.simpleMessage("COUBOT"),
        "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الداكن"),
        "delivery": MessageLookupByLibrary.simpleMessage("التوصيل"),
        "eWallet": MessageLookupByLibrary.simpleMessage("المحفظة الإلكترونية"),
        "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "emailHasBeenUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "تم تحديث البريد الإلكتروني بنجاح"),
        "emailIsRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب."),
        "endThisProcess":
            MessageLookupByLibrary.simpleMessage("إنهاء هذه العملية"),
        "enterTheEmailCode":
            MessageLookupByLibrary.simpleMessage("أدخل رمز البريد الإلكتروني"),
        "error": MessageLookupByLibrary.simpleMessage("خطأ"),
        "errorCreatingChat":
            MessageLookupByLibrary.simpleMessage("خطأ في إنشاء المحادثة"),
        "failedToLoadNotifications":
            MessageLookupByLibrary.simpleMessage("فشل تحميل الإشعارات:"),
        "failedToPlaceOrder": MessageLookupByLibrary.simpleMessage(
            "فشل تقديم الطلب. حاول مرة أخرى."),
        "favourites": MessageLookupByLibrary.simpleMessage("المفضلة"),
        "firstName": MessageLookupByLibrary.simpleMessage("الاسم الأول"),
        "firstNameIsRequired":
            MessageLookupByLibrary.simpleMessage("الاسم الأول مطلوب."),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "howWasYourOrder":
            MessageLookupByLibrary.simpleMessage("كيف كان طلبك؟"),
        "instapay": MessageLookupByLibrary.simpleMessage("إنستاباي"),
        "internalServerError":
            MessageLookupByLibrary.simpleMessage("خطأ في الخادم الداخلي"),
        "invalidCurrentPassword": MessageLookupByLibrary.simpleMessage(
            "كلمة المرور الحالية غير صحيحة."),
        "justWaitASecond": MessageLookupByLibrary.simpleMessage("انتظر لحظة"),
        "language": MessageLookupByLibrary.simpleMessage("اللغة"),
        "lastName": MessageLookupByLibrary.simpleMessage("اسم العائلة"),
        "leaveAReview": MessageLookupByLibrary.simpleMessage("أضف تقييماً"),
        "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "loginInIfYouHaveAnAccount": MessageLookupByLibrary.simpleMessage(
            "تسجيل الدخول إذا كان لديك حساب"),
        "minutesShort": m2,
        "myCart": MessageLookupByLibrary.simpleMessage("سلتي"),
        "myOrders": MessageLookupByLibrary.simpleMessage("طلباتي"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "noActiveOrders": MessageLookupByLibrary.simpleMessage(
            "ليس لديك أي\nطلبات نشطة في الوقت الحالي"),
        "noCurrentUserFoundOrCurrentUsersEmailIsNull":
            MessageLookupByLibrary.simpleMessage(
                "لم يتم العثور على مستخدم حالي أو أن بريده الإلكتروني فارغ."),
        "noFavouritesYet":
            MessageLookupByLibrary.simpleMessage("لا توجد مفضلة بعد"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("لا يوجد اتصال بالإنترنت"),
        "noItemsAvailable":
            MessageLookupByLibrary.simpleMessage("لا توجد عناصر متاحة"),
        "noNotificationsAvailable":
            MessageLookupByLibrary.simpleMessage("لا توجد إشعارات متاحة."),
        "noNotificationsYet":
            MessageLookupByLibrary.simpleMessage("لا توجد إشعارات بعد"),
        "noProductsFound":
            MessageLookupByLibrary.simpleMessage("لا توجد منتجات"),
        "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "onSale": MessageLookupByLibrary.simpleMessage("تخفيض"),
        "oppsThereWasAnErrorPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "عذراً، حدث خطأ، يرجى المحاولة مرة أخرى"),
        "or": MessageLookupByLibrary.simpleMessage("أو"),
        "orderNow": MessageLookupByLibrary.simpleMessage("اطلب الآن"),
        "orderPlacedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تقديم طلبك بنجاح!"),
        "orderStatusUpdateMessage": m3,
        "orderUpdate": MessageLookupByLibrary.simpleMessage("تحديث الطلب"),
        "orderUpdatesChannelDescription":
            MessageLookupByLibrary.simpleMessage("إشعارات حول حالة طلبك"),
        "orderUpdatesChannelName":
            MessageLookupByLibrary.simpleMessage("تحديثات الطلب"),
        "orders": MessageLookupByLibrary.simpleMessage("الطلبات"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordIsRequired":
            MessageLookupByLibrary.simpleMessage("كلمة المرور مطلوبة."),
        "passwordMustBeAtLeastNumberCharacters": m4,
        "passwordUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تحديث كلمة المرور بنجاح"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("كلمتا المرور غير متطابقتين"),
        "payVia": m5,
        "payment": MessageLookupByLibrary.simpleMessage("الدفع"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
        "phoneNumberIsRequired":
            MessageLookupByLibrary.simpleMessage("رقم الهاتف مطلوب"),
        "placeOrder": MessageLookupByLibrary.simpleMessage("تأكيد الطلب"),
        "pleaseEnterAValidEmailAddress": MessageLookupByLibrary.simpleMessage(
            "الرجاء إدخال بريد إلكتروني صحيح."),
        "pleaseEnterAValidPhoneNumber":
            MessageLookupByLibrary.simpleMessage("الرجاء إدخال رقم هاتف صحيح"),
        "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
        "pushNotifications":
            MessageLookupByLibrary.simpleMessage("الإشعارات الفورية"),
        "quantity": MessageLookupByLibrary.simpleMessage("الكمية"),
        "receiveTimeoutInConnectionWithApiserver":
            MessageLookupByLibrary.simpleMessage(
                "انتهت مهلة استقبال البيانات من الخادم"),
        "reorder": MessageLookupByLibrary.simpleMessage("إعادة الطلب"),
        "requestToApiserverWasCancelled":
            MessageLookupByLibrary.simpleMessage("تم إلغاء الطلب إلى الخادم"),
        "resendCode": MessageLookupByLibrary.simpleMessage("إعادة إرسال الرمز"),
        "review": MessageLookupByLibrary.simpleMessage("تقييم"),
        "reviewAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تمت إضافة التقييم بنجاح"),
        "searchProducts":
            MessageLookupByLibrary.simpleMessage("ابحث عن منتجات..."),
        "secondNameIsRequired":
            MessageLookupByLibrary.simpleMessage("الاسم الثاني مطلوب."),
        "seeAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
        "selectHall": MessageLookupByLibrary.simpleMessage("اختر القاعة"),
        "sendAgain": MessageLookupByLibrary.simpleMessage("إعادة الإرسال"),
        "sendTimeoutWithApiserver": MessageLookupByLibrary.simpleMessage(
            "انتهت مهلة إرسال الطلب إلى الخادم"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "signInFailedPleaseTryAgain": MessageLookupByLibrary.simpleMessage(
            "فشل تسجيل الدخول، يرجى المحاولة مرة أخرى"),
        "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "signUpIfYoureNew":
            MessageLookupByLibrary.simpleMessage("سجّل إذا كنت جديداً"),
        "signinWithAppleIdWasCanceledOrFailed":
            MessageLookupByLibrary.simpleMessage(
                "تم إلغاء تسجيل الدخول بمعرف Apple أو فشل."),
        "somethingWentWrongPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقاً"),
        "submit": MessageLookupByLibrary.simpleMessage("إرسال"),
        "subtotal": MessageLookupByLibrary.simpleMessage("المجموع الفرعي"),
        "tapHeartToSaveFavourites": MessageLookupByLibrary.simpleMessage(
            "اضغط على القلب في أي عنصر لحفظه هنا"),
        "total": MessageLookupByLibrary.simpleMessage("الإجمالي"),
        "transformTimeoutWithApiServer": MessageLookupByLibrary.simpleMessage(
            "Transform timeout with API server"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى"),
        "tryAnother": MessageLookupByLibrary.simpleMessage("جرّب اقتراحاً آخر"),
        "unknownErrorOccurred":
            MessageLookupByLibrary.simpleMessage("حدث خطأ غير معروف"),
        "uploadTransactionScreenshot":
            MessageLookupByLibrary.simpleMessage("ارفع لقطة شاشة للتحويل"),
        "username": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
        "wait": MessageLookupByLibrary.simpleMessage("جاري التحميل..."),
        "weveSendACodeToYourEmailnPleaseEnterCode":
            MessageLookupByLibrary.simpleMessage(
                "لقد أرسلنا رمزاً إلى بريدك الإلكتروني\\nيرجى إدخاله لإعادة تعيين كلمة المرور"),
        "yourFavoriteFoodndeliveredToYou":
            MessageLookupByLibrary.simpleMessage("طعامك المفضل\\nيصلك إليك")
      };
}
