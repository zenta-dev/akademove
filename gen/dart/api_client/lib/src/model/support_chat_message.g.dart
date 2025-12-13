// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_message.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatMessageCWProxy {
  SupportChatMessage id(String id);

  SupportChatMessage ticketId(String ticketId);

  SupportChatMessage senderId(String senderId);

  SupportChatMessage message(String message);

  SupportChatMessage isFromSupport(bool isFromSupport);

  SupportChatMessage readAt(DateTime? readAt);

  SupportChatMessage sentAt(DateTime? sentAt);

  SupportChatMessage createdAt(DateTime? createdAt);

  SupportChatMessage updatedAt(DateTime? updatedAt);

  SupportChatMessage sender(SupportTicketAssignedTo? sender);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMessage call({
    String id,
    String ticketId,
    String senderId,
    String message,
    bool isFromSupport,
    DateTime? readAt,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    SupportTicketAssignedTo? sender,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatMessage.copyWith(...)` or call `instanceOfSupportChatMessage.copyWith.fieldName(value)` for a single field.
class _$SupportChatMessageCWProxyImpl implements _$SupportChatMessageCWProxy {
  const _$SupportChatMessageCWProxyImpl(this._value);

  final SupportChatMessage _value;

  @override
  SupportChatMessage id(String id) => call(id: id);

  @override
  SupportChatMessage ticketId(String ticketId) => call(ticketId: ticketId);

  @override
  SupportChatMessage senderId(String senderId) => call(senderId: senderId);

  @override
  SupportChatMessage message(String message) => call(message: message);

  @override
  SupportChatMessage isFromSupport(bool isFromSupport) =>
      call(isFromSupport: isFromSupport);

  @override
  SupportChatMessage readAt(DateTime? readAt) => call(readAt: readAt);

  @override
  SupportChatMessage sentAt(DateTime? sentAt) => call(sentAt: sentAt);

  @override
  SupportChatMessage createdAt(DateTime? createdAt) =>
      call(createdAt: createdAt);

  @override
  SupportChatMessage updatedAt(DateTime? updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  SupportChatMessage sender(SupportTicketAssignedTo? sender) =>
      call(sender: sender);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMessage(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMessage(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMessage call({
    Object? id = const $CopyWithPlaceholder(),
    Object? ticketId = const $CopyWithPlaceholder(),
    Object? senderId = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? isFromSupport = const $CopyWithPlaceholder(),
    Object? readAt = const $CopyWithPlaceholder(),
    Object? sentAt = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
  }) {
    return SupportChatMessage(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ticketId: ticketId == const $CopyWithPlaceholder() || ticketId == null
          ? _value.ticketId
          // ignore: cast_nullable_to_non_nullable
          : ticketId as String,
      senderId: senderId == const $CopyWithPlaceholder() || senderId == null
          ? _value.senderId
          // ignore: cast_nullable_to_non_nullable
          : senderId as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      isFromSupport:
          isFromSupport == const $CopyWithPlaceholder() || isFromSupport == null
          ? _value.isFromSupport
          // ignore: cast_nullable_to_non_nullable
          : isFromSupport as bool,
      readAt: readAt == const $CopyWithPlaceholder()
          ? _value.readAt
          // ignore: cast_nullable_to_non_nullable
          : readAt as DateTime?,
      sentAt: sentAt == const $CopyWithPlaceholder()
          ? _value.sentAt
          // ignore: cast_nullable_to_non_nullable
          : sentAt as DateTime?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
      sender: sender == const $CopyWithPlaceholder()
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as SupportTicketAssignedTo?,
    );
  }
}

extension $SupportChatMessageCopyWith on SupportChatMessage {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatMessage.copyWith(...)` or `instanceOfSupportChatMessage.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatMessageCWProxy get copyWith =>
      _$SupportChatMessageCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatMessage _$SupportChatMessageFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatMessage', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'ticketId',
          'senderId',
          'message',
          'isFromSupport',
          'sentAt',
          'createdAt',
          'updatedAt',
        ],
      );
      final val = SupportChatMessage(
        id: $checkedConvert('id', (v) => v as String),
        ticketId: $checkedConvert('ticketId', (v) => v as String),
        senderId: $checkedConvert('senderId', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
        isFromSupport: $checkedConvert('isFromSupport', (v) => v as bool),
        readAt: $checkedConvert(
          'readAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        sentAt: $checkedConvert(
          'sentAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        sender: $checkedConvert(
          'sender',
          (v) => v == null
              ? null
              : SupportTicketAssignedTo.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatMessageToJson(SupportChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticketId': instance.ticketId,
      'senderId': instance.senderId,
      'message': instance.message,
      'isFromSupport': instance.isFromSupport,
      'readAt': ?instance.readAt?.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'sender': ?instance.sender?.toJson(),
    };
