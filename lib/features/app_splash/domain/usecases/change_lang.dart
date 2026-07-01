import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// a use case that changes the language of the app
@lazySingleton
class ChangeLangUseCase implements BaseUseCase<bool, String> {
  /// constructor for the use case that takes a [SplashRepo] as a parameter
  ChangeLangUseCase({required this.splashRepo});

  /// a [SplashRepo] instance to be used in the use case
  final SplashRepo splashRepo;

  @override
  Future<Either<Failure, bool>> call(String langCode) =>
      splashRepo.changeLang(langCode: langCode);
}
