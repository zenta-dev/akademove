//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'pay_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PayRequest {
  /// Returns a new [PayRequest] instance.
  const PayRequest({required this.amount, this.referenceId});

  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final num amount;

  @JsonKey(name: r'referenceId', required: false, includeIfNull: false)
  final String? referenceId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayRequest &&
          other.amount == amount &&
          other.referenceId == referenceId;

  @override
  int get hashCode => amount.hashCode + referenceId.hashCode;

  factory PayRequest.fromJson(Map<String, dynamic> json) =>
      _$PayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PayRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
