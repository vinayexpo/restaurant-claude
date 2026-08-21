import '../models/delivery_order.dart';
import '../models/restaurant_summary.dart';
import '../network/api_client.dart';
import '../network/paginated_response.dart';

class CustomerRepository {
  CustomerRepository(this._client);

  final ApiClient _client;

  Future<List<RestaurantSummary>> featuredRestaurants() async {
    final response = await _client.get('/restaurants/featured');
    final data = response['data'] as List<dynamic>? ?? const [];
    return data
        .map((item) => RestaurantSummary.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<PaginatedResponse<RestaurantSummary>> restaurants() async {
    final response = await _client.get('/restaurants');
    final data = response['data'] as List<dynamic>? ?? const [];
    final meta = response['meta'] as Map<String, dynamic>? ?? const {};

    return PaginatedResponse(
      items: data
          .map(
            (item) => RestaurantSummary.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      page: (meta['page'] as num?)?.toInt() ?? 1,
      perPage: (meta['per_page'] as num?)?.toInt() ?? data.length,
      total: (meta['total'] as num?)?.toInt() ?? data.length,
      lastPage: (meta['last_page'] as num?)?.toInt() ?? 1,
    );
  }

  Future<PaginatedResponse<DeliveryOrder>> orders() async {
    final response = await _client.get('/orders');
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
}
