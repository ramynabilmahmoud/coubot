import 'package:coubot/core/injection_container.dart';
import 'package:coubot/core/utils/database_manager.dart';
import 'package:injectable/injectable.dart';

/// this class is responsible for saving and getting the language code
abstract interface class SplashLocalDataSource {
  /// saves the language code in the database
  Future<bool> changeLang({required String langCode});

  /// get the saved language code
  Future<String> getSavedLang();

  /// saves the theme mode in the local storage
  Future<bool> changeThemeMode({required String themeMode});

  /// gets the saved theme mode from the local storage
  Future<String> getSavedThemeMode();
}

/// this class is responsible for saving and getting the language code
/// it implements [SplashLocalDataSource]
@LazySingleton(as: SplashLocalDataSource)
class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  /// Constructor
  SplashLocalDataSourceImpl();

  @override
  Future<bool> changeLang({required String langCode}) async {
    try {
      getIt<DatabaseManager>().setLanguage(langCode);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getSavedLang() async {
    return getIt<DatabaseManager>()
        .getLanguage(); // Access the static method using the class name
  }

  @override
  Future<bool> changeThemeMode({required String themeMode}) async {
    try {
      getIt<DatabaseManager>().setThemeMode(themeMode);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getSavedThemeMode() async {
    return getIt<DatabaseManager>()
        .getThemeMode(); // Access the static method using the class name
  }
}
