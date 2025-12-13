//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/bank_provider.dart';
import 'package:api_client/src/model/payment_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'top_up_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TopUpRequest {
  /// Returns a new [TopUpRequest] instance.
  const TopUpRequest({
    required this.amount,
    required this.provider,
    required this.method,
     this.bankProvider,
  });
  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;
  
  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final PaymentProvider provider;
  
  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final TopUpRequestMethodEnum method;
  
  @JsonKey(name: r'bankProvider', required: false, includeIfNull: false)
  final BankProvider? bankProvider;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is TopUpRequest &&
    other.amount == amount &&
    other.provider == provider &&
    other.method == method &&
    other.bankProvider == bankProvider;

  @override
  int get hashCode =>
      amount.hashCode +
      provider.hashCode +
      method.hashCode +
      bankProvider.hashCode;

  factory TopUpRequest.fromJson(Map<String, dynamic> json) => _$TopUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TopUpRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum TopUpRequestMethodEnum {
  @JsonValue(r'QRIS')
  QRIS(r'QRIS'),
  @JsonValue(r'BANK_TRANSFER')
  BANK_TRANSFER(r'BANK_TRANSFER');
  
  const TopUpRequestMethodEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

