// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_send_message201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatSendMessage201ResponseCWProxy {
  SupportChatSendMessage201Response message(String message);

  SupportChatSendMessage201Response data(SupportChatMessage data);

  SupportChatSendMessage201Response pagination(PaginationResult? pagination);

  SupportChatSendMessage201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatSendMessage201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatSendMessage201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatSendMessage201Response call({
    String message,
    SupportChatMessage data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatSendMessage201Response.copyWith(...)` or call `instanceOfSupportChatSendMessage201Response.copyWith.fieldName(value)` for a single field.
class _$SupportChatSendMessage201ResponseCWProxyImpl
    implements _$SupportChatSendMessage201ResponseCWProxy {
  const _$SupportChatSendMessage201ResponseCWProxyImpl(this._value);

  final SupportChatSendMessage201Response _value;

  @override
  SupportChatSendMessage201Response message(String message) =>
      call(message: message);

  @override
  SupportChatSendMessage201Response data(SupportChatMessage data) =>
      call(data: data);

  @override
  SupportChatSendMessage201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  SupportChatSendMessage201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatSendMessage201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatSendMessage201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatSendMessage201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return SupportChatSendMessage201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SupportChatMessage,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $SupportChatSendMessage201ResponseCopyWith
    on SupportChatSendMessage201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatSendMessage201Response.copyWith(...)` or `instanceOfSupportChatSendMessage201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatSendMessage201ResponseCWProxy get copyWith =>
      _$SupportChatSendMessage201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatSendMessage201Response _$SupportChatSendMessage201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('SupportChatSendMessage201Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = SupportChatSendMessage201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => SupportChatMessage.fromJson(v as Map<String, dynamic>),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$SupportChatSendMessage201ResponseToJson(
  SupportChatSendMessage201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
