// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_send200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatSend200ResponseCWProxy {
  ChatSend200Response message(String? message);

  ChatSend200Response data(OrderChatMessage data);

  ChatSend200Response pagination(PaginationResult? pagination);

  ChatSend200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatSend200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatSend200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatSend200Response call({
    String? message,
    OrderChatMessage data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatSend200Response.copyWith(...)` or call `instanceOfChatSend200Response.copyWith.fieldName(value)` for a single field.
class _$ChatSend200ResponseCWProxyImpl implements _$ChatSend200ResponseCWProxy {
  const _$ChatSend200ResponseCWProxyImpl(this._value);

  final ChatSend200Response _value;

  @override
  ChatSend200Response message(String? message) => call(message: message);

  @override
  ChatSend200Response data(OrderChatMessage data) => call(data: data);

  @override
  ChatSend200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ChatSend200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatSend200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatSend200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatSend200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ChatSend200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderChatMessage,
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

extension $ChatSend200ResponseCopyWith on ChatSend200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatSend200Response.copyWith(...)` or `instanceOfChatSend200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatSend200ResponseCWProxy get copyWith =>
      _$ChatSend200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSend200Response _$ChatSend200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ChatSend200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = ChatSend200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => OrderChatMessage.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ChatSend200ResponseToJson(
  ChatSend200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
