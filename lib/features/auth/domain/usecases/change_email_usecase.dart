import 'package:dartz/dartz.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

/// ChangeEmailUsecase is a class that is change email
class ChangeEmailUsecase implements BaseUseCase<void, ChangeEmailParams> {
  /// constructor
  ChangeEmailUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, void>> call(ChangeEmailParams params) {
    return _authRepo.changeEmail(
      email: params.email,
    );
  }
}

/// ChangeEmailParams is a class that holds
///  the required parameters for the ChangeEmail
class ChangeEmailParams {
  /// constructor
  ChangeEmailParams({
    required this.email,
  });

  /// sign up email
  final String email;
}
