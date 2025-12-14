// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyGet200ResponseCWProxy {
  EmergencyGet200Response message(String message);

  EmergencyGet200Response data(Emergency data);

  EmergencyGet200Response pagination(PaginationResult? pagination);

  EmergencyGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyGet200Response call({
    String message,
    Emergency data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyGet200Response.copyWith(...)` or call `instanceOfEmergencyGet200Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyGet200ResponseCWProxyImpl
    implements _$EmergencyGet200ResponseCWProxy {
  const _$EmergencyGet200ResponseCWProxyImpl(this._value);

  final EmergencyGet200Response _value;

  @override
  EmergencyGet200Response message(String message) => call(message: message);

  @override
  EmergencyGet200Response data(Emergency data) => call(data: data);

  @override
  EmergencyGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  EmergencyGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Emergency,
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

extension $EmergencyGet200ResponseCopyWith on EmergencyGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyGet200Response.copyWith(...)` or `instanceOfEmergencyGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyGet200ResponseCWProxy get copyWith =>
      _$EmergencyGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyGet200Response _$EmergencyGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = EmergencyGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Emergency.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EmergencyGet200ResponseToJson(
  EmergencyGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
