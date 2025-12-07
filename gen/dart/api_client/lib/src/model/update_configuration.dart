//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateConfiguration {
  /// Returns a new [UpdateConfiguration] instance.
  const UpdateConfiguration({
     this.name,
     this.value,
     this.description,
  });
  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;
  
  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final Object? value;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateConfiguration &&
    other.name == name &&
    other.value == value &&
    other.description == description;

  @override
  int get hashCode =>
      name.hashCode +
      (value == null ? 0 : value.hashCode) +
      description.hashCode;

  factory UpdateConfiguration.fromJson(Map<String, dynamic> json) => _$UpdateConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

