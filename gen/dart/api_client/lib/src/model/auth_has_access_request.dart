//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/role_access.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_has_access_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthHasAccessRequest {
  /// Returns a new [AuthHasAccessRequest] instance.
  const AuthHasAccessRequest({required this.roles});
  @JsonKey(name: r'roles', required: true, includeIfNull: false)
  final List<RoleAccess> roles;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthHasAccessRequest && other.roles == roles;

  @override
  int get hashCode => roles.hashCode;

  factory AuthHasAccessRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthHasAccessRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthHasAccessRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
