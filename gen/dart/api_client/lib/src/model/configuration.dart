//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Configuration {
  /// Returns a new [Configuration] instance.
  Configuration({
    required this.key,

    required this.name,

    this.value,

    this.description,

    required this.updatedById,

    required this.updatedAt,
  });

  @JsonKey(name: r'key', required: true, includeIfNull: false)
  final String key;

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final Object? value;

  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;

  @JsonKey(name: r'updatedById', required: true, includeIfNull: false)
  final String updatedById;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Configuration &&
          other.key == key &&
          other.name == name &&
          other.value == value &&
          other.description == description &&
          other.updatedById == updatedById &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      key.hashCode +
      name.hashCode +
      (value == null ? 0 : value.hashCode) +
      description.hashCode +
      updatedById.hashCode +
      updatedAt.hashCode;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
