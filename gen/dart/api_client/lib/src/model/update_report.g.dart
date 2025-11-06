// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateReportCWProxy {
  UpdateReport orderId(String? orderId);

  UpdateReport reporterId(String? reporterId);

  UpdateReport targetUserId(String? targetUserId);

  UpdateReport category(ReportCategory? category);

  UpdateReport description(String? description);

  UpdateReport evidenceUrl(String? evidenceUrl);

  UpdateReport status(ReportStatus? status);

  UpdateReport handledById(String? handledById);

  UpdateReport resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReport(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReport call({
    String? orderId,
    String? reporterId,
    String? targetUserId,
    ReportCategory? category,
    String? description,
    String? evidenceUrl,
    ReportStatus? status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateReport.copyWith.fieldName(...)`
class _$UpdateReportCWProxyImpl implements _$UpdateReportCWProxy {
  const _$UpdateReportCWProxyImpl(this._value);

  final UpdateReport _value;

  @override
  UpdateReport orderId(String? orderId) => this(orderId: orderId);

  @override
  UpdateReport reporterId(String? reporterId) => this(reporterId: reporterId);

  @override
  UpdateReport targetUserId(String? targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  UpdateReport category(ReportCategory? category) => this(category: category);

  @override
  UpdateReport description(String? description) =>
      this(description: description);

  @override
  UpdateReport evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  UpdateReport status(ReportStatus? status) => this(status: status);

  @override
  UpdateReport handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  UpdateReport resolution(String? resolution) => this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReport(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReport call({
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
    return UpdateReport(
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      reporterId: reporterId == const $CopyWithPlaceholder()
          ? _value.reporterId
          // ignore: cast_nullable_to_non_nullable
          : reporterId as String?,
      targetUserId: targetUserId == const $CopyWithPlaceholder()
          ? _value.targetUserId
          // ignore: cast_nullable_to_non_nullable
          : targetUserId as String?,
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReportCategory?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      evidenceUrl: evidenceUrl == const $CopyWithPlaceholder()
          ? _value.evidenceUrl
          // ignore: cast_nullable_to_non_nullable
          : evidenceUrl as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ReportStatus?,
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

extension $UpdateReportCopyWith on UpdateReport {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateReport.copyWith(...)` or like so:`instanceOfUpdateReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateReportCWProxy get copyWith => _$UpdateReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReport _$UpdateReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateReport', json, ($checkedConvert) {
      final val = UpdateReport(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String?),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$ReportCategoryEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$ReportStatusEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateReportToJson(UpdateReport instance) =>
    <String, dynamic>{
      'orderId': ?instance.orderId,
      'reporterId': ?instance.reporterId,
      'targetUserId': ?instance.targetUserId,
      'category': ?_$ReportCategoryEnumMap[instance.category],
      'description': ?instance.description,
      'evidenceUrl': ?instance.evidenceUrl,
      'status': ?_$ReportStatusEnumMap[instance.status],
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
