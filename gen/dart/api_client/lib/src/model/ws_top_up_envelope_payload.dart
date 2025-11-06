//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/transaction_status.dart';
import 'package:api_client/src/model/transaction.dart';
import 'package:api_client/src/model/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'ws_top_up_envelope_payload.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WSTopUpEnvelopePayload {
  /// Returns a new [WSTopUpEnvelopePayload] instance.
  const WSTopUpEnvelopePayload({
    required this.status,
    required this.wallet,
    required this.transaction,
  });

  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final TransactionStatus status;

  @JsonKey(name: r'wallet', required: true, includeIfNull: false)
  final Wallet wallet;

  @JsonKey(name: r'transaction', required: true, includeIfNull: false)
  final Transaction transaction;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WSTopUpEnvelopePayload &&
          other.status == status &&
          other.wallet == wallet &&
          other.transaction == transaction;

  @override
  int get hashCode => status.hashCode + wallet.hashCode + transaction.hashCode;

  factory WSTopUpEnvelopePayload.fromJson(Map<String, dynamic> json) =>
      _$WSTopUpEnvelopePayloadFromJson(json);

  Map<String, dynamic> toJson() => _$WSTopUpEnvelopePayloadToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
