// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_mark_as_read200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatMarkAsRead200ResponseCWProxy {
  SupportChatMarkAsRead200Response message(String message);

  SupportChatMarkAsRead200Response data(
    SupportChatMarkAsRead200ResponseData data,
  );

  SupportChatMarkAsRead200Response pagination(PaginationResult? pagination);

  SupportChatMarkAsRead200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsRead200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsRead200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsRead200Response call({
    String message,
    SupportChatMarkAsRead200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatMarkAsRead200Response.copyWith(...)` or call `instanceOfSupportChatMarkAsRead200Response.copyWith.fieldName(value)` for a single field.
class _$SupportChatMarkAsRead200ResponseCWProxyImpl
    implements _$SupportChatMarkAsRead200ResponseCWProxy {
  const _$SupportChatMarkAsRead200ResponseCWProxyImpl(this._value);

  final SupportChatMarkAsRead200Response _value;

  @override
  SupportChatMarkAsRead200Response message(String message) =>
      call(message: message);

  @override
  SupportChatMarkAsRead200Response data(
    SupportChatMarkAsRead200ResponseData data,
  ) => call(data: data);

  @override
  SupportChatMarkAsRead200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  SupportChatMarkAsRead200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatMarkAsRead200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatMarkAsRead200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatMarkAsRead200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return SupportChatMarkAsRead200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SupportChatMarkAsRead200ResponseData,
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

extension $SupportChatMarkAsRead200ResponseCopyWith
    on SupportChatMarkAsRead200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatMarkAsRead200Response.copyWith(...)` or `instanceOfSupportChatMarkAsRead200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatMarkAsRead200ResponseCWProxy get copyWith =>
      _$SupportChatMarkAsRead200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatMarkAsRead200Response _$SupportChatMarkAsRead200ResponseFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('SupportChatMarkAsRead200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = SupportChatMarkAsRead200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => SupportChatMarkAsRead200ResponseData.fromJson(
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

Map<String, dynamic> _$SupportChatMarkAsRead200ResponseToJson(
  SupportChatMarkAsRead200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
