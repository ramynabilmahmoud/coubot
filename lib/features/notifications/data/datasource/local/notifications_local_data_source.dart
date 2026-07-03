import 'package:coubot/core/utils/database_manager.dart';
import 'package:coubot/features/notifications/data/models/order_notification_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationsLocalDataSource {
  NotificationsLocalDataSource();

  Box<OrderNotificationModel> get _box =>
      Hive.box<OrderNotificationModel>(DataBoxes.orderNotifications.name);

  List<OrderNotificationModel> getAll() => _box.values.toList();

  ValueListenable<Box<OrderNotificationModel>> listenable() => _box.listenable();

  Future<void> add(OrderNotificationModel notification) =>
      _box.put(notification.id, notification);

  Future<void> markAllRead() async {
    for (final n in _box.values.where((n) => !n.read)) {
      await _box.put(n.id, n.copyWith(read: true));
    }
  }
}
