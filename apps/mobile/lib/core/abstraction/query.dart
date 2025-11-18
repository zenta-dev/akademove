// enum OrderBy { asc, desc }

import 'package:api_client/api_client.dart';

class UnifiedQuery {
  const UnifiedQuery({
    this.limit = 10,
    this.page,
    this.cursor,
    this.query,
    this.sortBy,
    this.orderBy = PaginationOrder.desc,
  });

  final int? page;
  final String? cursor;
  final int limit;
  final String? query;
  final String? sortBy;
  final PaginationOrder orderBy;

  bool get isOffsetPagination => page != null;
  bool get isCursorPagination => cursor != null;
}
