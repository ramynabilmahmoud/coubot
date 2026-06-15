import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/data/datasources/splash_local_datasource.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// LangRepoImpl is the implementation of [SplashRepo]
@LazySingleton(as: SplashRepo)
class SplashRepoImpl implements SplashRepo {
  /// Constructor
  SplashRepoImpl({required this.splashLocalDataSource});

  /// a [splashLocalDataSource] object
  final SplashLocalDataSource splashLocalDataSource;

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged = await splashLocalDataSource.changeLang(
        langCode: langCode,
      );
      return Right(langIsChanged);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await splashLocalDataSource.getSavedLang();
      return Right(langCode);
    } catch (e) {
      return Left(RegularFailure('Error getting saved lang'));
    }
  }

  @override
  Future<Either<Failure, bool>> changeThemeMode({
    required String themeMode,
  }) async {
    try {
      final themeModeIsChanged = await splashLocalDataSource.changeThemeMode(
        themeMode: themeMode,
      );
      return Right(themeModeIsChanged);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedThemeMode() async {
    try {
      final themeMode = await splashLocalDataSource.getSavedThemeMode();
      return Right(themeMode);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, bool>> changeNotifications({required bool enabled}) async {
    try {
      final result = await splashLocalDataSource.changeNotifications(enabled: enabled);
      return Right(result);
    } catch (e) {
      return Left(Failure.fromObject(e));
    }
  }

  @override
  Future<Either<Failure, bool>> getSavedNotifications() async {
    try {
      final enabled = await splashLocalDataSource.getSavedNotifications();
      return Right(enabled);
    } catch (e) {
      return Left(RegularFailure('Error getting saved notifications'));
    }
  }
}
