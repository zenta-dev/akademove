//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/configuration_list200_response_data_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'configuration_get200_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfigurationGet200Response {
  /// Returns a new [ConfigurationGet200Response] instance.
  const ConfigurationGet200Response({
    required this.message,
    required this.data,
    this.totalPages,
  });

  @JsonKey(name: r'message', required: true, includeIfNull: false)
  final String message;

  @JsonKey(name: r'data', required: true, includeIfNull: false)
  final ConfigurationList200ResponseDataInner data;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(name: r'totalPages', required: false, includeIfNull: false)
  final int? totalPages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigurationGet200Response &&
          other.message == message &&
          other.data == data &&
          other.totalPages == totalPages;

  @override
  int get hashCode => message.hashCode + data.hashCode + totalPages.hashCode;

  factory ConfigurationGet200Response.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationGet200ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationGet200ResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
