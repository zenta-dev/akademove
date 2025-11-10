//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/configuration.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'configuration_list200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfigurationList200Response {
  /// Returns a new [ConfigurationList200Response] instance.
  const ConfigurationList200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final List<Configuration> data;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigurationList200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory ConfigurationList200Response.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationList200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationList200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
