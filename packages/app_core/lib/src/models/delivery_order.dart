import 'package:intl/intl.dart';

class DeliveryOrder {
  const DeliveryOrder({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.restaurantName,
    required this.status,
    required this.deliveryAddress,
    required this.distanceKm,
    required this.amount,
    required this.createdAtLabel,
  });

  final int id;
  final String orderNumber;
  final String customerName;
  final String restaurantName;
  final String status;
  final String deliveryAddress;
  final double distanceKm;
  final double amount;
  final String createdAtLabel;

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    final restaurant = json['restaurant'] as Map<String, dynamic>? ?? const {};
    final user = json['user'] as Map<String, dynamic>? ?? const {};
    final address =
        json['delivery_address'] as Map<String, dynamic>? ??
        json['deliveryAddress'] as Map<String, dynamic>? ??
        const {};
    final createdAt = json['created_at']?.toString();

    return DeliveryOrder(
      id: (json['id'] as num?)?.toInt() ?? 0,
      orderNumber: (json['order_number'] ?? '#${json['id'] ?? '--'}')
          .toString(),
      customerName: (user['name'] ?? 'Customer').toString(),
      restaurantName: (restaurant['name'] ?? 'Restaurant').toString(),
      status: (json['status'] ?? 'pending').toString(),
      deliveryAddress:
          [
                address['line1'],
                address['line2'],
                address['address'],
                address['city'],
              ]
              .whereType<Object>()
              .map((item) => item.toString())
              .where((item) => item.isNotEmpty)
              .join(', '),
      distanceKm: (json['distance'] as num?)?.toDouble() ?? 0,
      amount:
          (json['total_amount'] as num?)?.toDouble() ??
          (json['amount_earned'] as num?)?.toDouble() ??
          0,
      createdAtLabel: createdAt == null
          ? 'Now'
          : DateFormat(
              'dd MMM, hh:mm a',
            ).format(DateTime.parse(createdAt).toLocal()),
    );
  }
}
