import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// a use case that returns the saved theme mode
@lazySingleton
class GetSavedThemeModeUseCase implements BaseUseCase<String, NoParameters> {
  /// constructor for the use case that takes a [splashRepo]
  GetSavedThemeModeUseCase({required this.splashRepo});

  /// a [splashRepo] instance to be used in the use case
  final SplashRepo splashRepo;

  @override
  Future<Either<Failure, String>> call(NoParameters params) =>
      splashRepo.getSavedThemeMode();
}
