//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'sign_up_res_body.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SignUpResBody {
  /// Returns a new [SignUpResBody] instance.
  SignUpResBody({required this.user});

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SignUpResBody && other.user == user;

  @override
  int get hashCode => user.hashCode;

  factory SignUpResBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpResBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
