// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email is required.`
  String get emailIsRequired {
    return Intl.message(
      'Email is required.',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get pleaseEnterAValidEmailAddress {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'pleaseEnterAValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password is required.`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required.',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {minLength} characters.`
  String passwordMustBeAtLeastNumberCharacters(Object minLength) {
    return Intl.message(
      'Password must be at least $minLength characters.',
      name: 'passwordMustBeAtLeastNumberCharacters',
      desc: '',
      args: [minLength],
    );
  }

  /// `First name is required.`
  String get firstNameIsRequired {
    return Intl.message(
      'First name is required.',
      name: 'firstNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Second name is required.`
  String get secondNameIsRequired {
    return Intl.message(
      'Second name is required.',
      name: 'secondNameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again later`
  String get somethingWentWrongPleaseTryAgainLater {
    return Intl.message(
      'Something went wrong, please try again later',
      name: 'somethingWentWrongPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error`
  String get authenticationError {
    return Intl.message(
      'Authentication Error',
      name: 'authenticationError',
      desc: '',
      args: [],
    );
  }

  /// `Check your email for the Confirmation link`
  String get checkYourEmailForTheConfirmationLink {
    return Intl.message(
      'Check your email for the Confirmation link',
      name: 'checkYourEmailForTheConfirmationLink',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with ApiServer`
  String get connectionTimeoutWithApiserver {
    return Intl.message(
      'Connection timeout with ApiServer',
      name: 'connectionTimeoutWithApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout with ApiServer`
  String get sendTimeoutWithApiserver {
    return Intl.message(
      'Send timeout with ApiServer',
      name: 'sendTimeoutWithApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with ApiServer`
  String get receiveTimeoutInConnectionWithApiserver {
    return Intl.message(
      'Receive timeout in connection with ApiServer',
      name: 'receiveTimeoutInConnectionWithApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Bad certificate with ApiServer`
  String get badCertificateWithApiserver {
    return Intl.message(
      'Bad certificate with ApiServer',
      name: 'badCertificateWithApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Bad response from ApiServer`
  String get badResponseFromApiserver {
    return Intl.message(
      'Bad response from ApiServer',
      name: 'badResponseFromApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Request to ApiServer was cancelled`
  String get requestToApiserverWasCancelled {
    return Intl.message(
      'Request to ApiServer was cancelled',
      name: 'requestToApiserverWasCancelled',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Connection error with ApiServer`
  String get connectionErrorWithApiserver {
    return Intl.message(
      'Connection error with ApiServer',
      name: 'connectionErrorWithApiserver',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error occurred`
  String get unknownErrorOccurred {
    return Intl.message(
      'Unknown error occurred',
      name: 'unknownErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `opps there was an error, please try again`
  String get oppsThereWasAnErrorPleaseTryAgain {
    return Intl.message(
      'opps there was an error, please try again',
      name: 'oppsThereWasAnErrorPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Wait ...`
  String get wait {
    return Intl.message(
      'Wait ...',
      name: 'wait',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Password updated successfully',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No current user found or current user's email is null.`
  String get noCurrentUserFoundOrCurrentUsersEmailIsNull {
    return Intl.message(
      'No current user found or current user\'s email is null.',
      name: 'noCurrentUserFoundOrCurrentUsersEmailIsNull',
      desc: '',
      args: [],
    );
  }

  /// `Invalid current password.`
  String get invalidCurrentPassword {
    return Intl.message(
      'Invalid current password.',
      name: 'invalidCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `End This Process`
  String get endThisProcess {
    return Intl.message(
      'End This Process',
      name: 'endThisProcess',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is required`
  String get phoneNumberIsRequired {
    return Intl.message(
      'Phone number is required',
      name: 'phoneNumberIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get pleaseEnterAValidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'pleaseEnterAValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Add Additional Details`
  String get addAdditionalDetails {
    return Intl.message(
      'Add Additional Details',
      name: 'addAdditionalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in with Apple ID was canceled or failed.`
  String get signinWithAppleIdWasCanceledOrFailed {
    return Intl.message(
      'Sign-in with Apple ID was canceled or failed.',
      name: 'signinWithAppleIdWasCanceledOrFailed',
      desc: '',
      args: [],
    );
  }

  /// `Sign in failed, please try again`
  String get signInFailedPleaseTryAgain {
    return Intl.message(
      'Sign in failed, please try again',
      name: 'signInFailedPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Error creating chat`
  String get errorCreatingChat {
    return Intl.message(
      'Error creating chat',
      name: 'errorCreatingChat',
      desc: '',
      args: [],
    );
  }

  /// `No notifications available.`
  String get noNotificationsAvailable {
    return Intl.message(
      'No notifications available.',
      name: 'noNotificationsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load notifications:`
  String get failedToLoadNotifications {
    return Intl.message(
      'Failed to load notifications:',
      name: 'failedToLoadNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Email Has Been Updated Successfully`
  String get emailHasBeenUpdatedSuccessfully {
    return Intl.message(
      'Email Has Been Updated Successfully',
      name: 'emailHasBeenUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Email Code`
  String get enterTheEmailCode {
    return Intl.message(
      'Enter the Email Code',
      name: 'enterTheEmailCode',
      desc: '',
      args: [],
    );
  }

  /// `Just Wait a Second`
  String get justWaitASecond {
    return Intl.message(
      'Just Wait a Second',
      name: 'justWaitASecond',
      desc: '',
      args: [],
    );
  }

  /// ` We’ve send a code to your email\n please enter code to reset your password`
  String get weveSendACodeToYourEmailnPleaseEnterCode {
    return Intl.message(
      ' We’ve send a code to your email\\n please enter code to reset your password',
      name: 'weveSendACodeToYourEmailnPleaseEnterCode',
      desc: '',
      args: [],
    );
  }

  /// `Send Again`
  String get sendAgain {
    return Intl.message(
      'Send Again',
      name: 'sendAgain',
      desc: '',
      args: [],
    );
  }

  /// `Continue with E-mail`
  String get continueWithEmail {
    return Intl.message(
      'Continue with E-mail',
      name: 'continueWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Connect with Facebook`
  String get connectWithFacebook {
    return Intl.message(
      'Connect with Facebook',
      name: 'connectWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Your favorite food\nDelivered to you`
  String get yourFavoriteFoodndeliveredToYou {
    return Intl.message(
      'Your favorite food\\nDelivered to you',
      name: 'yourFavoriteFoodndeliveredToYou',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message(
      'OR',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Sign up if you’re new`
  String get signUpIfYoureNew {
    return Intl.message(
      'Sign up if you’re new',
      name: 'signUpIfYoureNew',
      desc: '',
      args: [],
    );
  }

  /// `User-name`
  String get username {
    return Intl.message(
      'User-name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Login in if you have an account`
  String get loginInIfYouHaveAnAccount {
    return Intl.message(
      'Login in if you have an account',
      name: 'loginInIfYouHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Code Sent`
  String get codeSent {
    return Intl.message(
      'Code Sent',
      name: 'codeSent',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `COUBOT`
  String get coubot {
    return Intl.message(
      'COUBOT',
      name: 'coubot',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get myCart {
    return Intl.message(
      'My Cart',
      name: 'myCart',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Cart is empty`
  String get cartIsEmpty {
    return Intl.message(
      'Cart is empty',
      name: 'cartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get pushNotifications {
    return Intl.message(
      'Push Notifications',
      name: 'pushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appVersion {
    return Intl.message(
      'App Version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message(
      'Cancelled',
      name: 'cancelled',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any\nactive orders at this time`
  String get noActiveOrders {
    return Intl.message(
      'You don\'t have any\nactive orders at this time',
      name: 'noActiveOrders',
      desc: '',
      args: [],
    );
  }

  /// `Reorder`
  String get reorder {
    return Intl.message(
      'Reorder',
      name: 'reorder',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Leave a Review`
  String get leaveAReview {
    return Intl.message(
      'Leave a Review',
      name: 'leaveAReview',
      desc: '',
      args: [],
    );
  }

  /// `How was your order?`
  String get howWasYourOrder {
    return Intl.message(
      'How was your order?',
      name: 'howWasYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Review added successfully`
  String get reviewAddedSuccessfully {
    return Intl.message(
      'Review added successfully',
      name: 'reviewAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No favourites yet`
  String get noFavouritesYet {
    return Intl.message(
      'No favourites yet',
      name: 'noFavouritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Tap the heart on any item to save it here`
  String get tapHeartToSaveFavourites {
    return Intl.message(
      'Tap the heart on any item to save it here',
      name: 'tapHeartToSaveFavourites',
      desc: '',
      args: [],
    );
  }

  /// `ON SALE`
  String get onSale {
    return Intl.message(
      'ON SALE',
      name: 'onSale',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `ADD TO CART`
  String get addToCart {
    return Intl.message(
      'ADD TO CART',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `No items available`
  String get noItemsAvailable {
    return Intl.message(
      'No items available',
      name: 'noItemsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Search products...`
  String get searchProducts {
    return Intl.message(
      'Search products...',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message(
      'See all',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully!`
  String get orderPlacedSuccessfully {
    return Intl.message(
      'Order placed successfully!',
      name: 'orderPlacedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to place order. Please try again.`
  String get failedToPlaceOrder {
    return Intl.message(
      'Failed to place order. Please try again.',
      name: 'failedToPlaceOrder',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get comingSoon {
    return Intl.message(
      'Coming soon',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Transform timeout with API server`
  String get transformTimeoutWithApiServer {
    return Intl.message(
      'Transform timeout with API server',
      name: 'transformTimeoutWithApiServer',
      desc: '',
      args: [],
    );
  }

  /// `AI Recommendation`
  String get aiRecommendationTitle {
    return Intl.message(
      'AI Recommendation',
      name: 'aiRecommendationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Not sure what to eat?\nLet AI choose something you'll love.`
  String get aiRecommendationSubtitle {
    return Intl.message(
      'Not sure what to eat?\nLet AI choose something you\'ll love.',
      name: 'aiRecommendationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Recommend`
  String get aiRecommendButton {
    return Intl.message(
      'Recommend',
      name: 'aiRecommendButton',
      desc: '',
      args: [],
    );
  }

  /// `AI recommendation is unavailable`
  String get aiRecommendationUnavailable {
    return Intl.message(
      'AI recommendation is unavailable',
      name: 'aiRecommendationUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `AI pick`
  String get aiPick {
    return Intl.message(
      'AI pick',
      name: 'aiPick',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} min`
  String minutesShort(Object minutes) {
    return Intl.message(
      '$minutes min',
      name: 'minutesShort',
      desc: '',
      args: [minutes],
    );
  }

  /// `Try Another`
  String get tryAnother {
    return Intl.message(
      'Try Another',
      name: 'tryAnother',
      desc: '',
      args: [],
    );
  }

  /// `Order Now`
  String get orderNow {
    return Intl.message(
      'Order Now',
      name: 'orderNow',
      desc: '',
      args: [],
    );
  }

  /// `The recommendation function is still using the old category field. Restart or redeploy the Supabase function, then try again.`
  String get aiRecommendationOutdatedFunction {
    return Intl.message(
      'The recommendation function is still using the old category field. Restart or redeploy the Supabase function, then try again.',
      name: 'aiRecommendationOutdatedFunction',
      desc: '',
      args: [],
    );
  }

  /// `Gemini is busy right now. Please try again in a moment.`
  String get aiBusyTryAgain {
    return Intl.message(
      'Gemini is busy right now. Please try again in a moment.',
      name: 'aiBusyTryAgain',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
