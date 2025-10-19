//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'configuration_update_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfigurationUpdateRequest {
  /// Returns a new [ConfigurationUpdateRequest] instance.
  ConfigurationUpdateRequest({

     this.name,

     this.value,

     this.description,
  });

  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final Object? value;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConfigurationUpdateRequest &&
      other.name == name &&
      other.value == value &&
      other.description == description;

    @override
    int get hashCode =>
        name.hashCode +
        (value == null ? 0 : value.hashCode) +
        description.hashCode;

  factory ConfigurationUpdateRequest.fromJson(Map<String, dynamic> json) => _$ConfigurationUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationUpdateRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

