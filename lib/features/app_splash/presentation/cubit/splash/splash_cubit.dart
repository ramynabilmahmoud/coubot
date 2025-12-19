// ignore_for_file: public_member_api_docs, use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

/// Cubit for Splash Screen
class SplashCubit extends Cubit<SplashState> {
  /// Constructor
  SplashCubit() : super(SplashInitialState());
}
