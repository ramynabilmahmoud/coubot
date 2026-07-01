import 'package:coubot/config/themes/app_theme.dart';
import 'package:coubot/config/themes/app_theme_dark.dart';
import 'package:coubot/core/utils/app_strings.dart';
import 'package:coubot/core/utils/app_values.dart';
import 'package:coubot/core/utils/multi_bloc_manager.dart';
import 'package:coubot/core/utils/size_helper.dart';
import 'package:coubot/features/app_splash/presentation/cubit/main/main_cubit.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Main App Widget
class CoubotApp extends StatelessWidget {
  /// Constructor
  const CoubotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MultiBlocManager.multiBlocProviderList,
      child: MultiBlocListener(
        listeners: MultiBlocManager.multiBlocListenersList,
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                SizeHelper.constraints = constraints;
                return MaterialApp.router(
                  title: AppStrings.appName,
                  locale: Locale(MainCubit.get(context).currentLangCode),
                  debugShowCheckedModeBanner: AppValues.isTest,
                  theme: AppTheme.theme(
                    lang: MainCubit.get(context).currentLangCode,
                  ),
                  darkTheme: AppThemeDark.theme(
                    lang: MainCubit.get(context).currentLangCode,
                  ),
                  themeMode: MainCubit.get(context).currentThemeMode,
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  routerConfig: appRouter.config(
                    navigatorObservers: () {
                      return [HeroController()];
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
