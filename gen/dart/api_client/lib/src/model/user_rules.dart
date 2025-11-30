//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_rules.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserRules {
  /// Returns a new [UserRules] instance.
  const UserRules({
     this.newUserOnly,
  });

  @JsonKey(name: r'newUserOnly', required: false, includeIfNull: false)
  final bool? newUserOnly;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UserRules &&
    other.newUserOnly == newUserOnly;

  @override
  int get hashCode =>
      newUserOnly.hashCode;

  factory UserRules.fromJson(Map<String, dynamic> json) => _$UserRulesFromJson(json);

  Map<String, dynamic> toJson() => _$UserRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

