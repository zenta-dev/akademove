// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_get_unread_count200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatGetUnreadCount200ResponseCWProxy {
  ChatGetUnreadCount200Response message(String message);

  ChatGetUnreadCount200Response data(ChatUnreadCount data);

  ChatGetUnreadCount200Response pagination(PaginationResult? pagination);

  ChatGetUnreadCount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatGetUnreadCount200Response call({
    String message,
    ChatUnreadCount data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatGetUnreadCount200Response.copyWith(...)` or call `instanceOfChatGetUnreadCount200Response.copyWith.fieldName(value)` for a single field.
class _$ChatGetUnreadCount200ResponseCWProxyImpl
    implements _$ChatGetUnreadCount200ResponseCWProxy {
  const _$ChatGetUnreadCount200ResponseCWProxyImpl(this._value);

  final ChatGetUnreadCount200Response _value;

  @override
  ChatGetUnreadCount200Response message(String message) =>
      call(message: message);

  @override
  ChatGetUnreadCount200Response data(ChatUnreadCount data) => call(data: data);

  @override
  ChatGetUnreadCount200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ChatGetUnreadCount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatGetUnreadCount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ChatGetUnreadCount200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ChatUnreadCount,
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

extension $ChatGetUnreadCount200ResponseCopyWith
    on ChatGetUnreadCount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatGetUnreadCount200Response.copyWith(...)` or `instanceOfChatGetUnreadCount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatGetUnreadCount200ResponseCWProxy get copyWith =>
      _$ChatGetUnreadCount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatGetUnreadCount200Response _$ChatGetUnreadCount200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ChatGetUnreadCount200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ChatGetUnreadCount200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => ChatUnreadCount.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ChatGetUnreadCount200ResponseToJson(
  ChatGetUnreadCount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
