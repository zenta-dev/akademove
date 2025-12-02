// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatList200ResponseCWProxy {
  ChatList200Response message(String message);

  ChatList200Response data(ChatList200ResponseData data);

  ChatList200Response pagination(PaginationResult? pagination);

  ChatList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatList200Response call({
    String message,
    ChatList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatList200Response.copyWith(...)` or call `instanceOfChatList200Response.copyWith.fieldName(value)` for a single field.
class _$ChatList200ResponseCWProxyImpl implements _$ChatList200ResponseCWProxy {
  const _$ChatList200ResponseCWProxyImpl(this._value);

  final ChatList200Response _value;

  @override
  ChatList200Response message(String message) => call(message: message);

  @override
  ChatList200Response data(ChatList200ResponseData data) => call(data: data);

  @override
  ChatList200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  ChatList200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ChatList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as ChatList200ResponseData,
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

extension $ChatList200ResponseCopyWith on ChatList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatList200Response.copyWith(...)` or `instanceOfChatList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatList200ResponseCWProxy get copyWith => _$ChatList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatList200Response _$ChatList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatList200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = ChatList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert('data', (v) => ChatList200ResponseData.fromJson(v as Map<String, dynamic>)),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ChatList200ResponseToJson(ChatList200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
