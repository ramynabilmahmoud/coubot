import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// AuthRemoteDatasource is an abstract class that defines
/// the methods that will be implemented by the AuthRemoteDatasourceImpl class.
abstract class AuthRemoteDatasource {
  /// create a new user
  /// required fields: email, password
  Future<AuthResponse> signUp(
    String email,
    String password,
    String? firstName,
    String? lastName,
  );

  /// sign in a user
  /// required fields: email, password
  Future<AuthResponse> signIn(String email, String password);

  /// send otp to the user
  Future<bool> resendOTP(String email, OtpType otpType);

  /// verify otp
  Future<AuthResponse> verifyOTP(String email, String otp, OtpType otpType);

  /// ✅ verify otp + ensure user exists in public.users
  Future<AuthResponse> verifyOTPAndUpsertUser(
    String email,
    String otp,
    OtpType otpType,
  );

  /// forget password
  Future<void> forgetPassword(String email);

  /// set new password
  Future<void> updateUserPassword(String password);

  /// change email
  Future<void> changeEmail(String email);

  /// ✅ MANUAL: insert user into public.users after signup/otp
  Future<void> upsertUserRow({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
  });
}

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl();

  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<AuthResponse> signUp(
    String email,
    String password,
    String? firstName,
    String? lastName,
  ) async {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      },
    );
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<bool> resendOTP(String email, OtpType otpType) async {
    await _client.auth.resend(email: email, type: otpType);
    return true;
  }

  @override
  Future<AuthResponse> verifyOTP(
    String email,
    String otp,
    OtpType otpType,
  ) async {
    return _client.auth.verifyOTP(email: email, type: otpType, token: otp);
  }

  /// ✅ verify OTP then upsert into public.users
  ///
  /// This solves: "after signup + verify otp, user row not added to users table"
  @override
  Future<AuthResponse> verifyOTPAndUpsertUser(
    String email,
    String otp,
    OtpType otpType,
  ) async {
    final res = await verifyOTP(email, otp, otpType);

    final user = res.user;
    if (user == null) {
      // If this happens, OTP verification didn't yield a user session.
      // Usually means wrong otpType/token/email combo.
      throw AuthException('OTP verified but no user returned.');
    }

    final meta = user.userMetadata ?? const <String, dynamic>{};

    // Use metadata if available; otherwise fallback to empty strings
    final firstName = (meta['first_name'] ?? '').toString();
    final lastName = (meta['last_name'] ?? '').toString();

    await upsertUserRow(
      id: user.id,
      email: user.email ?? email,
      firstName: firstName,
      lastName: lastName,
    );

    return res;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> updateUserPassword(String password) async {
    await _client.auth.updateUser(UserAttributes(password: password));
  }

  @override
  Future<void> changeEmail(String email) async {
    await _client.auth.updateUser(UserAttributes(email: email));
  }

  /// ✅ Manual insert/upsert into public.users
  @override
  Future<void> upsertUserRow({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    await _client.from('users').upsert({
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    });

    // Optional: uncomment if you want to inspect insert response during debugging.
    // print('Upsert result: $result');
  }
}
