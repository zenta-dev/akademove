// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_list_by_order200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyListByOrder200ResponseCWProxy {
  EmergencyListByOrder200Response message(String message);

  EmergencyListByOrder200Response data(List<Emergency> data);

  EmergencyListByOrder200Response pagination(PaginationResult? pagination);

  EmergencyListByOrder200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyListByOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyListByOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyListByOrder200Response call({
    String message,
    List<Emergency> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfEmergencyListByOrder200Response.copyWith(...)` or call `instanceOfEmergencyListByOrder200Response.copyWith.fieldName(value)` for a single field.
class _$EmergencyListByOrder200ResponseCWProxyImpl implements _$EmergencyListByOrder200ResponseCWProxy {
  const _$EmergencyListByOrder200ResponseCWProxyImpl(this._value);

  final EmergencyListByOrder200Response _value;

  @override
  EmergencyListByOrder200Response message(String message) => call(message: message);

  @override
  EmergencyListByOrder200Response data(List<Emergency> data) => call(data: data);

  @override
  EmergencyListByOrder200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  EmergencyListByOrder200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `EmergencyListByOrder200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// EmergencyListByOrder200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  EmergencyListByOrder200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return EmergencyListByOrder200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Emergency>,
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

extension $EmergencyListByOrder200ResponseCopyWith on EmergencyListByOrder200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfEmergencyListByOrder200Response.copyWith(...)` or `instanceOfEmergencyListByOrder200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyListByOrder200ResponseCWProxy get copyWith => _$EmergencyListByOrder200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyListByOrder200Response _$EmergencyListByOrder200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmergencyListByOrder200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = EmergencyListByOrder200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>).map((e) => Emergency.fromJson(e as Map<String, dynamic>)).toList(),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$EmergencyListByOrder200ResponseToJson(EmergencyListByOrder200Response instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
      'pagination': ?instance.pagination?.toJson(),
      'totalPages': ?instance.totalPages,
    };
