import 'package:dartz/dartz.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

/// ForgetPasswordUsecase is a class that is resend  otp
class ForgetPasswordUsecase implements BaseUseCase<void, ForgetPasswordParams> {
  /// constructor
  ForgetPasswordUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, void>> call(ForgetPasswordParams params) {
    return _authRepo.forgetPassword(
      email: params.email,
    );
  }
}

/// ForgetPasswordParams is a class that holds
///  the required parameters for the ForgetPassword
class ForgetPasswordParams {
  /// constructor
  ForgetPasswordParams({
    required this.email,
  });

  /// sign up email
  final String email;
}
