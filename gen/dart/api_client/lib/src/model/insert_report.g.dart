// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertReportCWProxy {
  InsertReport orderId(String? orderId);

  InsertReport reporterId(String reporterId);

  InsertReport targetUserId(String targetUserId);

  InsertReport category(ReportCategory category);

  InsertReport description(String description);

  InsertReport evidenceUrl(String? evidenceUrl);

  InsertReport status(ReportStatus status);

  InsertReport handledById(String? handledById);

  InsertReport resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReport(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReport call({
    String? orderId,
    String reporterId,
    String targetUserId,
    ReportCategory category,
    String description,
    String? evidenceUrl,
    ReportStatus status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertReport.copyWith.fieldName(...)`
class _$InsertReportCWProxyImpl implements _$InsertReportCWProxy {
  const _$InsertReportCWProxyImpl(this._value);

  final InsertReport _value;

  @override
  InsertReport orderId(String? orderId) => this(orderId: orderId);

  @override
  InsertReport reporterId(String reporterId) => this(reporterId: reporterId);

  @override
  InsertReport targetUserId(String targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  InsertReport category(ReportCategory category) => this(category: category);

  @override
  InsertReport description(String description) =>
      this(description: description);

  @override
  InsertReport evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  InsertReport status(ReportStatus status) => this(status: status);

  @override
  InsertReport handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  InsertReport resolution(String? resolution) => this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReport(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReport call({
    Object? orderId = const $CopyWithPlaceholder(),
    Object? reporterId = const $CopyWithPlaceholder(),
    Object? targetUserId = const $CopyWithPlaceholder(),
    Object? category = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? evidenceUrl = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? handledById = const $CopyWithPlaceholder(),
    Object? resolution = const $CopyWithPlaceholder(),
  }) {
    return InsertReport(
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
          : category as ReportCategory,
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
          : status as ReportStatus,
      handledById: handledById == const $CopyWithPlaceholder()
          ? _value.handledById
          // ignore: cast_nullable_to_non_nullable
          : handledById as String?,
      resolution: resolution == const $CopyWithPlaceholder()
          ? _value.resolution
          // ignore: cast_nullable_to_non_nullable
          : resolution as String?,
    );
  }
}

extension $InsertReportCopyWith on InsertReport {
  /// Returns a callable class that can be used as follows: `instanceOfInsertReport.copyWith(...)` or like so:`instanceOfInsertReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertReportCWProxy get copyWith => _$InsertReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertReport _$InsertReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertReport', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'reporterId',
          'targetUserId',
          'category',
          'description',
          'status',
        ],
      );
      final val = InsertReport(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReportCategoryEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReportStatusEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertReportToJson(InsertReport instance) =>
    <String, dynamic>{
      'orderId': ?instance.orderId,
      'reporterId': instance.reporterId,
      'targetUserId': instance.targetUserId,
      'category': _$ReportCategoryEnumMap[instance.category]!,
      'description': instance.description,
      'evidenceUrl': ?instance.evidenceUrl,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'handledById': ?instance.handledById,
      'resolution': ?instance.resolution,
    };

const _$ReportCategoryEnumMap = {
  ReportCategory.behavior: 'behavior',
  ReportCategory.safety: 'safety',
  ReportCategory.fraud: 'fraud',
  ReportCategory.other: 'other',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.investigating: 'investigating',
  ReportStatus.resolved: 'resolved',
  ReportStatus.dismissed: 'dismissed',
};
