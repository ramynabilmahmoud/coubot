import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

/// UpdateUserPassword is a class that is used to update the user password
class UpdateUserPasswordUsecase
    implements BaseUseCase<void, UpdateUserPasswordParams> {
  /// constructor
  UpdateUserPasswordUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, void>> call(UpdateUserPasswordParams params) {
    return _authRepo.updateUserPassword(
      password: params.password,
    );
  }
}

/// UpdateUserPasswordParams is a class that holds
///  the required parameters for the VerifyOTP
class UpdateUserPasswordParams {
  /// constructor
  UpdateUserPasswordParams({
    required this.password,
  });

  /// password
  final String password;
}
