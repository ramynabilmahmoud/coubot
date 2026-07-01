import 'package:injectable/injectable.dart';

import '../repositories/home_repository.dart';

@lazySingleton
class GetHomeFeed {
  final HomeRepository repo;
  const GetHomeFeed(this.repo);

  Future<HomeFeed> call() => repo.getHomeFeed();
}
