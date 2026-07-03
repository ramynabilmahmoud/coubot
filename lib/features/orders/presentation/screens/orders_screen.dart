import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/core/utils/assets.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Supabase client instance
  final supabase = Supabase.instance.client;

  // Realtime channel for order updates
  RealtimeChannel? _ordersChannel;

  // Currently selected tab
  String selectedTab = 'active';

  // Loading state for spinner
  bool isLoading = true;

  // All orders from database
  List allOrders = [];

  // Orders filtered by selected tab
  List filteredOrders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders(); // Initial data load
    _listenToOrderChanges(); // Start realtime listener
  }

  @override
  void dispose() {
    _ordersChannel?.unsubscribe(); // Stop realtime when screen closes
    super.dispose();
  }

  /// 🔹 Fetch orders for current user
  Future<void> fetchOrders() async {
    try {
      setState(() => isLoading = true);

      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from('orders')
          .select('''
            id,
            created_at,
            status,
            total_price,
            notes,
            order_products (
              quantity,
              products (
                name
              )
            )
          ''')
          .eq('customer_id', userId) // Must match DB column
          .order('created_at', ascending: false);

      allOrders = List.from(response);
      _applyTabFilter();

      setState(() => isLoading = false);
    } catch (e) {
      debugPrint('SUPABASE ERROR: $e');
      setState(() => isLoading = false);
    }
  }

  /// 🔹 Listen for realtime updates on this user's orders
  void _listenToOrderChanges() {
    final userId = supabase.auth.currentUser!.id;

    _ordersChannel = supabase.channel('orders_changes')
      ..onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'orders',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'customer_id', // Must match fetch query
          value: userId,
        ),
        callback: (payload) {
          fetchOrders(); // Refresh automatically
        },
      )
      ..subscribe();
  }

  /// 🔹 Filter orders locally based on tab
  void _applyTabFilter() {
    filteredOrders = allOrders.where((order) {
      final status = order['status'].toString().toLowerCase();

      if (selectedTab == 'active') {
        return !(status.contains('served') || status.contains('cancel'));
      } else if (selectedTab == 'completed') {
        return status.contains('served');
      } else if (selectedTab == 'cancelled') {
        return status.contains('cancel');
      }
      return false;
    }).toList();
  }

  /// 🔹 Save review into `notes` column
  Future<void> _submitReview(int orderId, String review) async {
    await supabase.from('orders').update({'notes': review}).eq('id', orderId);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context).reviewAddedSuccessfully),
        backgroundColor: const Color(0xFFC72C41),
      ),
    );

    fetchOrders(); // Refresh UI
  }

  /// 🔹 Show review dialog
  void _showReviewDialog(int orderId) {
    final controller = TextEditingController();
    bool isSubmitting = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(S.of(context).leaveAReview),
              content: TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: S.of(context).howWasYourOrder,
                  filled: true,
                  fillColor: const Color(0xFFFFF1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: _dialogActionButton(
                          S.of(context).cancel,
                          onTap: isSubmitting ? null : () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _dialogActionButton(
                          S.of(context).submit,
                          filled: true,
                          onTap: isSubmitting
                              ? null
                              : () async {
                                  setStateDialog(() => isSubmitting = true);
                                  await _submitReview(orderId, controller.text);
                                  if (context.mounted) Navigator.pop(context);
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Returns an icon based on order status.
  /// .ico assets are unsupported by Flutter — use Material icons instead.
  IconData _getStatusIcon(String status) {
    final s = status.toLowerCase();
    if (s.contains('pending')) return Icons.hourglass_empty;
    if (s.contains('preparing')) return Icons.restaurant;
    if (s.contains('served')) return Icons.check_circle_outline;
    if (s.contains('cancelled')) return Icons.cancel_outlined;
    if (s.contains('delivering')) return Icons.delivery_dining;
    if (s.contains('ready')) return Icons.done_all;
    return Icons.receipt_long_outlined;
  }

  /// Pill style button used inside dialogs (auto width, no text cut)
  Widget _dialogActionButton(String text, {bool filled = false, VoidCallback? onTap}) {
    final surface = Theme.of(context).colorScheme.surface;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primary),
        ),
        child: FittedBox(
          // 👈 prevents text overflow
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'LeagueSpartan',
              fontWeight: FontWeight.w600,
              color: filled ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).myOrders),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredOrders.isEmpty
                ? _buildEmptyState()
                : _buildOrdersList(),
          ),
        ],
      ),
    );
  }

  /// 🔹 Tabs layout (no overflow)
  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          Expanded(child: _tabButton(S.of(context).active, 'active')),
          const SizedBox(width: 8),
          Expanded(child: _tabButton(S.of(context).completed, 'completed')),
          const SizedBox(width: 8),
          Expanded(child: _tabButton(S.of(context).cancelled, 'cancelled')),
        ],
      ),
    );
  }

  /// 🔹 Single tab button with responsive text
  Widget _tabButton(String label, String value) {
    final isSelected = selectedTab == value;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = value);
        _applyTabFilter();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.primary),
        ),
        child: FittedBox(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Empty state UI
  // 📭 EMPTY STATE
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.genOrdersEmpty, height: 120, color: const Color(0xFFC72C41)),
            const SizedBox(height: 24),
            Text(
              S.of(context).noActiveOrders,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'MadeEvolveSans',
                fontSize: 18,
                color: context.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Orders list UI
  Widget _buildOrdersList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        final items = (order['order_products'] as List?) ?? [];
        final firstProduct = items.isNotEmpty ? items.first['products'] : null;
        final date = DateTime.parse(order['created_at']);
        final status = order['status'];
        final isDelivered = status.toString().toLowerCase().contains('served');

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5E5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.fastfood,
                      color: Color(0xFFC72C41),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstProduct?['name'] ?? '—',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MadeEvolveSans',
                            fontWeight: FontWeight.w500,
                            color: context.textColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd MMM, hh:mm a').format(date),
                          style: TextStyle(
                            fontFamily: 'LeagueSpartan',
                            color: context.mutedTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC72C41).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getStatusIcon(status),
                                size: 16,
                                color: const Color(0xFFC72C41),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  status,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'LeagueSpartan',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '\$${order['total_price']}',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ],
              ),
              if (isDelivered) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _bigButton(
                        S.of(context).reorder,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(S.of(context).comingSoon)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _bigButton(
                        S.of(context).review,
                        filled: true,
                        onTap: () => _showReviewDialog(order['id']),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
  /// Large action button
  Widget _bigButton(String text, {bool filled = false, VoidCallback? onTap}) {
    final surface = Theme.of(context).colorScheme.surface;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primary),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: filled ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
