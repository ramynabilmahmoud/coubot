import 'package:coubot/app.dart';
import 'package:coubot/config/routes/app_router.dart';
import 'package:coubot/core/injection_container.dart';
import 'package:coubot/core/utils/bloc_observer.dart';
import 'package:coubot/core/utils/database_manager.dart';
import 'package:coubot/core/utils/supabase_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// The [AppRouter] instance that is used to navigate across the app.
final appRouter = AppRouter();

/// The Supabase client instance used for interacting with the Supabase backend.
final supabaseClient = getIt<SupabaseManager>().supabase;

/// A global key that will uniquely identify the Navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Load the environment variables from the .env file.
  await dotenv.load();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Future.wait<dynamic>([
    configureDependencies(),
    DatabaseManager.initHive(),
  ]);
  await getIt.get<SupabaseManager>().initializeSupaBase();

  // Only call clearSavedSettings() during testing to reset internal values.
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  // test();

  Bloc.observer = AppBlocObserver();
  runApp(const CoubotApp());
}
