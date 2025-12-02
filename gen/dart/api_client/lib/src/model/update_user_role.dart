//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user_role.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_user_role.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateUserRole {
  /// Returns a new [UpdateUserRole] instance.
  const UpdateUserRole({required this.role});

  @JsonKey(name: r'role', required: true, includeIfNull: false)
  final UserRole role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UpdateUserRole && other.role == role;

  @override
  int get hashCode => role.hashCode;

  factory UpdateUserRole.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRoleFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRoleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
