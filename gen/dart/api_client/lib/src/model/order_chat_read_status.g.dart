// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_chat_read_status.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderChatReadStatusCWProxy {
  OrderChatReadStatus id(String id);

  OrderChatReadStatus orderId(String orderId);

  OrderChatReadStatus userId(String userId);

  OrderChatReadStatus lastReadMessageId(String? lastReadMessageId);

  OrderChatReadStatus lastReadAt(DateTime? lastReadAt);

  OrderChatReadStatus createdAt(DateTime createdAt);

  OrderChatReadStatus updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatReadStatus(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatReadStatus(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatReadStatus call({
    String id,
    String orderId,
    String userId,
    String? lastReadMessageId,
    DateTime? lastReadAt,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderChatReadStatus.copyWith(...)` or call `instanceOfOrderChatReadStatus.copyWith.fieldName(value)` for a single field.
class _$OrderChatReadStatusCWProxyImpl implements _$OrderChatReadStatusCWProxy {
  const _$OrderChatReadStatusCWProxyImpl(this._value);

  final OrderChatReadStatus _value;

  @override
  OrderChatReadStatus id(String id) => call(id: id);

  @override
  OrderChatReadStatus orderId(String orderId) => call(orderId: orderId);

  @override
  OrderChatReadStatus userId(String userId) => call(userId: userId);

  @override
  OrderChatReadStatus lastReadMessageId(String? lastReadMessageId) =>
      call(lastReadMessageId: lastReadMessageId);

  @override
  OrderChatReadStatus lastReadAt(DateTime? lastReadAt) =>
      call(lastReadAt: lastReadAt);

  @override
  OrderChatReadStatus createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  OrderChatReadStatus updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatReadStatus(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatReadStatus(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatReadStatus call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? lastReadMessageId = const $CopyWithPlaceholder(),
    Object? lastReadAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OrderChatReadStatus(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      lastReadMessageId: lastReadMessageId == const $CopyWithPlaceholder()
          ? _value.lastReadMessageId
          // ignore: cast_nullable_to_non_nullable
          : lastReadMessageId as String?,
      lastReadAt: lastReadAt == const $CopyWithPlaceholder()
          ? _value.lastReadAt
          // ignore: cast_nullable_to_non_nullable
          : lastReadAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $OrderChatReadStatusCopyWith on OrderChatReadStatus {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderChatReadStatus.copyWith(...)` or `instanceOfOrderChatReadStatus.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderChatReadStatusCWProxy get copyWith =>
      _$OrderChatReadStatusCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderChatReadStatus _$OrderChatReadStatusFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderChatReadStatus', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'orderId',
      'userId',
      'lastReadMessageId',
      'lastReadAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = OrderChatReadStatus(
    id: $checkedConvert('id', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    lastReadMessageId: $checkedConvert(
      'lastReadMessageId',
      (v) => v as String?,
    ),
    lastReadAt: $checkedConvert(
      'lastReadAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$OrderChatReadStatusToJson(
  OrderChatReadStatus instance,
) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'userId': instance.userId,
  'lastReadMessageId': instance.lastReadMessageId,
  'lastReadAt': instance.lastReadAt?.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
