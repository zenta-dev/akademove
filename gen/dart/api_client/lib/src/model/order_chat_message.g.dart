// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderChatMessageCWProxy {
  OrderChatMessage id(String id);

  OrderChatMessage orderId(String orderId);

  OrderChatMessage senderId(String senderId);

  OrderChatMessage message(String message);

  OrderChatMessage sentAt(DateTime sentAt);

  OrderChatMessage createdAt(DateTime createdAt);

  OrderChatMessage updatedAt(DateTime updatedAt);

  OrderChatMessage sender(OrderChatMessageSender? sender);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessage call({
    String id,
    String orderId,
    String senderId,
    String message,
    DateTime sentAt,
    DateTime createdAt,
    DateTime updatedAt,
    OrderChatMessageSender? sender,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderChatMessage.copyWith(...)` or call `instanceOfOrderChatMessage.copyWith.fieldName(value)` for a single field.
class _$OrderChatMessageCWProxyImpl implements _$OrderChatMessageCWProxy {
  const _$OrderChatMessageCWProxyImpl(this._value);

  final OrderChatMessage _value;

  @override
  OrderChatMessage id(String id) => call(id: id);

  @override
  OrderChatMessage orderId(String orderId) => call(orderId: orderId);

  @override
  OrderChatMessage senderId(String senderId) => call(senderId: senderId);

  @override
  OrderChatMessage message(String message) => call(message: message);

  @override
  OrderChatMessage sentAt(DateTime sentAt) => call(sentAt: sentAt);

  @override
  OrderChatMessage createdAt(DateTime createdAt) => call(createdAt: createdAt);

  @override
  OrderChatMessage updatedAt(DateTime updatedAt) => call(updatedAt: updatedAt);

  @override
  OrderChatMessage sender(OrderChatMessageSender? sender) =>
      call(sender: sender);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessage call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? senderId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
  }) {
    return OrderChatMessage(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      senderId: senderId == const $CopyWithPlaceholder() || senderId == null
          ? _value.senderId
          // ignore: cast_nullable_to_non_nullable
          : senderId as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      sentAt: sentAt == const $CopyWithPlaceholder() || sentAt == null
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as OrderChatMessageSender?,
    );
  }
}

extension $OrderChatMessageCopyWith on OrderChatMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderChatMessage.copyWith(...)` or `instanceOfOrderChatMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderChatMessageCWProxy get copyWith => _$OrderChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderChatMessage _$OrderChatMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderChatMessage', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'orderId',
      'senderId',
      'message',
      'sentAt',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = OrderChatMessage(
    id: $checkedConvert('id', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    senderId: $checkedConvert('senderId', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
    sentAt: $checkedConvert('sentAt', (v) => DateTime.parse(v as String)),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
    sender: $checkedConvert(
      'sender',
      (v) => v == null
          ? null
          : OrderChatMessageSender.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderChatMessageToJson(OrderChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'senderId': instance.senderId,
      'message': instance.message,
      'sentAt': instance.sentAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'sender': ?instance.sender?.toJson(),
    };
