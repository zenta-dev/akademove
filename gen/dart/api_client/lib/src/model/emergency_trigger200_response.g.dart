// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_trigger200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyTrigger200ResponseCWProxy {
  EmergencyTrigger200Response message(String message);

  EmergencyTrigger200Response data(Emergency data);

  EmergencyTrigger200Response pagination(PaginationResult? pagination);

  EmergencyTrigger200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyTrigger200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyTrigger200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyTrigger200Response call({
    String message,
    Emergency data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyTrigger200Response.copyWith(...)` or call `instanceOfEmergencyTrigger200Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyTrigger200ResponseCWProxyImpl
    implements _$EmergencyTrigger200ResponseCWProxy {
  const _$EmergencyTrigger200ResponseCWProxyImpl(this._value);

  final EmergencyTrigger200Response _value;

  @override
  EmergencyTrigger200Response message(String message) => call(message: message);

  @override
  EmergencyTrigger200Response data(Emergency data) => call(data: data);

  @override
  EmergencyTrigger200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  EmergencyTrigger200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyTrigger200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyTrigger200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyTrigger200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyTrigger200Response(
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

extension $EmergencyTrigger200ResponseCopyWith on EmergencyTrigger200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyTrigger200Response.copyWith(...)` or `instanceOfEmergencyTrigger200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyTrigger200ResponseCWProxy get copyWith =>
      _$EmergencyTrigger200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyTrigger200Response _$EmergencyTrigger200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyTrigger200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = EmergencyTrigger200Response(
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

Map<String, dynamic> _$EmergencyTrigger200ResponseToJson(
  EmergencyTrigger200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
