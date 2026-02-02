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
