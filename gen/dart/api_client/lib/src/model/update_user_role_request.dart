//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_user_role_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateUserRoleRequest {
  /// Returns a new [UpdateUserRoleRequest] instance.
  UpdateUserRoleRequest({required this.role});

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UpdateUserRoleRequestRoleEnum role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateUserRoleRequest && other.role == role;

  @override
  int get hashCode => role.hashCode;

  factory UpdateUserRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRoleRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UpdateUserRoleRequestRoleEnum {
  @JsonValue(r'admin')
  admin(r'admin'),
  @JsonValue(r'operator')
  operator_(r'operator'),
  @JsonValue(r'merchant')
  merchant(r'merchant'),
  @JsonValue(r'driver')
  driver(r'driver'),
  @JsonValue(r'user')
  user(r'user');

  const UpdateUserRoleRequestRoleEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
