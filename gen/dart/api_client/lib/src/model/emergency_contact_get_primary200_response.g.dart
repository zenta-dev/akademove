// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_get_primary200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyContactGetPrimary200ResponseCWProxy {
  EmergencyContactGetPrimary200Response message(String message);

  EmergencyContactGetPrimary200Response data(EmergencyContact? data);

  EmergencyContactGetPrimary200Response pagination(
    PaginationResult? pagination,
  );

  EmergencyContactGetPrimary200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactGetPrimary200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactGetPrimary200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactGetPrimary200Response call({
    String message,
    EmergencyContact? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyContactGetPrimary200Response.copyWith(...)` or call `instanceOfEmergencyContactGetPrimary200Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyContactGetPrimary200ResponseCWProxyImpl
    implements _$EmergencyContactGetPrimary200ResponseCWProxy {
  const _$EmergencyContactGetPrimary200ResponseCWProxyImpl(this._value);

  final EmergencyContactGetPrimary200Response _value;

  @override
  EmergencyContactGetPrimary200Response message(String message) =>
      call(message: message);

  @override
  EmergencyContactGetPrimary200Response data(EmergencyContact? data) =>
      call(data: data);

  @override
  EmergencyContactGetPrimary200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  EmergencyContactGetPrimary200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactGetPrimary200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactGetPrimary200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactGetPrimary200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyContactGetPrimary200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as EmergencyContact?,
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

extension $EmergencyContactGetPrimary200ResponseCopyWith
    on EmergencyContactGetPrimary200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyContactGetPrimary200Response.copyWith(...)` or `instanceOfEmergencyContactGetPrimary200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyContactGetPrimary200ResponseCWProxy get copyWith =>
      _$EmergencyContactGetPrimary200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContactGetPrimary200Response
_$EmergencyContactGetPrimary200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmergencyContactGetPrimary200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = EmergencyContactGetPrimary200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => v == null
              ? null
              : EmergencyContact.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EmergencyContactGetPrimary200ResponseToJson(
  EmergencyContactGetPrimary200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
