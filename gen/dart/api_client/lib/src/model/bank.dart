//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/bank_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'bank.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Bank {
  /// Returns a new [Bank] instance.
  const Bank({
    required this.provider,
    required this.number,
  });

  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final BankProvider provider;
  
  @JsonKey(name: r'number', required: true, includeIfNull: false)
  final num number;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is Bank &&
    other.provider == provider &&
    other.number == number;

  @override
  int get hashCode =>
      provider.hashCode +
      number.hashCode;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

  Map<String, dynamic> toJson() => _$BankToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

