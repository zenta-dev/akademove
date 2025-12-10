//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'sign_in_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SignInResponse {
  /// Returns a new [SignInResponse] instance.
  const SignInResponse({required this.token, required this.user});
  @JsonKey(name: r'token', required: true, includeIfNull: true)
  final String? token;

  @JsonKey(name: r'user', required: true, includeIfNull: false)
  final User user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInResponse && other.token == token && other.user == user;

  @override
  int get hashCode => (token == null ? 0 : token.hashCode) + user.hashCode;

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
