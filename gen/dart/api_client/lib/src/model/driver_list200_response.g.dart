// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverList200ResponseCWProxy {
  DriverList200Response message(String? message);

  DriverList200Response data(List<Driver> data);

  DriverList200Response pagination(PaginationResult? pagination);

  DriverList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverList200Response call({
    String? message,
    List<Driver> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverList200Response.copyWith(...)` or call `instanceOfDriverList200Response.copyWith.fieldName(value)` for a single field.
class _$DriverList200ResponseCWProxyImpl
    implements _$DriverList200ResponseCWProxy {
  const _$DriverList200ResponseCWProxyImpl(this._value);

  final DriverList200Response _value;

  @override
  DriverList200Response message(String? message) => call(message: message);

  @override
  DriverList200Response data(List<Driver> data) => call(data: data);

  @override
  DriverList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Driver>,
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

extension $DriverList200ResponseCopyWith on DriverList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverList200Response.copyWith(...)` or `instanceOfDriverList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverList200ResponseCWProxy get copyWith =>
      _$DriverList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverList200Response _$DriverList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Driver.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$DriverList200ResponseToJson(
  DriverList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
