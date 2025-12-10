//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/bank_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'bank_validation_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BankValidationRequest {
  /// Returns a new [BankValidationRequest] instance.
  const BankValidationRequest({
    required this.bankProvider,
    required this.accountNumber,
  });
  @JsonKey(name: r'bankProvider', required: true, includeIfNull: false)
  final BankProvider bankProvider;

  @JsonKey(name: r'accountNumber', required: true, includeIfNull: false)
  final String accountNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankValidationRequest &&
          other.bankProvider == bankProvider &&
          other.accountNumber == accountNumber;

  @override
  int get hashCode => bankProvider.hashCode + accountNumber.hashCode;

  factory BankValidationRequest.fromJson(Map<String, dynamic> json) =>
      _$BankValidationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BankValidationRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
