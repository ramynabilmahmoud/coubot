import 'package:coubot/config/routes/app_router.gr.dart';
import 'package:coubot/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Shows local notifications for events observed while the app process is
/// alive (foreground/background). This is not OS-level push (FCM/APNs) -
/// it cannot wake the app from a fully killed state.
@lazySingleton
class NotificationService {
  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void>? _initFuture;

  Future<void> init() {
    return _initFuture ??= _doInit();
  }

  Future<void> _doInit() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    final ok = await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (_) => _openNotifications(),
    );
    debugPrint('NotificationService.init: initialize() returned $ok');

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      // Cold start from a tapped notification - give splash/auth routing
      // time to settle before pushing on top of it.
      Future.delayed(const Duration(seconds: 2), _openNotifications);
    }

    final androidGranted = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    debugPrint('NotificationService.init: android permission granted=$androidGranted');

    final iosGranted = await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    debugPrint('NotificationService.init: ios permission granted=$iosGranted');

    _initialized = true;
  }

  void _openNotifications() {
    appRouter.push(const NotificationsRoute());
  }

  Future<void> show({required String title, required String body}) async {
    if (!_initialized) await init();

    const androidDetails = AndroidNotificationDetails(
      'orders_channel',
      'Order updates',
      channelDescription: 'Notifications about your order status',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      presentBanner: true,
      presentList: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _plugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        details,
      );
      debugPrint('NotificationService.show: fired "$title" / "$body"');
    } catch (e, st) {
      debugPrint('NotificationService.show: FAILED - $e\n$st');
    }
  }
}
