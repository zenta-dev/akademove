// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerConfigurationCWProxy {
  BannerConfiguration title(String title);

  BannerConfiguration description(String description);

  BannerConfiguration imageUrl(String imageUrl);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerConfiguration call({String title, String description, String imageUrl});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBannerConfiguration.copyWith(...)` or call `instanceOfBannerConfiguration.copyWith.fieldName(value)` for a single field.
class _$BannerConfigurationCWProxyImpl implements _$BannerConfigurationCWProxy {
  const _$BannerConfigurationCWProxyImpl(this._value);

  final BannerConfiguration _value;

  @override
  BannerConfiguration title(String title) => call(title: title);

  @override
  BannerConfiguration description(String description) =>
      call(description: description);

  @override
  BannerConfiguration imageUrl(String imageUrl) => call(imageUrl: imageUrl);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BannerConfiguration(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BannerConfiguration(...).copyWith(id: 12, name: "My name")
  /// ```
  BannerConfiguration call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
  }) {
    return BannerConfiguration(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder() || imageUrl == null
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
    );
  }
}

extension $BannerConfigurationCopyWith on BannerConfiguration {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBannerConfiguration.copyWith(...)` or `instanceOfBannerConfiguration.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerConfigurationCWProxy get copyWith =>
      _$BannerConfigurationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerConfiguration _$BannerConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BannerConfiguration', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['title', 'description', 'imageUrl'],
      );
      final val = BannerConfiguration(
        title: $checkedConvert('title', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$BannerConfigurationToJson(
  BannerConfiguration instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
};
