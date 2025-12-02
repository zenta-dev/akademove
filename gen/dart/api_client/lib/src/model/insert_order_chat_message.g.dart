// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_order_chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertOrderChatMessageCWProxy {
  InsertOrderChatMessage orderId(String orderId);

  InsertOrderChatMessage message(String message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertOrderChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertOrderChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertOrderChatMessage call({String orderId, String message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertOrderChatMessage.copyWith(...)` or call `instanceOfInsertOrderChatMessage.copyWith.fieldName(value)` for a single field.
class _$InsertOrderChatMessageCWProxyImpl
    implements _$InsertOrderChatMessageCWProxy {
  const _$InsertOrderChatMessageCWProxyImpl(this._value);

  final InsertOrderChatMessage _value;

  @override
  InsertOrderChatMessage orderId(String orderId) => call(orderId: orderId);

  @override
  InsertOrderChatMessage message(String message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertOrderChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertOrderChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertOrderChatMessage call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return InsertOrderChatMessage(
      orderId: orderId == const $CopyWithPlaceholder() || orderId == null
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $InsertOrderChatMessageCopyWith on InsertOrderChatMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertOrderChatMessage.copyWith(...)` or `instanceOfInsertOrderChatMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertOrderChatMessageCWProxy get copyWith =>
      _$InsertOrderChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertOrderChatMessage _$InsertOrderChatMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertOrderChatMessage', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['orderId', 'message']);
  final val = InsertOrderChatMessage(
    orderId: $checkedConvert('orderId', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$InsertOrderChatMessageToJson(
  InsertOrderChatMessage instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'message': instance.message,
};
