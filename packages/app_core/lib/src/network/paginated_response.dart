class PaginatedResponse<T> {
  const PaginatedResponse({
    required this.items,
    this.page = 1,
    this.perPage = 15,
    this.total = 0,
    this.lastPage = 1,
  });

  final List<T> items;
  final int page;
  final int perPage;
  final int total;
  final int lastPage;
}
