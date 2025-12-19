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
      await Supabase.initialize(
        url: 'https://iztqkmsirnqiomplkpva.supabase.co',
        anonKey:
            // ignore: lines_longer_than_80_chars
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml6dHFrbXNpcm5xaW9tcGxrcHZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc1OTMyNzIsImV4cCI6MjAzMzE2OTI3Mn0.iivyZkhj4W4zzcrnRiRg5HvDBslbXN-9QHpKdmMXJxg',
        debug: true,
      );
    } catch (e) {
      throw Exception('Failed to initialize Supabase: $e');
    }
  }
}

/// An enumeration of the Supabase tables used in the application.
enum SupabaseTables {
  /// Represents the 'packages' table in Supabase.
  packages('packages'),

  /// Represents the 'airports' table in Supabase.
  airports('airports'),

  /// Represents the 'faqs' table in Supabase.
  faqs('faqs'),

  /// Represents the 'user_notifications' table in Supabase.
  userNotifications('user_notifications'),

  /// Represents the 'requests' table in Supabase.
  requests('requests'),

  /// Represents the 'package_items' table in Supabase.
  packageItems('package_items'),

  /// Represents the 'cancel_package_reason' table in Supabase.
  cancelPackageReason('cancel_package_reason'),

  /// Represents the 'destinations' table in Supabase.
  destinations('destinations'),

  /// Represents the 'app_constants' table in Supabase.
  appConstants('app_constants'),

  /// Represents the 'messages' table in Supabase.
  messages('messages'),

  /// Represents the 'chats' table in Supabase.
  chats('chats'),

  /// Represents the 'profiles' table in Supabase.
  profiles('profiles'),

  /// Represents the 'notifications' table in Supabase.
  notifications('notifications'),
  ;

  /// The name of the table.
  const SupabaseTables(this.tableName);

  /// The table name as a string.
  final String tableName;
}
