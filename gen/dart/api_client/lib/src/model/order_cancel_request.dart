//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_cancel_request.g.dart';

@CopyWith()
@JsonSerializable(checked: true, createToJson: true, disallowUnrecognizedKeys: false, explicitToJson: true)
class OrderCancelRequest {
  /// Returns a new [OrderCancelRequest] instance.
  const OrderCancelRequest({this.reason});

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderCancelRequest && other.reason == reason;

  @override
  int get hashCode => reason.hashCode;

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) => _$OrderCancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
