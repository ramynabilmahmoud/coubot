import '../../data/models/order_notification_model.dart';

class NotificationsState {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class NotificationsLoaded extends NotificationsState {
  final List<OrderNotificationModel> items;
  final int unreadCount;

  const NotificationsLoaded({required this.items, required this.unreadCount});
}
