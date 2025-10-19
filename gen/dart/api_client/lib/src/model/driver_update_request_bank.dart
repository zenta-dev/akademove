//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_update_request_bank.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverUpdateRequestBank {
  /// Returns a new [DriverUpdateRequestBank] instance.
  DriverUpdateRequestBank({required this.provider, required this.number});

  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final DriverUpdateRequestBankProviderEnum provider;

  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final num number;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverUpdateRequestBank &&
          other.provider == provider &&
          other.number == number;

  @override
  int get hashCode => provider.hashCode + number.hashCode;

  factory DriverUpdateRequestBank.fromJson(Map<String, dynamic> json) =>
      _$DriverUpdateRequestBankFromJson(json);

  Map<String, dynamic> toJson() => _$DriverUpdateRequestBankToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum DriverUpdateRequestBankProviderEnum {
  @JsonValue(r'BCA')
  BCA(r'BCA'),
  @JsonValue(r'BNI')
  BNI(r'BNI'),
  @JsonValue(r'BRI')
  BRI(r'BRI'),
  @JsonValue(r'Mandiri')
  mandiri(r'Mandiri'),
  @JsonValue(r'Permata')
  permata(r'Permata'),
  @JsonValue(r'CIMB')
  CIMB(r'CIMB'),
  @JsonValue(r'Danamon')
  danamon(r'Danamon');

  const DriverUpdateRequestBankProviderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
