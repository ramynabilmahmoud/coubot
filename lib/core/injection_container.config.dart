// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/app_splash/data/datasources/splash_local_datasource.dart'
    as _i604;
import '../features/app_splash/data/repositories/splash_repo_impl.dart'
    as _i276;
import '../features/app_splash/domain/repositories/splash_repo.dart' as _i144;
import '../features/app_splash/domain/usecases/change_lang.dart' as _i344;
import '../features/app_splash/domain/usecases/change_notifications.dart'
    as _i166;
import '../features/app_splash/domain/usecases/change_theme_mode.dart' as _i505;
import '../features/app_splash/domain/usecases/get_saved_lang.dart' as _i837;
import '../features/app_splash/domain/usecases/get_saved_notifications.dart'
    as _i368;
import '../features/app_splash/domain/usecases/get_saved_theme_mode.dart'
    as _i436;
import '../features/auth/data/datasources/auth_remote_datasource.dart' as _i130;
import '../features/auth/data/repositories/auth_repo_impl.dart' as _i990;
import '../features/auth/domain/repositories/auth_repo.dart' as _i82;
import '../features/auth/domain/usecases/change_email_usecase.dart' as _i971;
import '../features/auth/domain/usecases/forget_password_usecase.dart' as _i479;
import '../features/auth/domain/usecases/sign_in_with_email_password_usecase.dart'
    as _i262;
import '../features/auth/domain/usecases/sign_up_usecase.dart' as _i797;
import '../features/auth/domain/usecases/update_user_password_usecase.dart'
    as _i285;
import '../features/cart/data/datasrouce/local/cart_local_data_source.dart'
    as _i187;
import '../features/cart/presentation/cubit/cart_cubit.dart' as _i678;
import '../features/home/data/datasources/home_remote_datasource.dart' as _i75;
import '../features/home/data/repositories/home_repository_impl.dart' as _i6;
import '../features/home/domain/repositories/home_repository.dart' as _i66;
import '../features/home/domain/usecases/get_home_feed.dart' as _i926;
import '../features/home/presentation/cubits/home_cubit.dart' as _i527;
import '../features/notifications/data/datasource/local/notifications_local_data_source.dart'
    as _i738;
import '../features/notifications/presentation/cubit/notifications_cubit.dart'
    as _i511;
import 'services/notification_service.dart' as _i98;
import 'utils/database_manager.dart' as _i273;
import 'utils/supabase_manager.dart' as _i635;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i635.SupabaseManager>(() => _i635.SupabaseManager());
    gh.lazySingleton<_i273.DatabaseManager>(() => _i273.DatabaseManager());
    gh.lazySingleton<_i98.NotificationService>(
        () => _i98.NotificationService());
    gh.lazySingleton<_i187.CartLocalDataSource>(
        () => _i187.CartLocalDataSource());
    gh.lazySingleton<_i738.NotificationsLocalDataSource>(
        () => _i738.NotificationsLocalDataSource());
    gh.lazySingleton<_i75.HomeRemoteDataSource>(
        () => _i75.HomeRemoteDataSourceImpl());
    gh.lazySingleton<_i604.SplashLocalDataSource>(
        () => _i604.SplashLocalDataSourceImpl());
    gh.lazySingleton<_i130.AuthRemoteDatasource>(
        () => _i130.AuthRemoteDatasourceImpl());
    gh.factory<_i678.CartCubit>(
        () => _i678.CartCubit(gh<_i187.CartLocalDataSource>()));
    gh.lazySingleton<_i82.AuthRepo>(
        () => _i990.AuthRepoImpl(gh<_i130.AuthRemoteDatasource>()));
    gh.lazySingleton<_i144.SplashRepo>(() => _i276.SplashRepoImpl(
        splashLocalDataSource: gh<_i604.SplashLocalDataSource>()));
    gh.lazySingleton<_i479.ForgetPasswordUsecase>(
        () => _i479.ForgetPasswordUsecase(gh<_i82.AuthRepo>()));
    gh.lazySingleton<_i971.ChangeEmailUsecase>(
        () => _i971.ChangeEmailUsecase(gh<_i82.AuthRepo>()));
    gh.lazySingleton<_i262.SignInWithEmailPasswordUsecase>(
        () => _i262.SignInWithEmailPasswordUsecase(gh<_i82.AuthRepo>()));
    gh.lazySingleton<_i797.SignUpUsecase>(
        () => _i797.SignUpUsecase(gh<_i82.AuthRepo>()));
    gh.lazySingleton<_i285.UpdateUserPasswordUsecase>(
        () => _i285.UpdateUserPasswordUsecase(gh<_i82.AuthRepo>()));
    gh.factory<_i511.NotificationsCubit>(() => _i511.NotificationsCubit(
          gh<_i738.NotificationsLocalDataSource>(),
          gh<_i98.NotificationService>(),
        ));
    gh.lazySingleton<_i66.HomeRepository>(
        () => _i6.HomeRepositoryImpl(gh<_i75.HomeRemoteDataSource>()));
    gh.lazySingleton<_i837.GetSavedLangUseCase>(
        () => _i837.GetSavedLangUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i436.GetSavedThemeModeUseCase>(() =>
        _i436.GetSavedThemeModeUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i368.GetSavedNotificationsUseCase>(() =>
        _i368.GetSavedNotificationsUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i344.ChangeLangUseCase>(
        () => _i344.ChangeLangUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i166.ChangeNotificationsUseCase>(() =>
        _i166.ChangeNotificationsUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i505.ChangeThemeModeUseCase>(
        () => _i505.ChangeThemeModeUseCase(splashRepo: gh<_i144.SplashRepo>()));
    gh.lazySingleton<_i926.GetHomeFeed>(
        () => _i926.GetHomeFeed(gh<_i66.HomeRepository>()));
    gh.factory<_i527.HomeCubit>(() => _i527.HomeCubit(
          gh<_i926.GetHomeFeed>(),
          gh<_i66.HomeRepository>(),
        ));
    return this;
  }
}
