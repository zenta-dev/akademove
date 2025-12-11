//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/bank_provider.dart';
import 'package:api_client/src/model/payment_provider.dart';
import 'package:api_client/src/model/va_number.dart';
import 'package:api_client/src/model/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_payment.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdatePayment {
  /// Returns a new [UpdatePayment] instance.
  const UpdatePayment({
     this.transactionId,
     this.provider,
     this.method,
     this.bankProvider,
     this.amount,
     this.status,
     this.externalId,
     this.paymentUrl,
     this.vaNumber,
     this.metadata,
     this.expiresAt,
     this.payload,
     this.response,
  });
  @JsonKey(name: r'transactionId', required: false, includeIfNull: false)
  final String? transactionId;
  
  @JsonKey(name: r'provider', required: false, includeIfNull: false)
  final PaymentProvider? provider;
  
  @JsonKey(name: r'method', required: false, includeIfNull: false)
  final PaymentMethod? method;
  
  @JsonKey(name: r'bankProvider', required: false, includeIfNull: false)
  final BankProvider? bankProvider;
  
  @JsonKey(name: r'amount', required: false, includeIfNull: false)
  final num? amount;
  
  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final TransactionStatus? status;
  
  @JsonKey(name: r'externalId', required: false, includeIfNull: false)
  final String? externalId;
  
  @JsonKey(name: r'paymentUrl', required: false, includeIfNull: false)
  final String? paymentUrl;
  
  @JsonKey(name: r'va_number', required: false, includeIfNull: false)
  final VANumber? vaNumber;
  
  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Object? metadata;
  
  @JsonKey(name: r'expiresAt', required: false, includeIfNull: false)
  final DateTime? expiresAt;
  
  @JsonKey(name: r'payload', required: false, includeIfNull: false)
  final Object? payload;
  
  @JsonKey(name: r'response', required: false, includeIfNull: false)
  final Object? response;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdatePayment &&
    other.transactionId == transactionId &&
    other.provider == provider &&
    other.method == method &&
    other.bankProvider == bankProvider &&
    other.amount == amount &&
    other.status == status &&
    other.externalId == externalId &&
    other.paymentUrl == paymentUrl &&
    other.vaNumber == vaNumber &&
    other.metadata == metadata &&
    other.expiresAt == expiresAt &&
    other.payload == payload &&
    other.response == response;

  @override
  int get hashCode =>
      transactionId.hashCode +
      provider.hashCode +
      method.hashCode +
      bankProvider.hashCode +
      amount.hashCode +
      status.hashCode +
      externalId.hashCode +
      paymentUrl.hashCode +
      vaNumber.hashCode +
      (metadata == null ? 0 : metadata.hashCode) +
      (expiresAt == null ? 0 : expiresAt.hashCode) +
      (payload == null ? 0 : payload.hashCode) +
      (response == null ? 0 : response.hashCode);

  factory UpdatePayment.fromJson(Map<String, dynamic> json) => _$UpdatePaymentFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

