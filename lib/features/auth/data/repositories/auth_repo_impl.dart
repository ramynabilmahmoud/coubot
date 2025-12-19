import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/core/utils/sign_in_helper.dart';
import 'package:coubot/features/auth/data/strategy/google_strategy/sign_in_with_google_strategy.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:coubot/main.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepo)
/// AuthRepoImpl
class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, AuthResponse>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

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
      final result = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        // emailRedirectTo: DeepLinkingHelper().supaBaseAuthDeepLink,
        data: {'first_name': firstName, 'last_name': lastName},
      );

      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// recognize a user
  @override
  Future<Either<Failure, bool>> recognize({required String email}) async {
    try {
      final result = await supabaseClient.rpc<bool>(
        'check_user_email_exists',
        params: {'email_input': email},
      );

      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// get first name of existing user
  @override
  Future<Either<Failure, String>> getFirstName({required String email}) async {
    try {
      final result = await supabaseClient.rpc<String>(
        'get_user_first_name_by_email',
        params: {'email_input': email},
      );

      if (result.isEmpty) {
        return Left(Failure.fromObject(Exception('User not found')));
      }

      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// resend otp
  @override
  Future<Either<Failure, bool>> resendOTP({
    required String email,
    required OtpType otpType,
  }) async {
    try {
      await supabaseClient.auth.resend(email: email, type: otpType);

      return const Right(true);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// verify otp
  @override
  Future<Either<Failure, AuthResponse>> verifyOTP({
    required String email,
    required String otp,
    required OtpType otpType,
  }) async {
    try {
      final result = await supabaseClient.auth.verifyOTP(
        email: email,
        type: otpType,
        token: otp,
      );

      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// forget password
  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);

      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// update user password
  @override
  Future<Either<Failure, void>> updateUserPassword({
    required String password,
  }) async {
    try {
      await supabaseClient.auth.updateUser(UserAttributes(password: password));

      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// change email
  @override
  Future<Either<Failure, void>> changeEmail({required String email}) async {
    try {
      await supabaseClient.auth.updateUser(UserAttributes(email: email));

      return const Right(null);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  /// sign in with google
  @override
  Future<Either<Failure, AuthResponse>> signInWithGoogle() async {
    try {
      final strategy = SignInWithGoogleStrategy.getStrategy();
      final response = await strategy.signInWithGoogle();
      await SignInHelper.updateUserMetadata(response.user!);

      return Right(response);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }
}
