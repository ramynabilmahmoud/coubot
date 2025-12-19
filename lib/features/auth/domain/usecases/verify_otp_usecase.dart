import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton

/// VerifyOTPUsecase is a class that is Verify  otp
class VerifyOTPUsecase implements BaseUseCase<AuthResponse, VerifyOTPParams> {
  /// constructor
  VerifyOTPUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, AuthResponse>> call(VerifyOTPParams params) {
    return _authRepo.verifyOTP(
      email: params.email,
      otpType: params.otpType,
      otp: params.otp,
    );
  }
}

/// VerifyOTPParams is a class that holds
///  the required parameters for the VerifyOTP
class VerifyOTPParams {
  /// constructor
  VerifyOTPParams({
    required this.email,
    required this.otp,
    required this.otpType,
  });

  /// sign up email
  final String email;

  /// sign up userName
  final String otp;

  /// otp type
  final OtpType otpType;
}
