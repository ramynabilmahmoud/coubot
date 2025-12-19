import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton

/// SignInWithGoogleUsecase is a class that is used to
/// sign in with google
class SignInWithGoogleUsecase
    implements BaseUseCase<AuthResponse, NoParameters> {
  /// constructor
  SignInWithGoogleUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, AuthResponse>> call(NoParameters params) {
    return _authRepo.signInWithGoogle();
  }
}
