// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_review200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetReview200ResponseCWProxy {
  DriverGetReview200Response message(String message);

  DriverGetReview200Response data(DriverGetReview200ResponseData data);

  DriverGetReview200Response pagination(PaginationResult? pagination);

  DriverGetReview200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetReview200Response call({
    String message,
    DriverGetReview200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetReview200Response.copyWith(...)` or call `instanceOfDriverGetReview200Response.copyWith.fieldName(value)` for a single field.
class _$DriverGetReview200ResponseCWProxyImpl
    implements _$DriverGetReview200ResponseCWProxy {
  const _$DriverGetReview200ResponseCWProxyImpl(this._value);

  final DriverGetReview200Response _value;

  @override
  DriverGetReview200Response message(String message) => call(message: message);

  @override
  DriverGetReview200Response data(DriverGetReview200ResponseData data) =>
      call(data: data);

  @override
  DriverGetReview200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverGetReview200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetReview200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetReview200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetReview200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGetReview200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverGetReview200ResponseData,
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

extension $DriverGetReview200ResponseCopyWith on DriverGetReview200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetReview200Response.copyWith(...)` or `instanceOfDriverGetReview200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetReview200ResponseCWProxy get copyWith =>
      _$DriverGetReview200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetReview200Response _$DriverGetReview200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGetReview200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGetReview200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => DriverGetReview200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverGetReview200ResponseToJson(
  DriverGetReview200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
