import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.remoteDatasource);

  final AuthRemoteDatasource remoteDatasource;

  @override
  Future<Either<Failure, AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.signIn(email, password);
      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final result = await remoteDatasource.signUp(
        email,
        password,
        firstName,
        lastName,
      );
      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, bool>> resendOTP({
    required String email,
    required OtpType otpType,
  }) async {
    try {
      final result = await remoteDatasource.resendOTP(email, otpType);
      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyOTP({
    required String email,
    required String otp,
    required OtpType otpType,
  }) async {
    try {
      final result = await remoteDatasource.verifyOTP(email, otp, otpType);
      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await remoteDatasource.forgetPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserPassword({
    required String password,
  }) async {
    try {
      await remoteDatasource.updateUserPassword(password);
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, void>> changeEmail({required String email}) async {
    try {
      await remoteDatasource.changeEmail(email);
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }
}
