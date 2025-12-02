//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'transfer_request.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class TransferRequest {
  /// Returns a new [TransferRequest] instance.
  const TransferRequest({required this.amount, required this.walletId});

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'walletId', required: true, includeIfNull: false)
  final String walletId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TransferRequest && other.amount == amount && other.walletId == walletId;

  @override
  int get hashCode => amount.hashCode + walletId.hashCode;

  factory TransferRequest.fromJson(Map<String, dynamic> json) => _$TransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransferRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
