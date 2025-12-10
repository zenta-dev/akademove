//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/fraud_status.dart';
import 'package:api_client/src/model/fraud_event_type.dart';
import 'package:api_client/src/model/fraud_severity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'fraud_event_list_query.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FraudEventListQuery {
  /// Returns a new [FraudEventListQuery] instance.
  const FraudEventListQuery({
    this.page,
    this.limit,
    this.status,
    this.severity,
    this.eventType,
    this.userId,
    this.driverId,
    this.startDate,
    this.endDate,
    this.sortBy,
    this.order,
  });
  @JsonKey(name: r'page', required: false, includeIfNull: false)
  final Object? page;

  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final Object? limit;

  @JsonKey(name: r'status', required: false, includeIfNull: false)
  final FraudStatus? status;

  @JsonKey(name: r'severity', required: false, includeIfNull: false)
  final FraudSeverity? severity;

  @JsonKey(name: r'eventType', required: false, includeIfNull: false)
  final FraudEventType? eventType;

  @JsonKey(name: r'userId', required: false, includeIfNull: false)
  final String? userId;

  @JsonKey(name: r'driverId', required: false, includeIfNull: false)
  final String? driverId;

  @JsonKey(name: r'startDate', required: false, includeIfNull: false)
  final DateTime? startDate;

  @JsonKey(name: r'endDate', required: false, includeIfNull: false)
  final DateTime? endDate;

  @JsonKey(name: r'sortBy', required: false, includeIfNull: false)
  final FraudEventListQuerySortByEnum? sortBy;

  @JsonKey(name: r'order', required: false, includeIfNull: false)
  final FraudEventListQueryOrderEnum? order;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FraudEventListQuery &&
          other.page == page &&
          other.limit == limit &&
          other.status == status &&
          other.severity == severity &&
          other.eventType == eventType &&
          other.userId == userId &&
          other.driverId == driverId &&
          other.startDate == startDate &&
          other.endDate == endDate &&
          other.sortBy == sortBy &&
          other.order == order;

  @override
  int get hashCode =>
      (page == null ? 0 : page.hashCode) +
      (limit == null ? 0 : limit.hashCode) +
      status.hashCode +
      severity.hashCode +
      eventType.hashCode +
      (userId == null ? 0 : userId.hashCode) +
      (driverId == null ? 0 : driverId.hashCode) +
      (startDate == null ? 0 : startDate.hashCode) +
      (endDate == null ? 0 : endDate.hashCode) +
      sortBy.hashCode +
      order.hashCode;

  factory FraudEventListQuery.fromJson(Map<String, dynamic> json) =>
      _$FraudEventListQueryFromJson(json);

  Map<String, dynamic> toJson() => _$FraudEventListQueryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum FraudEventListQuerySortByEnum {
  @JsonValue(r'detectedAt')
  detectedAt(r'detectedAt'),
  @JsonValue(r'severity')
  severity(r'severity'),
  @JsonValue(r'score')
  score(r'score');

  const FraudEventListQuerySortByEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum FraudEventListQueryOrderEnum {
  @JsonValue(r'asc')
  asc(r'asc'),
  @JsonValue(r'desc')
  desc(r'desc');

  const FraudEventListQueryOrderEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
