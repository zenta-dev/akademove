//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'sign_up_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SignUpResponse {
  /// Returns a new [SignUpResponse] instance.
  const SignUpResponse({required this.token, required this.user});
  @JsonKey(name: r'token', required: true, includeIfNull: true)
  final String? token;

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpResponse && other.token == token && other.user == user;

  @override
  int get hashCode => (token == null ? 0 : token.hashCode) + user.hashCode;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
