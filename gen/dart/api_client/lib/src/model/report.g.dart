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

  Report category(ReportCategory category);

  Report description(String description);

  Report evidenceUrl(String? evidenceUrl);

  Report status(ReportStatus status);

  Report handledById(String? handledById);

  Report resolution(String? resolution);

  Report reportedAt(DateTime reportedAt);

  Report resolvedAt(DateTime? resolvedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Report(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ```
  Report call({
    String id,
    String? orderId,
    String reporterId,
    String targetUserId,
    ReportCategory category,
    String description,
    String? evidenceUrl,
    ReportStatus status,
    String? handledById,
    String? resolution,
    DateTime reportedAt,
    DateTime? resolvedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfReport.copyWith(...)` or call `instanceOfReport.copyWith.fieldName(value)` for a single field.
class _$ReportCWProxyImpl implements _$ReportCWProxy {
  const _$ReportCWProxyImpl(this._value);

  final Report _value;

  @override
  Report id(String id) => call(id: id);

  @override
  Report orderId(String? orderId) => call(orderId: orderId);

  @override
  Report reporterId(String reporterId) => call(reporterId: reporterId);

  @override
  Report targetUserId(String targetUserId) => call(targetUserId: targetUserId);

  @override
  Report category(ReportCategory category) => call(category: category);

  @override
  Report description(String description) => call(description: description);

  @override
  Report evidenceUrl(String? evidenceUrl) => call(evidenceUrl: evidenceUrl);

  @override
  Report status(ReportStatus status) => call(status: status);

  @override
  Report handledById(String? handledById) => call(handledById: handledById);

  @override
  Report resolution(String? resolution) => call(resolution: resolution);

  @override
  Report reportedAt(DateTime reportedAt) => call(reportedAt: reportedAt);

  @override
  Report resolvedAt(DateTime? resolvedAt) => call(resolvedAt: resolvedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `Report(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// Report(...).copyWith(id: 12, name: "My name")
  /// ```
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
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      reporterId:
          reporterId == const $CopyWithPlaceholder() || reporterId == null
          ? _value.reporterId
          // ignore: cast_nullable_to_non_nullable
          : reporterId as String,
      targetUserId:
          targetUserId == const $CopyWithPlaceholder() || targetUserId == null
          ? _value.targetUserId
          // ignore: cast_nullable_to_non_nullable
          : targetUserId as String,
      category: category == const $CopyWithPlaceholder() || category == null
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as ReportCategory,
      description:
          description == const $CopyWithPlaceholder() || description == null
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String,
      evidenceUrl: evidenceUrl == const $CopyWithPlaceholder()
          ? _value.evidenceUrl
          // ignore: cast_nullable_to_non_nullable
          : evidenceUrl as String?,
      status: status == const $CopyWithPlaceholder() || status == null
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
      reportedAt:
          reportedAt == const $CopyWithPlaceholder() || reportedAt == null
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
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfReport.copyWith(...)` or `instanceOfReport.copyWith.fieldName(...)`.
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
  'category': _$ReportCategoryEnumMap[instance.category]!,
  'description': instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': _$ReportStatusEnumMap[instance.status]!,
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
  'reportedAt': instance.reportedAt.toIso8601String(),
  'resolvedAt': ?instance.resolvedAt?.toIso8601String(),
};

const _$ReportCategoryEnumMap = {
  ReportCategory.BEHAVIOR: 'BEHAVIOR',
  ReportCategory.SAFETY: 'SAFETY',
  ReportCategory.FRAUD: 'FRAUD',
  ReportCategory.OTHER: 'OTHER',
};

const _$ReportStatusEnumMap = {
  ReportStatus.PENDING: 'PENDING',
  ReportStatus.INVESTIGATING: 'INVESTIGATING',
  ReportStatus.RESOLVED: 'RESOLVED',
  ReportStatus.DISMISSED: 'DISMISSED',
};
