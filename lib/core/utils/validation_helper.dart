import 'package:flutter/material.dart';
import 'package:coubot/generated/l10n.dart';

/// FormValidator is used to validate the form fields
class FormValidator {
  /// validateEmail
  static String? validateEmail(String? email, BuildContext context) {
    // Improved regex pattern to validate email addresses
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (email == null || email.isEmpty) {
      return S.of(context).emailIsRequired;
    } else if (!emailRegex.hasMatch(email)) {
      return S.of(context).pleaseEnterAValidEmailAddress;
    }
    return null;
  }

  /// validatePassword
  static String? validatePassword(String? password, BuildContext context) {
    const minLength = 6;
    if (password == null || password.isEmpty) {
      return S.of(context).passwordIsRequired;
    } else if (password.length < minLength) {
      return S.of(context).passwordMustBeAtLeastNumberCharacters(minLength);
    }
    return null;
  }

  /// validateFirstName
  static String? validateFirstName(String? firstName, BuildContext context) {
    if (firstName == null || firstName.isEmpty) {
      return S.of(context).firstNameIsRequired;
    }
    return null;
  }

  /// validateLastName
  static String? validateLastName(String? lastName, BuildContext context) {
    if (lastName == null || lastName.isEmpty) {
      return S.of(context).secondNameIsRequired;
    }
    return null;
  }

  /// validatePhoneNumber
  static String? validatePhoneNumber(
    String? phoneNumber,
    BuildContext context,
  ) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return S.of(context).phoneNumberIsRequired;
    } else if (phoneNumber.length < 6) {
      return S.of(context).pleaseEnterAValidPhoneNumber;
    }
    return null;
  }

  /// validateForm
  static bool validateForm(GlobalKey<FormState> formKey) {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) {
      return false;
    }
    formState.save();
    return true;
  }

  /// validateNewPassword
  static String? validateNewPassword(
    String? newPassword,
    BuildContext context,
  ) {
    const minLength = 6;
    if (newPassword == null || newPassword.isEmpty) {
      return S.of(context).passwordIsRequired;
    } else if (newPassword.length < minLength) {
      return S.of(context).passwordMustBeAtLeastNumberCharacters(minLength);
    }
    return null;
  }

  /// validateConfirmPassword
  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
    BuildContext context,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return S.of(context).confirmPasswordIsRequired;
    } else if (password != confirmPassword) {
      return S.of(context).passwordsDoNotMatch;
    }
    return null;
  }
}
