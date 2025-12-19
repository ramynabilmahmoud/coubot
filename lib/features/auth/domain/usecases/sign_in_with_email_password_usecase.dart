import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton

/// SignUpUsecase is a class that is used to sign up a user
class SignInWithEmailPasswordUsecase
    implements BaseUseCase<AuthResponse, SignInParams> {
  /// constructor
  SignInWithEmailPasswordUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, AuthResponse>> call(SignInParams params) {
    return _authRepo.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

/// SignInParams is a class that holds
///  the required parameters for the SignUpUsecase
class SignInParams {
  /// constructor
  SignInParams({
    required this.email,
    required this.password,
  });

  /// sign up email
  String email;

  /// sign up password
  String password;
}
