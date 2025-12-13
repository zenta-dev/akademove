// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_chat_unread_count.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadChatUnreadCountCWProxy {
  OrderEnvelopePayloadChatUnreadCount orderId(String orderId);

  OrderEnvelopePayloadChatUnreadCount userId(String userId);

  OrderEnvelopePayloadChatUnreadCount unreadCount(int unreadCount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadChatUnreadCount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadChatUnreadCount(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadChatUnreadCount call({
    String orderId,
    String userId,
    int unreadCount,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadChatUnreadCount.copyWith(...)` or call `instanceOfOrderEnvelopePayloadChatUnreadCount.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadChatUnreadCountCWProxyImpl
    implements _$OrderEnvelopePayloadChatUnreadCountCWProxy {
  const _$OrderEnvelopePayloadChatUnreadCountCWProxyImpl(this._value);

  final OrderEnvelopePayloadChatUnreadCount _value;

  @override
  OrderEnvelopePayloadChatUnreadCount orderId(String orderId) =>
      call(orderId: orderId);

  @override
  OrderEnvelopePayloadChatUnreadCount userId(String userId) =>
      call(userId: userId);

  @override
  OrderEnvelopePayloadChatUnreadCount unreadCount(int unreadCount) =>
      call(unreadCount: unreadCount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadChatUnreadCount(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadChatUnreadCount(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadChatUnreadCount call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? unreadCount = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadChatUnreadCount(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      userId: userId == const $CopyWithPlaceholder() || userId == null
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String,
      unreadCount:
          unreadCount == const $CopyWithPlaceholder() || unreadCount == null
          ? _value.unreadCount
          // ignore: cast_nullable_to_non_nullable
          : unreadCount as int,
    );
  }
}

extension $OrderEnvelopePayloadChatUnreadCountCopyWith
    on OrderEnvelopePayloadChatUnreadCount {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadChatUnreadCount.copyWith(...)` or `instanceOfOrderEnvelopePayloadChatUnreadCount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadChatUnreadCountCWProxy get copyWith =>
      _$OrderEnvelopePayloadChatUnreadCountCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadChatUnreadCount
_$OrderEnvelopePayloadChatUnreadCountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderEnvelopePayloadChatUnreadCount', json, (
      $checkedConvert,
    ) {
      $checkKeys(
        json,
        requiredKeys: const ['orderId', 'userId', 'unreadCount'],
      );
      final val = OrderEnvelopePayloadChatUnreadCount(
        orderId: $checkedConvert('orderId', (v) => v as String),
        userId: $checkedConvert('userId', (v) => v as String),
        unreadCount: $checkedConvert('unreadCount', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$OrderEnvelopePayloadChatUnreadCountToJson(
  OrderEnvelopePayloadChatUnreadCount instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'userId': instance.userId,
  'unreadCount': instance.unreadCount,
};
