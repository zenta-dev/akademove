//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'send_email_verification.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SendEmailVerification {
  /// Returns a new [SendEmailVerification] instance.
  const SendEmailVerification({required this.email});
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SendEmailVerification && other.email == email;

  @override
  int get hashCode => email.hashCode;

  factory SendEmailVerification.fromJson(Map<String, dynamic> json) =>
      _$SendEmailVerificationFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailVerificationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
