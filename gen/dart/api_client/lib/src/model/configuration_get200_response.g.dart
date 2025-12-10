// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_get200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationGet200ResponseCWProxy {
  ConfigurationGet200Response message(String message);

  ConfigurationGet200Response data(Configuration data);

  ConfigurationGet200Response pagination(PaginationResult? pagination);

  ConfigurationGet200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationGet200Response call({
    String message,
    Configuration data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfigurationGet200Response.copyWith(...)` or call `instanceOfConfigurationGet200Response.copyWith.fieldName(value)` for a single field.
class _$ConfigurationGet200ResponseCWProxyImpl
    implements _$ConfigurationGet200ResponseCWProxy {
  const _$ConfigurationGet200ResponseCWProxyImpl(this._value);

  final ConfigurationGet200Response _value;

  @override
  ConfigurationGet200Response message(String message) => call(message: message);

  @override
  ConfigurationGet200Response data(Configuration data) => call(data: data);

  @override
  ConfigurationGet200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ConfigurationGet200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationGet200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationGet200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationGet200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationGet200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Configuration,
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

extension $ConfigurationGet200ResponseCopyWith on ConfigurationGet200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfigurationGet200Response.copyWith(...)` or `instanceOfConfigurationGet200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationGet200ResponseCWProxy get copyWith =>
      _$ConfigurationGet200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationGet200Response _$ConfigurationGet200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationGet200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ConfigurationGet200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Configuration.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ConfigurationGet200ResponseToJson(
  ConfigurationGet200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
