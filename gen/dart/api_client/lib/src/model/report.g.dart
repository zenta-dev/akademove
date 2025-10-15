// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCWProxy {
  Report id(String id);

  Report orderId(String? orderId);

  Report reporterId(String reporterId);

  Report targetUserId(String targetUserId);

  Report category(ReportCategoryEnum category);

  Report description(String description);

  Report evidenceUrl(String? evidenceUrl);

  Report status(ReportStatusEnum status);

  Report handledById(String? handledById);

  Report resolution(String? resolution);

  Report reportedAt(DateTime reportedAt);

  Report resolvedAt(DateTime? resolvedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    String id,
    String? orderId,
    String reporterId,
    String targetUserId,
    ReportCategoryEnum category,
    String description,
    String? evidenceUrl,
    ReportStatusEnum status,
    String? handledById,
    String? resolution,
    DateTime reportedAt,
    DateTime? resolvedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReport.copyWith.fieldName(...)`
class _$ReportCWProxyImpl implements _$ReportCWProxy {
  const _$ReportCWProxyImpl(this._value);

  final Report _value;

  @override
  Report id(String id) => this(id: id);

  @override
  Report orderId(String? orderId) => this(orderId: orderId);

  @override
  Report reporterId(String reporterId) => this(reporterId: reporterId);

  @override
  Report targetUserId(String targetUserId) => this(targetUserId: targetUserId);

  @override
  Report category(ReportCategoryEnum category) => this(category: category);

  @override
  Report description(String description) => this(description: description);

  @override
  Report evidenceUrl(String? evidenceUrl) => this(evidenceUrl: evidenceUrl);

  @override
  Report status(ReportStatusEnum status) => this(status: status);

  @override
  Report handledById(String? handledById) => this(handledById: handledById);

  @override
  Report resolution(String? resolution) => this(resolution: resolution);

  @override
  Report reportedAt(DateTime reportedAt) => this(reportedAt: reportedAt);

  @override
  Report resolvedAt(DateTime? resolvedAt) => this(resolvedAt: resolvedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Report(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ````
  Report call({
    Object? id = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? reporterId = const $CopyWithPlaceholder(),
    Object? targetUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? evidenceUrl = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? handledById = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
    Object? reportedAt = const $CopyWithPlaceholder(),
    Object? resolvedAt = const $CopyWithPlaceholder(),
  }) {
    return Report(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      reporterId: reporterId == const $CopyWithPlaceholder()
          ? _value.reporterId
          // ignore: cast_nullable_to_non_nullable
          : reporterId as String,
      targetUserId: targetUserId == const $CopyWithPlaceholder()
          ? _value.targetUserId
          // ignore: cast_nullable_to_non_nullable
          : targetUserId as String,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReportCategoryEnum,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      evidenceUrl: evidenceUrl == const $CopyWithPlaceholder()
          ? _value.evidenceUrl
          // ignore: cast_nullable_to_non_nullable
          : evidenceUrl as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReportStatusEnum,
      handledById: handledById == const $CopyWithPlaceholder()
          ? _value.handledById
          // ignore: cast_nullable_to_non_nullable
          : handledById as String?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
      reportedAt: reportedAt == const $CopyWithPlaceholder()
          ? _value.reportedAt
          // ignore: cast_nullable_to_non_nullable
          : reportedAt as DateTime,
      resolvedAt: resolvedAt == const $CopyWithPlaceholder()
          ? _value.resolvedAt
          // ignore: cast_nullable_to_non_nullable
          : resolvedAt as DateTime?,
    );
  }
}

extension $ReportCopyWith on Report {
  /// Returns a callable class that can be used as follows: `instanceOfReport.copyWith(...)` or like so:`instanceOfReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportCWProxy get copyWith => _$ReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Report', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'reporterId',
          'targetUserId',
          'category',
          'description',
          'status',
          'reportedAt',
        ],
      );
      final val = Report(
        id: $checkedConvert('id', (v) => v as String),
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReportCategoryEnumEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReportStatusEnumEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
        reportedAt: $checkedConvert(
          'reportedAt',
          (v) => DateTime.parse(v as String),
        ),
        resolvedAt: $checkedConvert(
          'resolvedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
  'id': instance.id,
  'orderId': ?instance.orderId,
  'reporterId': instance.reporterId,
  'targetUserId': instance.targetUserId,
  'category': _$ReportCategoryEnumEnumMap[instance.category]!,
  'description': instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': _$ReportStatusEnumEnumMap[instance.status]!,
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
  'reportedAt': instance.reportedAt.toIso8601String(),
  'resolvedAt': ?instance.resolvedAt?.toIso8601String(),
};

const _$ReportCategoryEnumEnumMap = {
  ReportCategoryEnum.behavior: 'behavior',
  ReportCategoryEnum.safety: 'safety',
  ReportCategoryEnum.fraud: 'fraud',
  ReportCategoryEnum.other: 'other',
};

const _$ReportStatusEnumEnumMap = {
  ReportStatusEnum.pending: 'pending',
  ReportStatusEnum.investigating: 'investigating',
  ReportStatusEnum.resolved: 'resolved',
  ReportStatusEnum.dismissed: 'dismissed',
};
