import 'package:injectable/injectable.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;
  HomeRepositoryImpl(this.remote);

  @override
  Future<HomeFeed> getHomeFeed() => remote.getHomeFeed();

  @override
  Future<List<String>> getFavourites() => remote.getFavourites();

  @override
  Future<void> updateFavourites(List<String> productIds) =>
      remote.updateFavourites(productIds);
}
