// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_get_mine200_response_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverGetMine200ResponseBodyCWProxy {
  DriverGetMine200ResponseBody message(String message);

  DriverGetMine200ResponseBody data(Driver data);

  DriverGetMine200ResponseBody pagination(PaginationResult? pagination);

  DriverGetMine200ResponseBody totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetMine200ResponseBody(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetMine200ResponseBody call({
    String message,
    Driver data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverGetMine200ResponseBody.copyWith(...)` or call `instanceOfDriverGetMine200ResponseBody.copyWith.fieldName(value)` for a single field.
class _$DriverGetMine200ResponseBodyCWProxyImpl
    implements _$DriverGetMine200ResponseBodyCWProxy {
  const _$DriverGetMine200ResponseBodyCWProxyImpl(this._value);

  final DriverGetMine200ResponseBody _value;

  @override
  DriverGetMine200ResponseBody message(String message) =>
      call(message: message);

  @override
  DriverGetMine200ResponseBody data(Driver data) => call(data: data);

  @override
  DriverGetMine200ResponseBody pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverGetMine200ResponseBody totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverGetMine200ResponseBody(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverGetMine200ResponseBody(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverGetMine200ResponseBody call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverGetMine200ResponseBody(
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

extension $DriverGetMine200ResponseBodyCopyWith
    on DriverGetMine200ResponseBody {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverGetMine200ResponseBody.copyWith(...)` or `instanceOfDriverGetMine200ResponseBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverGetMine200ResponseBodyCWProxy get copyWith =>
      _$DriverGetMine200ResponseBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverGetMine200ResponseBody _$DriverGetMine200ResponseBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverGetMine200ResponseBody', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverGetMine200ResponseBody(
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

Map<String, dynamic> _$DriverGetMine200ResponseBodyToJson(
  DriverGetMine200ResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
