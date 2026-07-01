import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// a use case that returns the saved language
@lazySingleton
class GetSavedLangUseCase implements BaseUseCase<String, NoParameters> {
  /// constructor for the use case that takes a [SplashRepo] as a parameter
  GetSavedLangUseCase({required this.splashRepo});

  /// a [SplashRepo] instance to be used in the use case
  final SplashRepo splashRepo;

  @override
  Future<Either<Failure, String>> call(NoParameters params) =>
      splashRepo.getSavedLang();
}
