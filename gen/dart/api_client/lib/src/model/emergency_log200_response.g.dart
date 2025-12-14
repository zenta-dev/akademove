// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_log200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyLog200ResponseCWProxy {
  EmergencyLog200Response message(String message);

  EmergencyLog200Response data(EmergencyLog200ResponseData data);

  EmergencyLog200Response pagination(PaginationResult? pagination);

  EmergencyLog200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLog200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLog200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLog200Response call({
    String message,
    EmergencyLog200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyLog200Response.copyWith(...)` or call `instanceOfEmergencyLog200Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyLog200ResponseCWProxyImpl
    implements _$EmergencyLog200ResponseCWProxy {
  const _$EmergencyLog200ResponseCWProxyImpl(this._value);

  final EmergencyLog200Response _value;

  @override
  EmergencyLog200Response message(String message) => call(message: message);

  @override
  EmergencyLog200Response data(EmergencyLog200ResponseData data) =>
      call(data: data);

  @override
  EmergencyLog200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  EmergencyLog200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyLog200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyLog200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyLog200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyLog200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as EmergencyLog200ResponseData,
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

extension $EmergencyLog200ResponseCopyWith on EmergencyLog200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyLog200Response.copyWith(...)` or `instanceOfEmergencyLog200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyLog200ResponseCWProxy get copyWith =>
      _$EmergencyLog200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyLog200Response _$EmergencyLog200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyLog200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = EmergencyLog200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => EmergencyLog200ResponseData.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EmergencyLog200ResponseToJson(
  EmergencyLog200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
