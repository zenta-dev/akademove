//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'unban_user_schema_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UnbanUserSchemaRequest {
  /// Returns a new [UnbanUserSchemaRequest] instance.
  UnbanUserSchemaRequest({required this.id});

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnbanUserSchemaRequest && other.id == id;

  @override
  int get hashCode => id.hashCode;

  factory UnbanUserSchemaRequest.fromJson(Map<String, dynamic> json) =>
      _$UnbanUserSchemaRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UnbanUserSchemaRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
