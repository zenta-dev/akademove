// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_delete200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageDelete200ResponseCWProxy {
  QuickMessageDelete200Response message(String message);

  QuickMessageDelete200Response data(QuickMessageDelete200ResponseData data);

  QuickMessageDelete200Response pagination(PaginationResult? pagination);

  QuickMessageDelete200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageDelete200Response call({
    String message,
    QuickMessageDelete200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageDelete200Response.copyWith(...)` or call `instanceOfQuickMessageDelete200Response.copyWith.fieldName(value)` for a single field.
class _$QuickMessageDelete200ResponseCWProxyImpl
    implements _$QuickMessageDelete200ResponseCWProxy {
  const _$QuickMessageDelete200ResponseCWProxyImpl(this._value);

  final QuickMessageDelete200Response _value;

  @override
  QuickMessageDelete200Response message(String message) =>
      call(message: message);

  @override
  QuickMessageDelete200Response data(QuickMessageDelete200ResponseData data) =>
      call(data: data);

  @override
  QuickMessageDelete200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  QuickMessageDelete200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageDelete200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageDelete200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as QuickMessageDelete200ResponseData,
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

extension $QuickMessageDelete200ResponseCopyWith
    on QuickMessageDelete200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageDelete200Response.copyWith(...)` or `instanceOfQuickMessageDelete200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageDelete200ResponseCWProxy get copyWith =>
      _$QuickMessageDelete200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageDelete200Response _$QuickMessageDelete200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageDelete200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = QuickMessageDelete200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) =>
          QuickMessageDelete200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$QuickMessageDelete200ResponseToJson(
  QuickMessageDelete200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
