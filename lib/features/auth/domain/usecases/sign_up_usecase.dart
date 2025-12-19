import 'package:coubot/core/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@lazySingleton

/// SignUpUsecase is a class that is used to sign up a user
class SignUpUsecase implements BaseUseCase<AuthResponse, SignUpParams> {
  /// constructor
  SignUpUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, AuthResponse>> call(SignUpParams params) {
    return _authRepo.signUp(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

/// SignUpParams is a class that holds
///  the required parameters for the SignUpUsecase
class SignUpParams {
  /// constructor
  SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  /// sign up email
  final String email;

  /// sign up password
  final String password;

  /// signup first name
  final String firstName;

  /// signup last name
  final String lastName;
}
