import 'package:coubot/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Auth repository
abstract class AuthRepo {
  /// Sign up
  Future<Either<Failure, AuthResponse>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });

  /// Sign in
  Future<Either<Failure, AuthResponse>> signIn({
    required String email,
    required String password,
  });

  /// forget password
  Future<Either<Failure, void>> forgetPassword({required String email});

  /// update password for email
  /// required fields: password
  Future<Either<Failure, void>> updateUserPassword({required String password});

  /// change email
  /// required fields: email
  Future<Either<Failure, void>> changeEmail({required String email});
}
