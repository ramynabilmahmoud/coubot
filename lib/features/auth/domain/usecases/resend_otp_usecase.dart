import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton

/// ResendOTPUsecase is a class that is resend  otp
class ResendOTPUsecase implements BaseUseCase<bool, ResendOTPParams> {
  /// constructor
  ResendOTPUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, bool>> call(ResendOTPParams params) {
    return _authRepo.resendOTP(
      email: params.email,
      otpType: params.otpType,
    );
  }
}

/// ResendOTPParams is a class that holds
///  the required parameters for the ResendOTP
class ResendOTPParams {
  /// constructor
  ResendOTPParams({
    required this.email,
    required this.otpType,
  });

  /// sign up email
  final String email;

  /// otp type
  final OtpType otpType;
}
