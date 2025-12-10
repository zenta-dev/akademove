// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_support_chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertSupportChatMessageCWProxy {
  InsertSupportChatMessage ticketId(String ticketId);

  InsertSupportChatMessage message(String message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertSupportChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertSupportChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertSupportChatMessage call({String ticketId, String message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertSupportChatMessage.copyWith(...)` or call `instanceOfInsertSupportChatMessage.copyWith.fieldName(value)` for a single field.
class _$InsertSupportChatMessageCWProxyImpl
    implements _$InsertSupportChatMessageCWProxy {
  const _$InsertSupportChatMessageCWProxyImpl(this._value);

  final InsertSupportChatMessage _value;

  @override
  InsertSupportChatMessage ticketId(String ticketId) =>
      call(ticketId: ticketId);

  @override
  InsertSupportChatMessage message(String message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertSupportChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertSupportChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertSupportChatMessage call({
    Object? ticketId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return InsertSupportChatMessage(
      ticketId: ticketId == const $CopyWithPlaceholder() || ticketId == null
          ? _value.ticketId
          // ignore: cast_nullable_to_non_nullable
          : ticketId as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $InsertSupportChatMessageCopyWith on InsertSupportChatMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertSupportChatMessage.copyWith(...)` or `instanceOfInsertSupportChatMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertSupportChatMessageCWProxy get copyWith =>
      _$InsertSupportChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertSupportChatMessage _$InsertSupportChatMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertSupportChatMessage', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ticketId', 'message']);
  final val = InsertSupportChatMessage(
    ticketId: $checkedConvert('ticketId', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$InsertSupportChatMessageToJson(
  InsertSupportChatMessage instance,
) => <String, dynamic>{
  'ticketId': instance.ticketId,
  'message': instance.message,
};
