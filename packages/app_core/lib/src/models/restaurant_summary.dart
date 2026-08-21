class RestaurantSummary {
  const RestaurantSummary({
    required this.id,
    required this.name,
    required this.city,
    required this.rating,
    required this.deliveryFee,
    required this.cuisines,
    required this.isFeatured,
  });

  final int id;
  final String name;
  final String city;
  final double rating;
  final double deliveryFee;
  final List<String> cuisines;
  final bool isFeatured;

  factory RestaurantSummary.fromJson(Map<String, dynamic> json) {
    final cuisineTypes = json['cuisine_types'];
    return RestaurantSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: (json['name'] ?? '') as String,
      city: (json['city'] ?? '') as String,
      rating: (json['avg_rating'] as num?)?.toDouble() ?? 0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0,
      cuisines: cuisineTypes is List
          ? cuisineTypes.map((item) => item.toString()).toList()
          : const [],
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
    );
  }
}
