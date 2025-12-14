// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_create201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyContactCreate201ResponseCWProxy {
  EmergencyContactCreate201Response message(String message);

  EmergencyContactCreate201Response data(EmergencyContact data);

  EmergencyContactCreate201Response pagination(PaginationResult? pagination);

  EmergencyContactCreate201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactCreate201Response call({
    String message,
    EmergencyContact data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyContactCreate201Response.copyWith(...)` or call `instanceOfEmergencyContactCreate201Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyContactCreate201ResponseCWProxyImpl
    implements _$EmergencyContactCreate201ResponseCWProxy {
  const _$EmergencyContactCreate201ResponseCWProxyImpl(this._value);

  final EmergencyContactCreate201Response _value;

  @override
  EmergencyContactCreate201Response message(String message) =>
      call(message: message);

  @override
  EmergencyContactCreate201Response data(EmergencyContact data) =>
      call(data: data);

  @override
  EmergencyContactCreate201Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  EmergencyContactCreate201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyContactCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyContactCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyContactCreate201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyContactCreate201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as EmergencyContact,
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

extension $EmergencyContactCreate201ResponseCopyWith
    on EmergencyContactCreate201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyContactCreate201Response.copyWith(...)` or `instanceOfEmergencyContactCreate201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyContactCreate201ResponseCWProxy get copyWith =>
      _$EmergencyContactCreate201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContactCreate201Response _$EmergencyContactCreate201ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('EmergencyContactCreate201Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = EmergencyContactCreate201Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => EmergencyContact.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EmergencyContactCreate201ResponseToJson(
  EmergencyContactCreate201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
