// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatEnvelopePayloadCWProxy {
  SupportChatEnvelopePayload message(SupportChatMessage? message);

  SupportChatEnvelopePayload ticket(SupportTicket? ticket);

  SupportChatEnvelopePayload ticketId(String? ticketId);

  SupportChatEnvelopePayload messageId(String? messageId);

  SupportChatEnvelopePayload isTyping(bool? isTyping);

  SupportChatEnvelopePayload userId(String? userId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatEnvelopePayload call({
    SupportChatMessage? message,
    SupportTicket? ticket,
    String? ticketId,
    String? messageId,
    bool? isTyping,
    String? userId,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatEnvelopePayload.copyWith(...)` or call `instanceOfSupportChatEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$SupportChatEnvelopePayloadCWProxyImpl
    implements _$SupportChatEnvelopePayloadCWProxy {
  const _$SupportChatEnvelopePayloadCWProxyImpl(this._value);

  final SupportChatEnvelopePayload _value;

  @override
  SupportChatEnvelopePayload message(SupportChatMessage? message) =>
      call(message: message);

  @override
  SupportChatEnvelopePayload ticket(SupportTicket? ticket) =>
      call(ticket: ticket);

  @override
  SupportChatEnvelopePayload ticketId(String? ticketId) =>
      call(ticketId: ticketId);

  @override
  SupportChatEnvelopePayload messageId(String? messageId) =>
      call(messageId: messageId);

  @override
  SupportChatEnvelopePayload isTyping(bool? isTyping) =>
      call(isTyping: isTyping);

  @override
  SupportChatEnvelopePayload userId(String? userId) => call(userId: userId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatEnvelopePayload call({
    Object? message = const $CopyWithPlaceholder(),
    Object? ticket = const $CopyWithPlaceholder(),
    Object? ticketId = const $CopyWithPlaceholder(),
    Object? messageId = const $CopyWithPlaceholder(),
    Object? isTyping = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
  }) {
    return SupportChatEnvelopePayload(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as SupportChatMessage?,
      ticket: ticket == const $CopyWithPlaceholder()
          ? _value.ticket
          // ignore: cast_nullable_to_non_nullable
          : ticket as SupportTicket?,
      ticketId: ticketId == const $CopyWithPlaceholder()
          ? _value.ticketId
          // ignore: cast_nullable_to_non_nullable
          : ticketId as String?,
      messageId: messageId == const $CopyWithPlaceholder()
          ? _value.messageId
          // ignore: cast_nullable_to_non_nullable
          : messageId as String?,
      isTyping: isTyping == const $CopyWithPlaceholder()
          ? _value.isTyping
          // ignore: cast_nullable_to_non_nullable
          : isTyping as bool?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as String?,
    );
  }
}

extension $SupportChatEnvelopePayloadCopyWith on SupportChatEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatEnvelopePayload.copyWith(...)` or `instanceOfSupportChatEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatEnvelopePayloadCWProxy get copyWith =>
      _$SupportChatEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatEnvelopePayload _$SupportChatEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportChatEnvelopePayload', json, ($checkedConvert) {
  final val = SupportChatEnvelopePayload(
    message: $checkedConvert(
      'message',
      (v) => v == null
          ? null
          : SupportChatMessage.fromJson(v as Map<String, dynamic>),
    ),
    ticket: $checkedConvert(
      'ticket',
      (v) =>
          v == null ? null : SupportTicket.fromJson(v as Map<String, dynamic>),
    ),
    ticketId: $checkedConvert('ticketId', (v) => v as String?),
    messageId: $checkedConvert('messageId', (v) => v as String?),
    isTyping: $checkedConvert('isTyping', (v) => v as bool?),
    userId: $checkedConvert('userId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$SupportChatEnvelopePayloadToJson(
  SupportChatEnvelopePayload instance,
) => <String, dynamic>{
  'message': ?instance.message?.toJson(),
  'ticket': ?instance.ticket?.toJson(),
  'ticketId': ?instance.ticketId,
  'messageId': ?instance.messageId,
  'isTyping': ?instance.isTyping,
  'userId': ?instance.userId,
};
