//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/order_status_history_job_payload.dart';
import 'package:api_client/src/model/queue_message_meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'order_status_history_job.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderStatusHistoryJob {
  /// Returns a new [OrderStatusHistoryJob] instance.
  const OrderStatusHistoryJob({
    required this.type,
    required this.meta,
    required this.payload,
  });
  @JsonKey(name: r'type', required: true, includeIfNull: true)
  final Object? type;

  @JsonKey(name: r'meta', required: true, includeIfNull: false)
  final QueueMessageMeta meta;

  @JsonKey(name: r'payload', required: true, includeIfNull: false)
  final OrderStatusHistoryJobPayload payload;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderStatusHistoryJob &&
          other.type == type &&
          other.meta == meta &&
          other.payload == payload;

  @override
  int get hashCode =>
      (type == null ? 0 : type.hashCode) + meta.hashCode + payload.hashCode;

  factory OrderStatusHistoryJob.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusHistoryJobFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusHistoryJobToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
