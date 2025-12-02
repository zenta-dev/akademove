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
     this.perUserLimit,
  });

  @JsonKey(name: r'newUserOnly', required: false, includeIfNull: false)
  final bool? newUserOnly;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'perUserLimit', required: false, includeIfNull: false)
  final int? perUserLimit;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UserRules &&
    other.newUserOnly == newUserOnly &&
    other.perUserLimit == perUserLimit;

  @override
  int get hashCode =>
      newUserOnly.hashCode +
      perUserLimit.hashCode;

  factory UserRules.fromJson(Map<String, dynamic> json) => _$UserRulesFromJson(json);

  Map<String, dynamic> toJson() => _$UserRulesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

