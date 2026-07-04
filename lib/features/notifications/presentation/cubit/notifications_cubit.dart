import 'dart:async';

import 'package:coubot/core/services/notification_service.dart';
import 'package:coubot/features/notifications/data/datasource/local/notifications_local_data_source.dart';
import 'package:coubot/features/notifications/data/models/order_notification_model.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'notifications_state.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._local, this._notificationService)
      : super(const NotificationsInitial());

  final NotificationsLocalDataSource _local;
  final NotificationService _notificationService;

  ValueListenable? _listenable;
  VoidCallback? _listener;
  RealtimeChannel? _ordersChannel;
  StreamSubscription<AuthState>? _authSub;
  bool _started = false;

  /// Call once (in MultiBlocManager) to keep the bell badge + list live.
  void start() {
    if (_started) return;
    _started = true;

    _listenable = _local.listenable();
    _listener = _emit;
    _listenable!.addListener(_listener!);
    _emit();

    final client = Supabase.instance.client;
    final session = client.auth.currentSession;
    if (session != null) _subscribeOrders(session.user.id);

    _authSub = client.auth.onAuthStateChange.listen((event) {
      final userId = event.session?.user.id;
      if (event.event == AuthChangeEvent.signedIn && userId != null) {
        _subscribeOrders(userId);
      } else if (event.event == AuthChangeEvent.signedOut) {
        _unsubscribeOrders();
      }
    });
  }

  void _subscribeOrders(String userId) {
    if (_ordersChannel != null) return;

    unawaited(_notificationService.init());

    _ordersChannel = Supabase.instance.client
        .channel('order_notifications_$userId')
      ..onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'orders',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'customer_id',
          value: userId,
        ),
        callback: _handleOrderChange,
      )
      ..subscribe();
  }

  Future<void> _handleOrderChange(PostgresChangePayload payload) async {
    final status = payload.newRecord['status'] as String?;
    final rawId = payload.newRecord['id'];
    if (status == null || rawId == null) return;

    final orderId = rawId is int ? rawId : int.tryParse(rawId.toString()) ?? 0;
    final message = S.current.orderStatusUpdateMessage(orderId, status);

    await _local.add(OrderNotificationModel(
      id: '${orderId}_${DateTime.now().millisecondsSinceEpoch}',
      orderId: orderId,
      status: status,
      message: message,
      createdAt: DateTime.now(),
    ));

    await _notificationService.show(title: S.current.orderUpdate, body: message);
  }

  void _unsubscribeOrders() {
    if (_ordersChannel != null) {
      Supabase.instance.client.removeChannel(_ordersChannel!);
      _ordersChannel = null;
    }
  }

  void _emit() {
    final items = _local.getAll()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final unread = items.where((n) => !n.read).length;
    emit(NotificationsLoaded(items: items, unreadCount: unread));
  }

  Future<void> markAllRead() => _local.markAllRead();

  @override
  Future<void> close() async {
    if (_listenable != null && _listener != null) {
      _listenable!.removeListener(_listener!);
    }
    await _authSub?.cancel();
    _unsubscribeOrders();
    return super.close();
  }
}
