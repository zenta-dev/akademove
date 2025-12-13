//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'transfer_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TransferRequest {
  /// Returns a new [TransferRequest] instance.
  const TransferRequest({
    required this.amount,
    required this.recipientUserId,
     this.note,
  });
  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;
  
      /// The user ID of the recipient
  @JsonKey(name: r'recipientUserId', required: true, includeIfNull: false)
  final String recipientUserId;
  
      /// Optional note for the transfer
  @JsonKey(name: r'note', required: false, includeIfNull: false)
  final String? note;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is TransferRequest &&
    other.amount == amount &&
    other.recipientUserId == recipientUserId &&
    other.note == note;

  @override
  int get hashCode =>
      amount.hashCode +
      recipientUserId.hashCode +
      note.hashCode;

  factory TransferRequest.fromJson(Map<String, dynamic> json) => _$TransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransferRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

