//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_forgot_password_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthForgotPasswordRequest {
  /// Returns a new [AuthForgotPasswordRequest] instance.
  const AuthForgotPasswordRequest({
    required this.email,
  });

  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthForgotPasswordRequest &&
    other.email == email;

  @override
  int get hashCode =>
      email.hashCode;

  factory AuthForgotPasswordRequest.fromJson(Map<String, dynamic> json) => _$AuthForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthForgotPasswordRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

