// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_list200_response_data_inner.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuditList200ResponseDataInnerCWProxy {
  AuditList200ResponseDataInner id(num id);

  AuditList200ResponseDataInner tableName(
    AuditList200ResponseDataInnerTableNameEnum tableName,
  );

  AuditList200ResponseDataInner recordId(String recordId);

  AuditList200ResponseDataInner operation(
    AuditList200ResponseDataInnerOperationEnum operation,
  );

  AuditList200ResponseDataInner oldData(Object? oldData);

  AuditList200ResponseDataInner newData(Object? newData);

  AuditList200ResponseDataInner updatedById(String? updatedById);

  AuditList200ResponseDataInner ipAddress(String? ipAddress);

  AuditList200ResponseDataInner userAgent(String? userAgent);

  AuditList200ResponseDataInner sessionId(String? sessionId);

  AuditList200ResponseDataInner reason(String? reason);

  AuditList200ResponseDataInner updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditList200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditList200ResponseDataInner call({
    num id,
    AuditList200ResponseDataInnerTableNameEnum tableName,
    String recordId,
    AuditList200ResponseDataInnerOperationEnum operation,
    Object? oldData,
    Object? newData,
    String? updatedById,
    String? ipAddress,
    String? userAgent,
    String? sessionId,
    String? reason,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuditList200ResponseDataInner.copyWith(...)` or call `instanceOfAuditList200ResponseDataInner.copyWith.fieldName(value)` for a single field.
class _$AuditList200ResponseDataInnerCWProxyImpl
    implements _$AuditList200ResponseDataInnerCWProxy {
  const _$AuditList200ResponseDataInnerCWProxyImpl(this._value);

  final AuditList200ResponseDataInner _value;

  @override
  AuditList200ResponseDataInner id(num id) => call(id: id);

  @override
  AuditList200ResponseDataInner tableName(
    AuditList200ResponseDataInnerTableNameEnum tableName,
  ) => call(tableName: tableName);

  @override
  AuditList200ResponseDataInner recordId(String recordId) =>
      call(recordId: recordId);

  @override
  AuditList200ResponseDataInner operation(
    AuditList200ResponseDataInnerOperationEnum operation,
  ) => call(operation: operation);

  @override
  AuditList200ResponseDataInner oldData(Object? oldData) =>
      call(oldData: oldData);

  @override
  AuditList200ResponseDataInner newData(Object? newData) =>
      call(newData: newData);

  @override
  AuditList200ResponseDataInner updatedById(String? updatedById) =>
      call(updatedById: updatedById);

  @override
  AuditList200ResponseDataInner ipAddress(String? ipAddress) =>
      call(ipAddress: ipAddress);

  @override
  AuditList200ResponseDataInner userAgent(String? userAgent) =>
      call(userAgent: userAgent);

  @override
  AuditList200ResponseDataInner sessionId(String? sessionId) =>
      call(sessionId: sessionId);

  @override
  AuditList200ResponseDataInner reason(String? reason) => call(reason: reason);

  @override
  AuditList200ResponseDataInner updatedAt(DateTime? updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditList200ResponseDataInner(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditList200ResponseDataInner(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditList200ResponseDataInner call({
    Object? id = const $CopyWithPlaceholder(),
    Object? tableName = const $CopyWithPlaceholder(),
    Object? recordId = const $CopyWithPlaceholder(),
    Object? operation = const $CopyWithPlaceholder(),
    Object? oldData = const $CopyWithPlaceholder(),
    Object? newData = const $CopyWithPlaceholder(),
    Object? updatedById = const $CopyWithPlaceholder(),
    Object? ipAddress = const $CopyWithPlaceholder(),
    Object? userAgent = const $CopyWithPlaceholder(),
    Object? sessionId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return AuditList200ResponseDataInner(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as num,
      tableName: tableName == const $CopyWithPlaceholder() || tableName == null
          ? _value.tableName
          // ignore: cast_nullable_to_non_nullable
          : tableName as AuditList200ResponseDataInnerTableNameEnum,
      recordId: recordId == const $CopyWithPlaceholder() || recordId == null
          ? _value.recordId
          // ignore: cast_nullable_to_non_nullable
          : recordId as String,
      operation: operation == const $CopyWithPlaceholder() || operation == null
          ? _value.operation
          // ignore: cast_nullable_to_non_nullable
          : operation as AuditList200ResponseDataInnerOperationEnum,
      oldData: oldData == const $CopyWithPlaceholder()
          ? _value.oldData
          // ignore: cast_nullable_to_non_nullable
          : oldData as Object?,
      newData: newData == const $CopyWithPlaceholder()
          ? _value.newData
          // ignore: cast_nullable_to_non_nullable
          : newData as Object?,
      updatedById: updatedById == const $CopyWithPlaceholder()
          ? _value.updatedById
          // ignore: cast_nullable_to_non_nullable
          : updatedById as String?,
      ipAddress: ipAddress == const $CopyWithPlaceholder()
          ? _value.ipAddress
          // ignore: cast_nullable_to_non_nullable
          : ipAddress as String?,
      userAgent: userAgent == const $CopyWithPlaceholder()
          ? _value.userAgent
          // ignore: cast_nullable_to_non_nullable
          : userAgent as String?,
      sessionId: sessionId == const $CopyWithPlaceholder()
          ? _value.sessionId
          // ignore: cast_nullable_to_non_nullable
          : sessionId as String?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $AuditList200ResponseDataInnerCopyWith
    on AuditList200ResponseDataInner {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuditList200ResponseDataInner.copyWith(...)` or `instanceOfAuditList200ResponseDataInner.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuditList200ResponseDataInnerCWProxy get copyWith =>
      _$AuditList200ResponseDataInnerCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditList200ResponseDataInner _$AuditList200ResponseDataInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuditList200ResponseDataInner', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'tableName',
      'recordId',
      'operation',
      'updatedAt',
    ],
  );
  final val = AuditList200ResponseDataInner(
    id: $checkedConvert('id', (v) => v as num),
    tableName: $checkedConvert(
      'tableName',
      (v) =>
          $enumDecode(_$AuditList200ResponseDataInnerTableNameEnumEnumMap, v),
    ),
    recordId: $checkedConvert('recordId', (v) => v as String),
    operation: $checkedConvert(
      'operation',
      (v) =>
          $enumDecode(_$AuditList200ResponseDataInnerOperationEnumEnumMap, v),
    ),
    oldData: $checkedConvert('oldData', (v) => v),
    newData: $checkedConvert('newData', (v) => v),
    updatedById: $checkedConvert('updatedById', (v) => v as String?),
    ipAddress: $checkedConvert('ipAddress', (v) => v as String?),
    userAgent: $checkedConvert('userAgent', (v) => v as String?),
    sessionId: $checkedConvert('sessionId', (v) => v as String?),
    reason: $checkedConvert('reason', (v) => v as String?),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$AuditList200ResponseDataInnerToJson(
  AuditList200ResponseDataInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'tableName':
      _$AuditList200ResponseDataInnerTableNameEnumEnumMap[instance.tableName]!,
  'recordId': instance.recordId,
  'operation':
      _$AuditList200ResponseDataInnerOperationEnumEnumMap[instance.operation]!,
  'oldData': ?instance.oldData,
  'newData': ?instance.newData,
  'updatedById': ?instance.updatedById,
  'ipAddress': ?instance.ipAddress,
  'userAgent': ?instance.userAgent,
  'sessionId': ?instance.sessionId,
  'reason': ?instance.reason,
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$AuditList200ResponseDataInnerTableNameEnumEnumMap = {
  AuditList200ResponseDataInnerTableNameEnum.configurations: 'configurations',
  AuditList200ResponseDataInnerTableNameEnum.contact: 'contact',
  AuditList200ResponseDataInnerTableNameEnum.coupon: 'coupon',
  AuditList200ResponseDataInnerTableNameEnum.report: 'report',
  AuditList200ResponseDataInnerTableNameEnum.user: 'user',
  AuditList200ResponseDataInnerTableNameEnum.wallet: 'wallet',
};

const _$AuditList200ResponseDataInnerOperationEnumEnumMap = {
  AuditList200ResponseDataInnerOperationEnum.INSERT: 'INSERT',
  AuditList200ResponseDataInnerOperationEnum.UPDATE: 'UPDATE',
  AuditList200ResponseDataInnerOperationEnum.DELETE: 'DELETE',
};
