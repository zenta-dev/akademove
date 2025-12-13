// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadMessageCWProxy {
  OrderEnvelopePayloadMessage id(String id);

  OrderEnvelopePayloadMessage orderId(String orderId);

  OrderEnvelopePayloadMessage senderId(String senderId);

  OrderEnvelopePayloadMessage senderName(String senderName);

  OrderEnvelopePayloadMessage senderRole(
    OrderEnvelopePayloadMessageSenderRoleEnum senderRole,
  );

  OrderEnvelopePayloadMessage message(String message);

  OrderEnvelopePayloadMessage sentAt(DateTime sentAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadMessage call({
    String id,
    String orderId,
    String senderId,
    String senderName,
    OrderEnvelopePayloadMessageSenderRoleEnum senderRole,
    String message,
    DateTime sentAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadMessage.copyWith(...)` or call `instanceOfOrderEnvelopePayloadMessage.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadMessageCWProxyImpl
    implements _$OrderEnvelopePayloadMessageCWProxy {
  const _$OrderEnvelopePayloadMessageCWProxyImpl(this._value);

  final OrderEnvelopePayloadMessage _value;

  @override
  OrderEnvelopePayloadMessage id(String id) => call(id: id);

  @override
  OrderEnvelopePayloadMessage orderId(String orderId) => call(orderId: orderId);

  @override
  OrderEnvelopePayloadMessage senderId(String senderId) =>
      call(senderId: senderId);

  @override
  OrderEnvelopePayloadMessage senderName(String senderName) =>
      call(senderName: senderName);

  @override
  OrderEnvelopePayloadMessage senderRole(
    OrderEnvelopePayloadMessageSenderRoleEnum senderRole,
  ) => call(senderRole: senderRole);

  @override
  OrderEnvelopePayloadMessage message(String message) => call(message: message);

  @override
  OrderEnvelopePayloadMessage sentAt(DateTime sentAt) => call(sentAt: sentAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadMessage call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? senderId = const $CopyWithPlaceholder(),
    Object? senderName = const $CopyWithPlaceholder(),
    Object? senderRole = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadMessage(
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
      senderName:
          senderName == const $CopyWithPlaceholder() || senderName == null
          ? _value.senderName
          // ignore: cast_nullable_to_non_nullable
          : senderName as String,
      senderRole:
          senderRole == const $CopyWithPlaceholder() || senderRole == null
          ? _value.senderRole
          // ignore: cast_nullable_to_non_nullable
          : senderRole as OrderEnvelopePayloadMessageSenderRoleEnum,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      sentAt: sentAt == const $CopyWithPlaceholder() || sentAt == null
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime,
    );
  }
}

extension $OrderEnvelopePayloadMessageCopyWith on OrderEnvelopePayloadMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadMessage.copyWith(...)` or `instanceOfOrderEnvelopePayloadMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadMessageCWProxy get copyWith =>
      _$OrderEnvelopePayloadMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadMessage _$OrderEnvelopePayloadMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadMessage', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'orderId',
      'senderId',
      'senderName',
      'senderRole',
      'message',
      'sentAt',
    ],
  );
  final val = OrderEnvelopePayloadMessage(
    id: $checkedConvert('id', (v) => v as String),
    orderId: $checkedConvert('orderId', (v) => v as String),
    senderId: $checkedConvert('senderId', (v) => v as String),
    senderName: $checkedConvert('senderName', (v) => v as String),
    senderRole: $checkedConvert(
      'senderRole',
      (v) => $enumDecode(_$OrderEnvelopePayloadMessageSenderRoleEnumEnumMap, v),
    ),
    message: $checkedConvert('message', (v) => v as String),
    sentAt: $checkedConvert('sentAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadMessageToJson(
  OrderEnvelopePayloadMessage instance,
) => <String, dynamic>{
  'id': instance.id,
  'orderId': instance.orderId,
  'senderId': instance.senderId,
  'senderName': instance.senderName,
  'senderRole':
      _$OrderEnvelopePayloadMessageSenderRoleEnumEnumMap[instance.senderRole]!,
  'message': instance.message,
  'sentAt': instance.sentAt.toIso8601String(),
};

const _$OrderEnvelopePayloadMessageSenderRoleEnumEnumMap = {
  OrderEnvelopePayloadMessageSenderRoleEnum.USER: 'USER',
  OrderEnvelopePayloadMessageSenderRoleEnum.DRIVER: 'DRIVER',
  OrderEnvelopePayloadMessageSenderRoleEnum.MERCHANT: 'MERCHANT',
};
