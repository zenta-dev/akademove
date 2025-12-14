// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_mark_as_read_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatMarkAsReadRequestCWProxy {
  SupportChatMarkAsReadRequest ticketId(String ticketId);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsReadRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsReadRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsReadRequest call({String ticketId});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatMarkAsReadRequest.copyWith(...)` or call `instanceOfSupportChatMarkAsReadRequest.copyWith.fieldName(value)` for a single field.
class _$SupportChatMarkAsReadRequestCWProxyImpl
    implements _$SupportChatMarkAsReadRequestCWProxy {
  const _$SupportChatMarkAsReadRequestCWProxyImpl(this._value);

  final SupportChatMarkAsReadRequest _value;

  @override
  SupportChatMarkAsReadRequest ticketId(String ticketId) =>
      call(ticketId: ticketId);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsReadRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsReadRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsReadRequest call({
    Object? ticketId = const $CopyWithPlaceholder(),
  }) {
    return SupportChatMarkAsReadRequest(
      ticketId: ticketId == const $CopyWithPlaceholder() || ticketId == null
          ? _value.ticketId
          // ignore: cast_nullable_to_non_nullable
          : ticketId as String,
    );
  }
}

extension $SupportChatMarkAsReadRequestCopyWith
    on SupportChatMarkAsReadRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatMarkAsReadRequest.copyWith(...)` or `instanceOfSupportChatMarkAsReadRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatMarkAsReadRequestCWProxy get copyWith =>
      _$SupportChatMarkAsReadRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatMarkAsReadRequest _$SupportChatMarkAsReadRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportChatMarkAsReadRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['ticketId']);
  final val = SupportChatMarkAsReadRequest(
    ticketId: $checkedConvert('ticketId', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$SupportChatMarkAsReadRequestToJson(
  SupportChatMarkAsReadRequest instance,
) => <String, dynamic>{'ticketId': instance.ticketId};
