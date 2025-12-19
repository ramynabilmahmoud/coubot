import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_in_with_google_state.dart';

/// SignInWithGoogleCubit is a cubit that manages
/// the state of the sign in with google process
class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  /// constructor
  SignInWithGoogleCubit(
    this.signInWithGoogleUsecase,
  ) : super(SignInWithGoogleInitial());

  /// usecase to sign in with google
  final SignInWithGoogleUsecase signInWithGoogleUsecase;

  /// sign in with google
  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoading());
    final result = await signInWithGoogleUsecase(NoParameters());
    result.fold(
      (failure) => emit(SignInWithGoogleError(failure.errMessage)),
      (authResponse) => emit(SignInWithGoogleSuccess(authResponse)),
    );
  }
}
