import 'package:coubot/core/base_usecase.dart';
import 'package:coubot/core/errors/failures.dart';
import 'package:coubot/features/app_splash/domain/repositories/splash_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// a use case that changes the push notifications preference
@lazySingleton
class ChangeNotificationsUseCase implements BaseUseCase<bool, bool> {
  /// constructor
  ChangeNotificationsUseCase({required this.splashRepo});

  /// [splashRepo] instance
  final SplashRepo splashRepo;

  @override
  Future<Either<Failure, bool>> call(bool enabled) =>
      splashRepo.changeNotifications(enabled: enabled);
}
