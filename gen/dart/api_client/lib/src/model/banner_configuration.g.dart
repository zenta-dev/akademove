// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_configuration.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerConfigurationCWProxy {
  BannerConfiguration title(String title);

  BannerConfiguration description(String description);

  BannerConfiguration imageUrl(String imageUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BannerConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BannerConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  BannerConfiguration call({String title, String description, String imageUrl});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBannerConfiguration.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBannerConfiguration.copyWith.fieldName(...)`
class _$BannerConfigurationCWProxyImpl implements _$BannerConfigurationCWProxy {
  const _$BannerConfigurationCWProxyImpl(this._value);

  final BannerConfiguration _value;

  @override
  BannerConfiguration title(String title) => this(title: title);

  @override
  BannerConfiguration description(String description) =>
      this(description: description);

  @override
  BannerConfiguration imageUrl(String imageUrl) => this(imageUrl: imageUrl);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BannerConfiguration(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BannerConfiguration(...).copyWith(id: 12, name: "My name")
  /// ````
  BannerConfiguration call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
  }) {
    return BannerConfiguration(
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String,
    );
  }
}

extension $BannerConfigurationCopyWith on BannerConfiguration {
  /// Returns a callable class that can be used as follows: `instanceOfBannerConfiguration.copyWith(...)` or like so:`instanceOfBannerConfiguration.copyWith.fieldName(...)`.
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
