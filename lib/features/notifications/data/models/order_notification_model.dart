import 'package:hive/hive.dart';

part 'order_notification_model.g.dart';

@HiveType(typeId: 11)
class OrderNotificationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int orderId;

  @HiveField(2)
  final String status;

  @HiveField(3)
  final String message;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final bool read;

  OrderNotificationModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.message,
    required this.createdAt,
    this.read = false,
  });

  OrderNotificationModel copyWith({bool? read}) {
    return OrderNotificationModel(
      id: id,
      orderId: orderId,
      status: status,
      message: message,
      createdAt: createdAt,
      read: read ?? this.read,
    );
  }
}
