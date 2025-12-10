//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'audit_list200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuditList200ResponseDataInner {
  /// Returns a new [AuditList200ResponseDataInner] instance.
  const AuditList200ResponseDataInner({
    required this.id,
    required this.tableName,
    required this.recordId,
    required this.operation,
    this.oldData,
    this.newData,
    this.updatedById,
    this.ipAddress,
    this.userAgent,
    this.sessionId,
    this.reason,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final num id;

  @JsonKey(name: r'tableName', required: true, includeIfNull: false)
  final AuditList200ResponseDataInnerTableNameEnum tableName;

  @JsonKey(name: r'recordId', required: true, includeIfNull: true)
  final String? recordId;

  @JsonKey(name: r'operation', required: true, includeIfNull: false)
  final AuditList200ResponseDataInnerOperationEnum operation;

  @JsonKey(name: r'oldData', required: false, includeIfNull: false)
  final Object? oldData;

  @JsonKey(name: r'newData', required: false, includeIfNull: false)
  final Object? newData;

  @JsonKey(name: r'updatedById', required: false, includeIfNull: false)
  final String? updatedById;

  @JsonKey(name: r'ipAddress', required: false, includeIfNull: false)
  final String? ipAddress;

  @JsonKey(name: r'userAgent', required: false, includeIfNull: false)
  final String? userAgent;

  @JsonKey(name: r'sessionId', required: false, includeIfNull: false)
  final String? sessionId;

  @JsonKey(name: r'reason', required: false, includeIfNull: false)
  final String? reason;

  @JsonKey(name: r'updatedAt', required: true, includeIfNull: true)
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuditList200ResponseDataInner &&
          other.id == id &&
          other.tableName == tableName &&
          other.recordId == recordId &&
          other.operation == operation &&
          other.oldData == oldData &&
          other.newData == newData &&
          other.updatedById == updatedById &&
          other.ipAddress == ipAddress &&
          other.userAgent == userAgent &&
          other.sessionId == sessionId &&
          other.reason == reason &&
          other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      tableName.hashCode +
      (recordId == null ? 0 : recordId.hashCode) +
      operation.hashCode +
      (oldData == null ? 0 : oldData.hashCode) +
      (newData == null ? 0 : newData.hashCode) +
      (updatedById == null ? 0 : updatedById.hashCode) +
      (ipAddress == null ? 0 : ipAddress.hashCode) +
      (userAgent == null ? 0 : userAgent.hashCode) +
      (sessionId == null ? 0 : sessionId.hashCode) +
      (reason == null ? 0 : reason.hashCode) +
      (updatedAt == null ? 0 : updatedAt.hashCode);

  factory AuditList200ResponseDataInner.fromJson(Map<String, dynamic> json) =>
      _$AuditList200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() => _$AuditList200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum AuditList200ResponseDataInnerTableNameEnum {
  @JsonValue(r'configurations')
  configurations(r'configurations'),
  @JsonValue(r'contact')
  contact(r'contact'),
  @JsonValue(r'coupon')
  coupon(r'coupon'),
  @JsonValue(r'report')
  report(r'report'),
  @JsonValue(r'user')
  user(r'user'),
  @JsonValue(r'wallet')
  wallet(r'wallet');

  const AuditList200ResponseDataInnerTableNameEnum(this.value);

  final String value;

  @override
  String toString() => value;
}

enum AuditList200ResponseDataInnerOperationEnum {
  @JsonValue(r'INSERT')
  INSERT(r'INSERT'),
  @JsonValue(r'UPDATE')
  UPDATE(r'UPDATE'),
  @JsonValue(r'DELETE')
  DELETE(r'DELETE');

  const AuditList200ResponseDataInnerOperationEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
