//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_configuration.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertConfiguration {
  /// Returns a new [InsertConfiguration] instance.
  const InsertConfiguration({
    required this.name,
     this.value,
     this.description,
  });

  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;
  
  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final Object? value;
  
  @JsonKey(name: r'description', required: false, includeIfNull: false)
  final String? description;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is InsertConfiguration &&
    other.name == name &&
    other.value == value &&
    other.description == description;

  @override
  int get hashCode =>
      name.hashCode +
      (value == null ? 0 : value.hashCode) +
      description.hashCode;

  factory InsertConfiguration.fromJson(Map<String, dynamic> json) => _$InsertConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$InsertConfigurationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

