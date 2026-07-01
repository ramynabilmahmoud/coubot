import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_layout_state.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(const AppLayoutState(selectedTab: 0));

  void selectTab(int index) {
    emit(AppLayoutState(selectedTab: index));
  }
}
