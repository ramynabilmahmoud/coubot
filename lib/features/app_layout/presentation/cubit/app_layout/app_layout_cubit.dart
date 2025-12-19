import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:upgrader/upgrader.dart';

part 'app_layout_state.dart';

/// AppLayoutCubit is used to manage the app layout
class AppLayoutCubit extends Cubit<AppLayoutState> {
  /// AppLayoutCubit constructor
  AppLayoutCubit() : super(AppLayoutState.initial());

  /// get the current app version
  void getAppVersion() {
    final minAppVersion =
        Upgrader.sharedInstance.currentAppStoreVersion ?? '1.0.0';
    emit(state.copyWith(appVersion: minAppVersion));
  }
}
