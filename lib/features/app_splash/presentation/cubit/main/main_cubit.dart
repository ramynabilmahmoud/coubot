// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/utils/app_strings.dart';
import 'package:coubot/core/utils/theme_helper.dart';
import 'package:coubot/features/app_splash/domain/usecases/change_lang.dart';
import 'package:coubot/features/app_splash/domain/usecases/change_notifications.dart';
import 'package:coubot/features/app_splash/domain/usecases/change_theme_mode.dart';
import 'package:coubot/features/app_splash/domain/usecases/get_saved_lang.dart';
import 'package:coubot/features/app_splash/domain/usecases/get_saved_notifications.dart';
import 'package:coubot/features/app_splash/domain/usecases/get_saved_theme_mode.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:coubot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'main_state.dart';

/// enum for connectivity status
enum ConnectivityStatus {
  /// connected
  connected,

  /// disconnected
  disconnected,
}

/// a cubit to handle the main functionality of the app
class MainCubit extends Cubit<MainState> {
  /// constructor
  MainCubit(
    this._getSavedLangUseCase,
    this._changeLangUseCase,
    this._getSavedThemeModeUseCase,
    this._changeThemeModeUseCase,
    this._getSavedNotificationsUseCase,
    this._changeNotificationsUseCase,
  ) : super(MainInitialState());

  /// a static method to get the cubit instance
  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  final GetSavedLangUseCase _getSavedLangUseCase;
  final ChangeLangUseCase _changeLangUseCase;

  /// the current language code
  String currentLangCode = AppStrings.englishCode;

  final GetSavedThemeModeUseCase _getSavedThemeModeUseCase;
  final ChangeThemeModeUseCase _changeThemeModeUseCase;

  /// the current theme mode
  ThemeMode currentThemeMode = ThemeMode.system;

  final GetSavedNotificationsUseCase _getSavedNotificationsUseCase;
  final ChangeNotificationsUseCase _changeNotificationsUseCase;

  /// whether push notifications are enabled
  bool currentNotificationsEnabled = true;

  /// changes the theme mode
  Future<void> changeTheme({
    required String themeMode,
    required BuildContext context,
  }) async {
    final response = await _changeThemeModeUseCase.call(themeMode);
    response.fold((failure) => currentThemeMode = ThemeMode.system, (value) {
      if (themeMode == ThemeMode.dark.name) {
        currentThemeMode = ThemeMode.dark;
      } else if (themeMode == ThemeMode.light.name) {
        currentThemeMode = ThemeMode.light;
      }
      ThemeHelper.changeSystemUiOverlayStyle(context);

      emit(MainChangeThemeState());
    });
  }

  /// gets the saved theme mode
  Future<void> getSavedThemeMode() async {
    final response = await _getSavedThemeModeUseCase.call(NoParameters());
    response.fold((failure) => currentThemeMode = ThemeMode.system, (value) {
      if (value == ThemeMode.dark.name) {
        currentThemeMode = ThemeMode.dark;
      } else if (value == ThemeMode.light.name) {
        currentThemeMode = ThemeMode.light;
      }
      emit(MainGetThemeModeState());
    });
  }

  /// gets the saved language
  Future<void> getSavedLang() async {
    final response = await _getSavedLangUseCase.call(NoParameters());
    response.fold((failure) => currentLangCode = AppStrings.englishCode, (
      value,
    ) {
      currentLangCode = value;
      emit(MainGetLocaleState());
    });
  }

  /// gets the saved notifications preference
  Future<void> getSavedNotifications() async {
    final response = await _getSavedNotificationsUseCase.call(NoParameters());
    response.fold(
      (failure) => currentNotificationsEnabled = true,
      (value) {
        currentNotificationsEnabled = value;
        emit(MainGetNotificationsState());
      },
    );
  }

  /// changes the notifications enabled preference
  Future<void> changeNotifications({required bool enabled}) async {
    final response = await _changeNotificationsUseCase.call(enabled);
    response.fold(
      (failure) {},
      (value) {
        currentNotificationsEnabled = enabled;
        emit(MainChangeNotificationsState());
      },
    );
  }

  /// changes the language
  Future<void> changeLang({required String languageValue}) async {
    final response = await _changeLangUseCase.call(languageValue);
    response.fold(
      (failure) {
        throw Exception(failure.toString());
      },
      (value) {
        currentLangCode = languageValue;
        S.load(Locale(languageValue));
        emit(MainChangeLocaleState());
      },
    );
  }

  /// deep link handler
  void deepLinkHandler({required BuildContext context}) {
    final appLinks = AppLinks(); // AppLinks is singleton
    appLinks.uriLinkStream.listen((uri) {
      log('Uri obtained from deep link: $uri');

      supabaseClient.auth
          .getSessionFromUrl(uri)
          .then((session) {
            log('Session obtained from deep link: $session');
          })
          .onError((error, stackTrace) {
            log('Error obtaining session from deep link: $error');
          });
    });
  }

  /// a function to handle the authentication functionality of the app
  Future<void> authChangeTracker() async {
    var isSplashRouteComplete = false;
    
    // ✅ Check for existing session on app startup
    final session = supabaseClient.auth.currentSession;
    if (session != null) {
      log('Existing session found, routing to AppLayout');
      await appRouter.replaceAll([const AppLayoutWrapper()]);
      isSplashRouteComplete = true;
    } else {
      log('No session found, routing to Auth');
      await appRouter.pushAndPopUntil(
        const AuthWrapper(),
        predicate: (_) => false,
      );
    }

    supabaseClient.auth.onAuthStateChange.listen((event) async {
      switch (event.event) {
        case AuthChangeEvent.initialSession:
          log('Initial session');
          Future.delayed(const Duration(seconds: 3), () async {
            isSplashRouteComplete = true;
          });

        case AuthChangeEvent.passwordRecovery:
          log('Password recovery');

        case AuthChangeEvent.signedIn:
          log('Signed in');
          // Navigate to app layout when user signs in
          await appRouter.replaceAll([const AppLayoutWrapper()]);

        case AuthChangeEvent.signedOut:
          log('Signed out');
          // Navigate back to auth when user signs out
          await appRouter.replaceAll([const AuthWrapper()]);

        case AuthChangeEvent.tokenRefreshed:
          log('Token refreshed');
          // Handle token refresh only if the splash route is complete
          if (isSplashRouteComplete) {
            // if (appRouter.current.name == SplashRoute.name) {
            //   await appRouter.pushAndPopUntil(
            //     const HomeRoute(),
            //     predicate: (_) => false,
            //   );
            // }
          }

        case AuthChangeEvent.userUpdated:
          log('User updated');
          await supabaseClient.auth.getUser();

        case AuthChangeEvent.userDeleted:
          log('User deleted');
          await supabaseClient.auth.signOut();

        case AuthChangeEvent.mfaChallengeVerified:
          log('MFA challenge verified');
          await supabaseClient.auth.recoverSession(
            event.session!.refreshToken!,
          );
      }
    });
  }
}
