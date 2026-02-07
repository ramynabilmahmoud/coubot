// ignore_for_file: depend_on_referenced_packages

import 'package:coubot/core/injection_container.dart';
import 'package:coubot/features/app_splash/domain/usecases/change_lang.dart';
import 'package:coubot/features/app_splash/domain/usecases/change_theme_mode.dart';
import 'package:coubot/features/app_splash/domain/usecases/get_saved_lang.dart';
import 'package:coubot/features/app_splash/domain/usecases/get_saved_theme_mode.dart';
import 'package:coubot/features/app_splash/presentation/cubit/main/main_cubit.dart';
import 'package:coubot/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

/// this class is used to manage the multi bloc provider and multi bloc listener
class MultiBlocManager {
  // ignore: public_member_api_docs
  static List<SingleChildWidget> multiBlocProviderList = [
    BlocProvider(
      create: (context) =>
          MainCubit(
              getIt<GetSavedLangUseCase>(),
              getIt<ChangeLangUseCase>(),
              getIt<GetSavedThemeModeUseCase>(),
              getIt<ChangeThemeModeUseCase>(),
            )
            ..getSavedLang()
            ..getSavedThemeMode()
            ..deepLinkHandler(context: context)
            ..authChangeTracker(),
    ),
    BlocProvider(create: (context) => getIt<CartCubit>()..start()),
  ];

  /// this method is used to get the multi bloc listener list
  static List<SingleChildWidget> get multiBlocListenersList {
    return [
      // main cubit listener
      BlocListener<MainCubit, MainState>(listener: (context, state) {}),
    ];
  }
}
