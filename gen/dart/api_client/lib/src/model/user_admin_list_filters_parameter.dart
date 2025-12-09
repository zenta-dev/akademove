//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_admin_list_filters_parameter.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserAdminListFiltersParameter {
  /// Returns a new [UserAdminListFiltersParameter] instance.
  const UserAdminListFiltersParameter({
    this.roles,
    this.genders,
    this.emailVerified,
    this.banned,
    this.startDate,
    this.endDate,
  });
  @JsonKey(name: r'roles', required: false, includeIfNull: false)
  final List<UserAdminListFiltersParameterRolesEnum>? roles;

  @JsonKey(name: r'genders', required: false, includeIfNull: false)
  final List<UserAdminListFiltersParameterGendersEnum>? genders;

  @JsonKey(name: r'emailVerified', required: false, includeIfNull: false)
  final bool? emailVerified;

  @JsonKey(name: r'banned', required: false, includeIfNull: false)
  final bool? banned;

  @JsonKey(name: r'startDate', required: false, includeIfNull: false)
  final DateTime? startDate;

  @JsonKey(name: r'endDate', required: false, includeIfNull: false)
  final DateTime? endDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdminListFiltersParameter &&
          other.roles == roles &&
          other.genders == genders &&
          other.emailVerified == emailVerified &&
          other.banned == banned &&
          other.startDate == startDate &&
          other.endDate == endDate;

  @override
  int get hashCode =>
      roles.hashCode +
      genders.hashCode +
      emailVerified.hashCode +
      banned.hashCode +
      startDate.hashCode +
      endDate.hashCode;

  factory UserAdminListFiltersParameter.fromJson(Map<String, dynamic> json) =>
      _$UserAdminListFiltersParameterFromJson(json);

  Map<String, dynamic> toJson() => _$UserAdminListFiltersParameterToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum UserAdminListFiltersParameterRolesEnum {
  @JsonValue(r'ADMIN')
  ADMIN(r'ADMIN'),
  @JsonValue(r'OPERATOR')
  OPERATOR(r'OPERATOR'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'USER')
  USER(r'USER');

  const UserAdminListFiltersParameterRolesEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum UserAdminListFiltersParameterGendersEnum {
  @JsonValue(r'MALE')
  MALE(r'MALE'),
  @JsonValue(r'FEMALE')
  FEMALE(r'FEMALE');

  const UserAdminListFiltersParameterGendersEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
