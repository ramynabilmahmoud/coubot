import 'package:coubot/features/auth/data/models/additional_details__input_model.dart/additional_details_input_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// AuthRemoteDatasource is an abstract class that defines
///  the methods that will be implemented by the AuthRemoteDatasourceImpl class.
abstract class AuthRemoteDatasource {
  /// create a new user
  /// required fields: email, password
  Future<void> signUp(String email, String password);

  /// sign in a user
  /// required fields: email, password
  Future<void> signIn(String email, String password);

  /// recognize a user
  /// required fields: email
  /// returns: boolean value if the user is recognized
  /// or not
  Future<bool> recognize(String email);

  /// send otp to the user
  /// required fields: email, username
  Future<bool> resendOTP(String email, OtpType otpType);

  /// verify otp
  /// required fields: email, otp
  Future<AuthResponse> verifyOTP(String email, String otp, OtpType otpType);

  /// get the first name of existing user
  /// required fields: email
  /// returns: first name of the user
  Future<String> getFirstName(String email);

  /// forget password
  /// required fields: email
  Future<void> forgetPassword(String email);

  /// set new password
  /// required fields: password
  Future<void> updateUserPassword(String password);

  /// change email
  /// required fields: email
  Future<void> changeEmail(String email);

  /// sign in with apple
  Future<AuthResponse> signInWithApple();

  /// Add Additional Details
  /// required fields: first name, last name, and
  /// if any fields added in the future
  Future<UserResponse> addAdditionalDetails(
    AdditionalDetailsInputModel inputModel,
  );

  /// sign in with google
  Future<AuthResponse> signInWithGoogle();
}
