import '../models/delivery_order.dart';
import '../models/earnings_summary.dart';
import '../network/api_client.dart';
import '../network/paginated_response.dart';

class DeliveryRepository {
  DeliveryRepository(this._client);

  final ApiClient _client;

  Future<List<DeliveryOrder>> availableOrders() async {
    final response = await _client.get('/delivery/orders/available');
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map((item) => DeliveryOrder.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<PaginatedResponse<DeliveryOrder>> history() async {
    final response = await _client.get('/delivery/history');
    final data = response['data'] as List<dynamic>? ?? const [];
    final meta = response['meta'] as Map<String, dynamic>? ?? const {};

    return PaginatedResponse(
      items: data
          .map((item) => DeliveryOrder.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: (meta['page'] as num?)?.toInt() ?? 1,
      perPage: (meta['per_page'] as num?)?.toInt() ?? data.length,
      total: (meta['total'] as num?)?.toInt() ?? data.length,
      lastPage: (meta['last_page'] as num?)?.toInt() ?? 1,
    );
  }

  Future<EarningsSummary> earningsSummary() async {
    final response = await _client.get('/delivery/earnings/summary');
    return EarningsSummary.fromJson(
      response['data'] as Map<String, dynamic>? ?? const {},
    );
  }

  Future<void> updateAvailability(bool isAvailable) async {
    await _client.patch(
      '/delivery/availability',
      data: {'is_available': isAvailable},
    );
  }
}
