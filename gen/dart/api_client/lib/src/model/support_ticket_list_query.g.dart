// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_list_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportTicketListQueryCWProxy {
  SupportTicketListQuery status(SupportTicketStatus? status);

  SupportTicketListQuery category(SupportTicketCategory? category);

  SupportTicketListQuery priority(SupportTicketPriority? priority);

  SupportTicketListQuery assignedToId(String? assignedToId);

  SupportTicketListQuery userId(String? userId);

  SupportTicketListQuery search(String? search);

  SupportTicketListQuery limit(int limit);

  SupportTicketListQuery cursor(String? cursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketListQuery call({
    SupportTicketStatus? status,
    SupportTicketCategory? category,
    SupportTicketPriority? priority,
    String? assignedToId,
    String? userId,
    String? search,
    int limit,
    String? cursor,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportTicketListQuery.copyWith(...)` or call `instanceOfSupportTicketListQuery.copyWith.fieldName(value)` for a single field.
class _$SupportTicketListQueryCWProxyImpl
    implements _$SupportTicketListQueryCWProxy {
  const _$SupportTicketListQueryCWProxyImpl(this._value);

  final SupportTicketListQuery _value;

  @override
  SupportTicketListQuery status(SupportTicketStatus? status) =>
      call(status: status);

  @override
  SupportTicketListQuery category(SupportTicketCategory? category) =>
      call(category: category);

  @override
  SupportTicketListQuery priority(SupportTicketPriority? priority) =>
      call(priority: priority);

  @override
  SupportTicketListQuery assignedToId(String? assignedToId) =>
      call(assignedToId: assignedToId);

  @override
  SupportTicketListQuery userId(String? userId) => call(userId: userId);

  @override
  SupportTicketListQuery search(String? search) => call(search: search);

  @override
  SupportTicketListQuery limit(int limit) => call(limit: limit);

  @override
  SupportTicketListQuery cursor(String? cursor) => call(cursor: cursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportTicketListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportTicketListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportTicketListQuery call({
    Object? status = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? priority = const $CopyWithPlaceholder(),
    Object? assignedToId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? search = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? cursor = const $CopyWithPlaceholder(),
  }) {
    return SupportTicketListQuery(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as SupportTicketStatus?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as SupportTicketCategory?,
      priority: priority == const $CopyWithPlaceholder()
          ? _value.priority
          // ignore: cast_nullable_to_non_nullable
          : priority as SupportTicketPriority?,
      assignedToId: assignedToId == const $CopyWithPlaceholder()
          ? _value.assignedToId
          // ignore: cast_nullable_to_non_nullable
          : assignedToId as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
      search: search == const $CopyWithPlaceholder()
          ? _value.search
          // ignore: cast_nullable_to_non_nullable
          : search as String?,
      limit: limit == const $CopyWithPlaceholder() || limit == null
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int,
      cursor: cursor == const $CopyWithPlaceholder()
          ? _value.cursor
          // ignore: cast_nullable_to_non_nullable
          : cursor as String?,
    );
  }
}

extension $SupportTicketListQueryCopyWith on SupportTicketListQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportTicketListQuery.copyWith(...)` or `instanceOfSupportTicketListQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportTicketListQueryCWProxy get copyWith =>
      _$SupportTicketListQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketListQuery _$SupportTicketListQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportTicketListQuery', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['limit']);
  final val = SupportTicketListQuery(
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$SupportTicketStatusEnumMap, v),
    ),
    category: $checkedConvert(
      'category',
      (v) => $enumDecodeNullable(_$SupportTicketCategoryEnumMap, v),
    ),
    priority: $checkedConvert(
      'priority',
      (v) => $enumDecodeNullable(_$SupportTicketPriorityEnumMap, v),
    ),
    assignedToId: $checkedConvert('assignedToId', (v) => v as String?),
    userId: $checkedConvert('userId', (v) => v as String?),
    search: $checkedConvert('search', (v) => v as String?),
    limit: $checkedConvert('limit', (v) => (v as num).toInt()),
    cursor: $checkedConvert('cursor', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$SupportTicketListQueryToJson(
  SupportTicketListQuery instance,
) => <String, dynamic>{
  'status': ?_$SupportTicketStatusEnumMap[instance.status],
  'category': ?_$SupportTicketCategoryEnumMap[instance.category],
  'priority': ?_$SupportTicketPriorityEnumMap[instance.priority],
  'assignedToId': ?instance.assignedToId,
  'userId': ?instance.userId,
  'search': ?instance.search,
  'limit': instance.limit,
  'cursor': ?instance.cursor,
};

const _$SupportTicketStatusEnumMap = {
  SupportTicketStatus.OPEN: 'OPEN',
  SupportTicketStatus.IN_PROGRESS: 'IN_PROGRESS',
  SupportTicketStatus.WAITING_USER: 'WAITING_USER',
  SupportTicketStatus.RESOLVED: 'RESOLVED',
  SupportTicketStatus.CLOSED: 'CLOSED',
};

const _$SupportTicketCategoryEnumMap = {
  SupportTicketCategory.GENERAL: 'GENERAL',
  SupportTicketCategory.ORDER_ISSUE: 'ORDER_ISSUE',
  SupportTicketCategory.PAYMENT_ISSUE: 'PAYMENT_ISSUE',
  SupportTicketCategory.DRIVER_COMPLAINT: 'DRIVER_COMPLAINT',
  SupportTicketCategory.MERCHANT_COMPLAINT: 'MERCHANT_COMPLAINT',
  SupportTicketCategory.ACCOUNT_ISSUE: 'ACCOUNT_ISSUE',
  SupportTicketCategory.TECHNICAL_ISSUE: 'TECHNICAL_ISSUE',
  SupportTicketCategory.FEATURE_REQUEST: 'FEATURE_REQUEST',
  SupportTicketCategory.OTHER: 'OTHER',
};

const _$SupportTicketPriorityEnumMap = {
  SupportTicketPriority.LOW: 'LOW',
  SupportTicketPriority.MEDIUM: 'MEDIUM',
  SupportTicketPriority.HIGH: 'HIGH',
  SupportTicketPriority.URGENT: 'URGENT',
};
