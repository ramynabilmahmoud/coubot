import 'package:dartz/dartz.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

/// RecognizeUseCase is a class that is used to sign up a user
class RecognizeUseCase implements BaseUseCase<bool, RecognizeParams> {
  /// constructor
  RecognizeUseCase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, bool>> call(RecognizeParams params) {
    return _authRepo.recognize(
      email: params.email,
    );
  }
}

/// RecognizeParams is a class that holds
/// the required parameters for the RecognizeUsecase
class RecognizeParams {
  /// constructor
  RecognizeParams({
    required this.email,
  });

  /// sign up email
  final String email;
}
