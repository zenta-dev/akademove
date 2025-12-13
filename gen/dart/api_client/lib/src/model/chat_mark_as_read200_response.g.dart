// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_mark_as_read200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ChatMarkAsRead200ResponseCWProxy {
  ChatMarkAsRead200Response message(String message);

  ChatMarkAsRead200Response data(OrderChatReadStatus data);

  ChatMarkAsRead200Response pagination(PaginationResult? pagination);

  ChatMarkAsRead200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatMarkAsRead200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatMarkAsRead200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatMarkAsRead200Response call({
    String message,
    OrderChatReadStatus data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfChatMarkAsRead200Response.copyWith(...)` or call `instanceOfChatMarkAsRead200Response.copyWith.fieldName(value)` for a single field.
class _$ChatMarkAsRead200ResponseCWProxyImpl
    implements _$ChatMarkAsRead200ResponseCWProxy {
  const _$ChatMarkAsRead200ResponseCWProxyImpl(this._value);

  final ChatMarkAsRead200Response _value;

  @override
  ChatMarkAsRead200Response message(String message) => call(message: message);

  @override
  ChatMarkAsRead200Response data(OrderChatReadStatus data) => call(data: data);

  @override
  ChatMarkAsRead200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ChatMarkAsRead200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ChatMarkAsRead200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ChatMarkAsRead200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ChatMarkAsRead200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ChatMarkAsRead200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as OrderChatReadStatus,
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

extension $ChatMarkAsRead200ResponseCopyWith on ChatMarkAsRead200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfChatMarkAsRead200Response.copyWith(...)` or `instanceOfChatMarkAsRead200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChatMarkAsRead200ResponseCWProxy get copyWith =>
      _$ChatMarkAsRead200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMarkAsRead200Response _$ChatMarkAsRead200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ChatMarkAsRead200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ChatMarkAsRead200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => OrderChatReadStatus.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ChatMarkAsRead200ResponseToJson(
  ChatMarkAsRead200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
