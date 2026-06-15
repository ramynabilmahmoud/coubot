import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// a use case that returns the saved push notifications preference
@lazySingleton
class GetSavedNotificationsUseCase implements BaseUseCase<bool, NoParameters> {
  /// constructor
  GetSavedNotificationsUseCase({required this.splashRepo});

  /// [splashRepo] instance
  final SplashRepo splashRepo;

  @override
  Future<Either<Failure, bool>> call(NoParameters params) =>
      splashRepo.getSavedNotifications();
}
