import 'package:coubot/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

/// abstract interface class for Splash repository
abstract interface class SplashRepo {
  /// saves the language code
  Future<Either<Failure, bool>> changeLang({required String langCode});

  /// gets the saved language code
  Future<Either<Failure, String>> getSavedLang();

  /// saves the theme mode
  Future<Either<Failure, bool>> changeThemeMode({required String themeMode});

  /// gets the saved theme mode
  Future<Either<Failure, String>> getSavedThemeMode();
}
