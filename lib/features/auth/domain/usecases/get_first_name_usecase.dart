import 'package:dartz/dartz.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

/// GetFirstNameUseCase is a class that is Verify  otp
class GetFirstNameUseCase implements BaseUseCase<String, GetFirstNameParams> {
  /// constructor
  GetFirstNameUseCase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, String>> call(GetFirstNameParams params) {
    return _authRepo.getFirstName(
      email: params.email,
    );
  }
}

/// VerifyOTPParams is a class that holds
///  the required parameters for the VerifyOTP
class GetFirstNameParams {
  /// constructor
  GetFirstNameParams({
    required this.email,
  });

  /// sign up email
  final String email;
}
