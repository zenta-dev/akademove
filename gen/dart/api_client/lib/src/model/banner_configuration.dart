//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'banner_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BannerConfiguration {
  /// Returns a new [BannerConfiguration] instance.
  const BannerConfiguration({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  @JsonKey(name: r'title', required: true, includeIfNull: true)
  final String? title;
  
  @JsonKey(name: r'description', required: true, includeIfNull: true)
  final String? description;
  
  @JsonKey(name: r'imageUrl', required: true, includeIfNull: true)
  final String? imageUrl;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is BannerConfiguration &&
    other.title == title &&
    other.description == description &&
    other.imageUrl == imageUrl;

  @override
  int get hashCode =>
      (title == null ? 0 : title.hashCode) +
      (description == null ? 0 : description.hashCode) +
      (imageUrl == null ? 0 : imageUrl.hashCode);

  factory BannerConfiguration.fromJson(Map<String, dynamic> json) => _$BannerConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$BannerConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

