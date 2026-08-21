class EarningsSummary {
  const EarningsSummary({
    required this.today,
    required this.week,
    required this.month,
    required this.totalDeliveries,
  });

  final double today;
  final double week;
  final double month;
  final int totalDeliveries;

  factory EarningsSummary.fromJson(Map<String, dynamic> json) {
    return EarningsSummary(
      today: (json['today'] as num?)?.toDouble() ?? 0,
      week: (json['week'] as num?)?.toDouble() ?? 0,
      month: (json['month'] as num?)?.toDouble() ?? 0,
      totalDeliveries: (json['total_deliveries'] as num?)?.toInt() ?? 0,
    );
  }
}
