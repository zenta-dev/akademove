//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'auth_sign_up_user_request_phone.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSignUpUserRequestPhone {
  /// Returns a new [AuthSignUpUserRequestPhone] instance.
  AuthSignUpUserRequestPhone({required this.countryCode, required this.number});

  @JsonKey(name: r'countryCode', required: true, includeIfNull: false)
  final AuthSignUpUserRequestPhoneCountryCodeEnum countryCode;

  // minimum: 10
  // maximum: 15
  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final num number;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignUpUserRequestPhone &&
          other.countryCode == countryCode &&
          other.number == number;

  @override
  int get hashCode => countryCode.hashCode + number.hashCode;

  factory AuthSignUpUserRequestPhone.fromJson(Map<String, dynamic> json) =>
      _$AuthSignUpUserRequestPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSignUpUserRequestPhoneToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum AuthSignUpUserRequestPhoneCountryCodeEnum {
  @JsonValue(r'ID')
  ID(r'ID');

  const AuthSignUpUserRequestPhoneCountryCodeEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
