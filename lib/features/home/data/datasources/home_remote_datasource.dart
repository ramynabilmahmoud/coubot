import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../models/product_model.dart';

/// HomeRemoteDataSource is an abstract class that defines
/// the methods that will be implemented by the HomeRemoteDataSourceImpl class.
abstract class HomeRemoteDataSource {
  /// Fetch home feed:
  /// - categories (always)
  /// - top items (always)
  /// - buy again (only if user has previous orders)
  Future<HomeFeed> getHomeFeed();
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl();

  SupabaseClient get _client => Supabase.instance.client;

  @override
  Future<HomeFeed> getHomeFeed() async {
    try {
      final userId = _client.auth.currentUser?.id;

      // Load categories + top items in parallel
      final results = await Future.wait([_getCategories(), _getTopItems()]);

      final categories = results[0] as List<CategoryEntity>;
      final topItemsModels = results[1] as List<ProductModel>;

      // Load buy again only if logged in
      final buyAgainModels = userId == null ? <ProductModel>[] : await _getBuyAgain(userId);

      developer.log(
        'HomeFeed loaded: categories=${categories.length}, top=${topItemsModels.length}, buyAgain=${buyAgainModels.length}',
        name: 'HomeRemoteDataSource',
      );

      return HomeFeed(
        topItems: topItemsModels.map((e) => e.toEntity()).toList(),
        buyAgain: buyAgainModels.map((e) => e.toEntity()).toList(),
        categories: categories,
      );
    } catch (e, st) {
      developer.log(
        'Error fetching home feed: $e',
        name: 'HomeRemoteDataSource',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  /// categories table:
  /// id, name, media_source, icon_key
  Future<List<CategoryEntity>> _getCategories() async {
    final res = await _client
        .from('categories')
        .select('id, name, icon_key, media_source')
        .order('name', ascending: true);

    final list = (res as List).cast<Map<String, dynamic>>();

    return list.map((json) {
      return CategoryEntity(
        id: json['id'].toString(),
        title: (json['name'] as String?)?.trim() ?? 'Category',
        iconKey: (json['icon_key'] as String?)?.trim() ?? 'grid',
        // NOTE: media_source exists in DB but your Category entity currently
        // doesn't include it. If you want to render images, extend Category.
      );
    }).toList();
  }

  /// top items = latest products
  /// ✅ UPDATED: includes image_url
  Future<List<ProductModel>> _getTopItems() async {
    final res = await _client
        .from('products')
        .select('id, category_id, name, description, price, estimated_time, image_url')
        .order('created_at', ascending: false)
        .limit(10);

    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(ProductModel.fromJson).toList();
  }

  /// buy again:
  /// - look up product_ids from user's orders via order_products join orders
  /// - fetch products by those ids
  Future<List<ProductModel>> _getBuyAgain(String userId) async {
    final res = await _client
        .from('order_products')
        .select('product_id, orders!inner(customer_id, created_at)')
        .eq('orders.customer_id', userId)
        .order('created_at')
        .limit(50);

    final rows = (res as List).cast<Map<String, dynamic>>();

    final seen = <String>{};
    final productIds = <String>[];

    for (final row in rows) {
      final pid = row['product_id']?.toString();
      if (pid == null) continue;
      if (seen.add(pid)) productIds.add(pid);
    }

    if (productIds.isEmpty) return [];

    // ✅ UPDATED: includes image_url
    final productsRes = await _client
        .from('products')
        .select('id, category_id, name, description, price, estimated_time, image_url')
        .inFilter('id', productIds);

    final productsList = (productsRes as List).cast<Map<String, dynamic>>();
    final products = productsList.map(ProductModel.fromJson).toList();

    // preserve order of productIds
    final byId = {for (final p in products) p.id: p};
    final ordered = <ProductModel>[];
    for (final id in productIds) {
      final p = byId[id];
      if (p != null) ordered.add(p);
    }

    return ordered.take(10).toList();
  }
}
