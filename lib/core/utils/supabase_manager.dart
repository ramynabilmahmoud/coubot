import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A singleton class that manages the Supabase client instance.
@lazySingleton
class SupabaseManager {
  /// Returns the Supabase client instance.
  SupabaseClient get supabase => _supabase;

  /// The Supabase client instance.
  late final SupabaseClient _supabase = Supabase.instance.client;

  /// Initializes the Supabase client with the given URL and anonymous key.
  ///
  /// Throws an [Exception] if the initialization fails.
  Future<void> initializeSupaBase() async {
    try {
      final supabaseUrl = dotenv.env['SUPABASE_URL'];
      final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

      if (supabaseUrl == null || anonKey == null) {
        throw Exception('Supabase env variables are missing');
      }
      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: anonKey,
        debug: true,
      );
    } catch (e) {
      throw Exception('Failed to initialize Supabase: $e');
    }
  }
}

/// An enumeration of the Supabase tables used in the application.
enum SupabaseTables {
  /// Represents the 'categories' table in Supabase.
  categories('categories'),

  /// Represents the 'category_media' table in Supabase.
  categoryMedia('category_media'),

  /// Represents the 'orders' table in Supabase.
  orders('orders'),

  /// Represents the 'order_products' table in Supabase.
  orderProducts('order_products'),

  /// Represents the 'products' table in Supabase.
  products('products'),

  /// Represents the 'product_media' table in Supabase.
  productMedia('product_media'),

  /// Represents the 'users' table in Supabase.
  users('users');

  /// The name of the table.
  const SupabaseTables(this.tableName);

  /// The table name as a string.
  final String tableName;
}
