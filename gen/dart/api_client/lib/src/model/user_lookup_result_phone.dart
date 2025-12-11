//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'user_lookup_result_phone.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserLookupResultPhone {
  /// Returns a new [UserLookupResultPhone] instance.
  const UserLookupResultPhone({
    required this.countryCode,
    required this.maskedNumber,
  });
  @JsonKey(name: r'countryCode', required: true, includeIfNull: false)
  final String countryCode;
  
  @JsonKey(name: r'maskedNumber', required: true, includeIfNull: false)
  final String maskedNumber;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UserLookupResultPhone &&
    other.countryCode == countryCode &&
    other.maskedNumber == maskedNumber;

  @override
  int get hashCode =>
      countryCode.hashCode +
      maskedNumber.hashCode;

  factory UserLookupResultPhone.fromJson(Map<String, dynamic> json) => _$UserLookupResultPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$UserLookupResultPhoneToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

