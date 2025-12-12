//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'verify_email.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VerifyEmail {
  /// Returns a new [VerifyEmail] instance.
  const VerifyEmail({required this.email, required this.code});
  @JsonKey(name: r'email', required: true, includeIfNull: false)
  final String email;

  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VerifyEmail && other.email == email && other.code == code;

  @override
  int get hashCode => email.hashCode + code.hashCode;

  factory VerifyEmail.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
