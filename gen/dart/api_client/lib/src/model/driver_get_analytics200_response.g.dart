// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_analytics200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetAnalytics200ResponseCWProxy {
  DriverGetAnalytics200Response message(String? message);

  DriverGetAnalytics200Response data(DriverGetAnalytics200ResponseData data);

  DriverGetAnalytics200Response pagination(PaginationResult? pagination);

  DriverGetAnalytics200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200Response call({
    String? message,
    DriverGetAnalytics200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetAnalytics200Response.copyWith(...)` or call `instanceOfDriverGetAnalytics200Response.copyWith.fieldName(value)` for a single field.
class _$DriverGetAnalytics200ResponseCWProxyImpl
    implements _$DriverGetAnalytics200ResponseCWProxy {
  const _$DriverGetAnalytics200ResponseCWProxyImpl(this._value);

  final DriverGetAnalytics200Response _value;

  @override
  DriverGetAnalytics200Response message(String? message) =>
      call(message: message);

  @override
  DriverGetAnalytics200Response data(DriverGetAnalytics200ResponseData data) =>
      call(data: data);

  @override
  DriverGetAnalytics200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverGetAnalytics200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetAnalytics200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetAnalytics200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetAnalytics200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGetAnalytics200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverGetAnalytics200ResponseData,
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

extension $DriverGetAnalytics200ResponseCopyWith
    on DriverGetAnalytics200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetAnalytics200Response.copyWith(...)` or `instanceOfDriverGetAnalytics200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetAnalytics200ResponseCWProxy get copyWith =>
      _$DriverGetAnalytics200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetAnalytics200Response _$DriverGetAnalytics200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGetAnalytics200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGetAnalytics200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) =>
          DriverGetAnalytics200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverGetAnalytics200ResponseToJson(
  DriverGetAnalytics200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
