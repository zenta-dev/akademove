//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'activate_driver.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ActivateDriver {
  /// Returns a new [ActivateDriver] instance.
  const ActivateDriver({
    required this.id,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is ActivateDriver &&
    other.id == id;

  @override
  int get hashCode =>
      id.hashCode;

  factory ActivateDriver.fromJson(Map<String, dynamic> json) => _$ActivateDriverFromJson(json);

  Map<String, dynamic> toJson() => _$ActivateDriverToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

