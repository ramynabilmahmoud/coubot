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
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      },
    );

    if (res.user != null) {
      await upsertUserRow(
        id: res.user!.id,
        email: res.user!.email ?? email,
        firstName: firstName ?? '',
        lastName: lastName ?? '',
      );
    } else {
      throw AuthException('Sign up requires email confirmation. Please verify your email to complete registration.');
    }

    return res;
  }

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return _client.auth.signInWithPassword(email: email, password: password);
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
      'role':'customer',
    });

    // Optional: uncomment if you want to inspect insert response during debugging.
    // print('Upsert result: $result');
  }
}
