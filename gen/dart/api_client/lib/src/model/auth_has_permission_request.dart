//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/statements.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_has_permission_request.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class AuthHasPermissionRequest {
  /// Returns a new [AuthHasPermissionRequest] instance.
  const AuthHasPermissionRequest({required this.permissions});

  @JsonKey(name: r'permissions', required: true, includeIfNull: false)
  final Statements permissions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AuthHasPermissionRequest && other.permissions == permissions;

  @override
  int get hashCode => permissions.hashCode;

  factory AuthHasPermissionRequest.fromJson(Map<String, dynamic> json) => _$AuthHasPermissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthHasPermissionRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
