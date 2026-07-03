// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderNotificationModelAdapter
    extends TypeAdapter<OrderNotificationModel> {
  @override
  final int typeId = 11;

  @override
  OrderNotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderNotificationModel(
      id: fields[0] as String,
      orderId: fields[1] as int,
      status: fields[2] as String,
      message: fields[3] as String,
      createdAt: fields[4] as DateTime,
      read: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, OrderNotificationModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.read);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderNotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
