//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'transfer_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransferResponse {
  /// Returns a new [TransferResponse] instance.
  const TransferResponse({
    required this.transactionId,
    required this.amount,
    required this.status,
    required this.recipientName,
    required this.recipientUserId,
    this.note,
    required this.createdAt,
  });
  @JsonKey(name: r'transactionId', required: true, includeIfNull: false)
  final String transactionId;

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;

  @JsonKey(name: r'recipientName', required: true, includeIfNull: false)
  final String recipientName;

  @JsonKey(name: r'recipientUserId', required: true, includeIfNull: false)
  final String recipientUserId;

  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;

  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferResponse &&
          other.transactionId == transactionId &&
          other.amount == amount &&
          other.status == status &&
          other.recipientName == recipientName &&
          other.recipientUserId == recipientUserId &&
          other.note == note &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      transactionId.hashCode +
      amount.hashCode +
      status.hashCode +
      recipientName.hashCode +
      recipientUserId.hashCode +
      note.hashCode +
      createdAt.hashCode;

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
