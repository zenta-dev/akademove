// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationList200ResponseCWProxy {
  ConfigurationList200Response message(String message);

  ConfigurationList200Response data(List<Configuration> data);

  ConfigurationList200Response pagination(PaginationResult? pagination);

  ConfigurationList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationList200Response call({
    String message,
    List<Configuration> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfigurationList200Response.copyWith(...)` or call `instanceOfConfigurationList200Response.copyWith.fieldName(value)` for a single field.
class _$ConfigurationList200ResponseCWProxyImpl implements _$ConfigurationList200ResponseCWProxy {
  const _$ConfigurationList200ResponseCWProxyImpl(this._value);

  final ConfigurationList200Response _value;

  @override
  ConfigurationList200Response message(String message) => call(message: message);

  @override
  ConfigurationList200Response data(List<Configuration> data) => call(data: data);

  @override
  ConfigurationList200Response pagination(PaginationResult? pagination) => call(pagination: pagination);

  @override
  ConfigurationList200Response totalPages(int? totalPages) => call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Configuration>,
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

extension $ConfigurationList200ResponseCopyWith on ConfigurationList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfigurationList200Response.copyWith(...)` or `instanceOfConfigurationList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationList200ResponseCWProxy get copyWith => _$ConfigurationList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationList200Response _$ConfigurationList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConfigurationList200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = ConfigurationList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>).map((e) => Configuration.fromJson(e as Map<String, dynamic>)).toList(),
        ),
        pagination: $checkedConvert(
          'pagination',
          (v) => v == null ? null : PaginationResult.fromJson(v as Map<String, dynamic>),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ConfigurationList200ResponseToJson(ConfigurationList200Response instance) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
