enum OrderBy { asc, desc }

class UnifiedQuery {
  const UnifiedQuery({
    this.limit = 10,
    this.page,
    this.cursor,
    this.query,
    this.sortBy,
    this.orderBy = OrderBy.desc,
  });

  final int? page;
  final String? cursor;
  final int limit;
  final String? query;
  final String? sortBy;
  final OrderBy orderBy;

  bool get isOffsetPagination => page != null;
  bool get isCursorPagination => cursor != null;
}
