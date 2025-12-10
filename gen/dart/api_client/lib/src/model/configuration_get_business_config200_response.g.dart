// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_get_business_config200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigurationGetBusinessConfig200ResponseCWProxy {
  ConfigurationGetBusinessConfig200Response message(String message);

  ConfigurationGetBusinessConfig200Response data(BusinessConfiguration data);

  ConfigurationGetBusinessConfig200Response pagination(
    PaginationResult? pagination,
  );

  ConfigurationGetBusinessConfig200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationGetBusinessConfig200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationGetBusinessConfig200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationGetBusinessConfig200Response call({
    String message,
    BusinessConfiguration data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfigurationGetBusinessConfig200Response.copyWith(...)` or call `instanceOfConfigurationGetBusinessConfig200Response.copyWith.fieldName(value)` for a single field.
class _$ConfigurationGetBusinessConfig200ResponseCWProxyImpl
    implements _$ConfigurationGetBusinessConfig200ResponseCWProxy {
  const _$ConfigurationGetBusinessConfig200ResponseCWProxyImpl(this._value);

  final ConfigurationGetBusinessConfig200Response _value;

  @override
  ConfigurationGetBusinessConfig200Response message(String message) =>
      call(message: message);

  @override
  ConfigurationGetBusinessConfig200Response data(BusinessConfiguration data) =>
      call(data: data);

  @override
  ConfigurationGetBusinessConfig200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  ConfigurationGetBusinessConfig200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigurationGetBusinessConfig200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigurationGetBusinessConfig200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigurationGetBusinessConfig200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ConfigurationGetBusinessConfig200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as BusinessConfiguration,
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

extension $ConfigurationGetBusinessConfig200ResponseCopyWith
    on ConfigurationGetBusinessConfig200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfigurationGetBusinessConfig200Response.copyWith(...)` or `instanceOfConfigurationGetBusinessConfig200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigurationGetBusinessConfig200ResponseCWProxy get copyWith =>
      _$ConfigurationGetBusinessConfig200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigurationGetBusinessConfig200Response
_$ConfigurationGetBusinessConfig200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ConfigurationGetBusinessConfig200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ConfigurationGetBusinessConfig200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => BusinessConfiguration.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$ConfigurationGetBusinessConfig200ResponseToJson(
  ConfigurationGetBusinessConfig200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
