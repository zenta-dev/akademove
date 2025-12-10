// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGet200ResponseCWProxy {
  DriverGet200Response message(String message);

  DriverGet200Response data(Driver data);

  DriverGet200Response pagination(PaginationResult? pagination);

  DriverGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGet200Response call({
    String message,
    Driver data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGet200Response.copyWith(...)` or call `instanceOfDriverGet200Response.copyWith.fieldName(value)` for a single field.
class _$DriverGet200ResponseCWProxyImpl
    implements _$DriverGet200ResponseCWProxy {
  const _$DriverGet200ResponseCWProxyImpl(this._value);

  final DriverGet200Response _value;

  @override
  DriverGet200Response message(String message) => call(message: message);

  @override
  DriverGet200Response data(Driver data) => call(data: data);

  @override
  DriverGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Driver,
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

extension $DriverGet200ResponseCopyWith on DriverGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGet200Response.copyWith(...)` or `instanceOfDriverGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGet200ResponseCWProxy get copyWith =>
      _$DriverGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGet200Response _$DriverGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Driver.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverGet200ResponseToJson(
  DriverGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
