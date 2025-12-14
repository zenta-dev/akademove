// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_get_unread_count200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatGetUnreadCount200ResponseCWProxy {
  SupportChatGetUnreadCount200Response message(String message);

  SupportChatGetUnreadCount200Response data(
    SupportChatGetUnreadCount200ResponseData data,
  );

  SupportChatGetUnreadCount200Response pagination(PaginationResult? pagination);

  SupportChatGetUnreadCount200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatGetUnreadCount200Response call({
    String message,
    SupportChatGetUnreadCount200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatGetUnreadCount200Response.copyWith(...)` or call `instanceOfSupportChatGetUnreadCount200Response.copyWith.fieldName(value)` for a single field.
class _$SupportChatGetUnreadCount200ResponseCWProxyImpl
    implements _$SupportChatGetUnreadCount200ResponseCWProxy {
  const _$SupportChatGetUnreadCount200ResponseCWProxyImpl(this._value);

  final SupportChatGetUnreadCount200Response _value;

  @override
  SupportChatGetUnreadCount200Response message(String message) =>
      call(message: message);

  @override
  SupportChatGetUnreadCount200Response data(
    SupportChatGetUnreadCount200ResponseData data,
  ) => call(data: data);

  @override
  SupportChatGetUnreadCount200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  SupportChatGetUnreadCount200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatGetUnreadCount200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatGetUnreadCount200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatGetUnreadCount200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return SupportChatGetUnreadCount200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SupportChatGetUnreadCount200ResponseData,
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

extension $SupportChatGetUnreadCount200ResponseCopyWith
    on SupportChatGetUnreadCount200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatGetUnreadCount200Response.copyWith(...)` or `instanceOfSupportChatGetUnreadCount200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatGetUnreadCount200ResponseCWProxy get copyWith =>
      _$SupportChatGetUnreadCount200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatGetUnreadCount200Response
_$SupportChatGetUnreadCount200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatGetUnreadCount200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = SupportChatGetUnreadCount200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => SupportChatGetUnreadCount200ResponseData.fromJson(
            v as Map<String, dynamic>,
          ),
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

Map<String, dynamic> _$SupportChatGetUnreadCount200ResponseToJson(
  SupportChatGetUnreadCount200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
