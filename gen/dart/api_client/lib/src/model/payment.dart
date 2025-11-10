//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/payment_provider.dart';
import 'package:api_client/src/model/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'payment.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Payment {
  /// Returns a new [Payment] instance.
  const Payment({
    required this.id,
    required this.transactionId,
    required this.provider,
    required this.method,
    required this.amount,
    required this.status,
    this.externalId,
    this.paymentUrl,
    this.metadata,
    this.expiresAt,
    this.payload,
    this.response,
    required this.createdAt,
    required this.updatedAt,
  });

  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'transactionId', required: true, includeIfNull: false)
  final String transactionId;

  @JsonKey(name: r'provider', required: true, includeIfNull: false)
  final PaymentProvider provider;

  @JsonKey(name: r'method', required: true, includeIfNull: false)
  final PaymentMethod method;

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;

  @JsonKey(name: r'externalId', required: false, includeIfNull: false)
  final String? externalId;

  @JsonKey(name: r'paymentUrl', required: false, includeIfNull: false)
  final String? paymentUrl;

  @JsonKey(name: r'metadata', required: false, includeIfNull: false)
  final Object? metadata;

  @JsonKey(name: r'expiresAt', required: false, includeIfNull: false)
  final DateTime? expiresAt;

  @JsonKey(name: r'payload', required: false, includeIfNull: false)
  final Object? payload;

  @JsonKey(name: r'response', required: false, includeIfNull: false)
  final Object? response;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Payment &&
          other.id == id &&
          other.transactionId == transactionId &&
          other.provider == provider &&
          other.method == method &&
          other.amount == amount &&
          other.status == status &&
          other.externalId == externalId &&
          other.paymentUrl == paymentUrl &&
          other.metadata == metadata &&
          other.expiresAt == expiresAt &&
          other.payload == payload &&
          other.response == response &&
          other.createdAt == createdAt &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      transactionId.hashCode +
      provider.hashCode +
      method.hashCode +
      amount.hashCode +
      status.hashCode +
      externalId.hashCode +
      paymentUrl.hashCode +
      (metadata == null ? 0 : metadata.hashCode) +
      expiresAt.hashCode +
      (payload == null ? 0 : payload.hashCode) +
      (response == null ? 0 : response.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
