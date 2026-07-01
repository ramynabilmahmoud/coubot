import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

/// TimerCubit
class TimerCubit extends Cubit<int> {
  /// Constructor
  TimerCubit() : super(60);

  Timer? _timer;

  /// startTimer
  void startTimer() {
    _timer?.cancel();
    emit(60);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state > 0) {
        emit(state - 1);
      } else {
        _timer?.cancel();
      }
    });
  }

  /// resetTimer
  void resetTimer() {
    _timer?.cancel();
    emit(60);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
