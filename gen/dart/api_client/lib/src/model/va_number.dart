//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'va_number.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class VANumber {
  /// Returns a new [VANumber] instance.
  const VANumber({required this.bank, required this.vaNumber});

  @JsonKey(name: r'bank', required: true, includeIfNull: false)
  final String bank;

  @JsonKey(name: r'va_number', required: true, includeIfNull: false)
  final String vaNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is VANumber && other.bank == bank && other.vaNumber == vaNumber;

  @override
  int get hashCode => bank.hashCode + vaNumber.hashCode;

  factory VANumber.fromJson(Map<String, dynamic> json) => _$VANumberFromJson(json);

  Map<String, dynamic> toJson() => _$VANumberToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
