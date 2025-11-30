// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_chat_message_list_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderChatMessageListQueryCWProxy {
  OrderChatMessageListQuery orderId(String orderId);

  OrderChatMessageListQuery limit(int limit);

  OrderChatMessageListQuery cursor(String? cursor);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessageListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessageListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessageListQuery call({String orderId, int limit, String? cursor});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderChatMessageListQuery.copyWith(...)` or call `instanceOfOrderChatMessageListQuery.copyWith.fieldName(value)` for a single field.
class _$OrderChatMessageListQueryCWProxyImpl
    implements _$OrderChatMessageListQueryCWProxy {
  const _$OrderChatMessageListQueryCWProxyImpl(this._value);

  final OrderChatMessageListQuery _value;

  @override
  OrderChatMessageListQuery orderId(String orderId) => call(orderId: orderId);

  @override
  OrderChatMessageListQuery limit(int limit) => call(limit: limit);

  @override
  OrderChatMessageListQuery cursor(String? cursor) => call(cursor: cursor);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessageListQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessageListQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessageListQuery call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? cursor = const $CopyWithPlaceholder(),
  }) {
    return OrderChatMessageListQuery(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
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

extension $OrderChatMessageListQueryCopyWith on OrderChatMessageListQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderChatMessageListQuery.copyWith(...)` or `instanceOfOrderChatMessageListQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderChatMessageListQueryCWProxy get copyWith =>
      _$OrderChatMessageListQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderChatMessageListQuery _$OrderChatMessageListQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderChatMessageListQuery', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['orderId', 'limit']);
  final val = OrderChatMessageListQuery(
    orderId: $checkedConvert('orderId', (v) => v as String),
    limit: $checkedConvert('limit', (v) => (v as num).toInt()),
    cursor: $checkedConvert('cursor', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderChatMessageListQueryToJson(
  OrderChatMessageListQuery instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'limit': instance.limit,
  'cursor': ?instance.cursor,
};
