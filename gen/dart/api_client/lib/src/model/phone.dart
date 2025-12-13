//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/country_code.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'phone.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Phone {
  /// Returns a new [Phone] instance.
  const Phone({required this.countryCode, required this.number});
  @JsonKey(name: r'countryCode', required: true, includeIfNull: false)
  final CountryCode countryCode;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final int number;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Phone &&
          other.countryCode == countryCode &&
          other.number == number;

  @override
  int get hashCode => countryCode.hashCode + number.hashCode;

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
