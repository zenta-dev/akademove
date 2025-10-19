// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_report_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertReportRequestCWProxy {
  InsertReportRequest orderId(String? orderId);

  InsertReportRequest reporterId(String reporterId);

  InsertReportRequest targetUserId(String targetUserId);

  InsertReportRequest category(InsertReportRequestCategoryEnum category);

  InsertReportRequest description(String description);

  InsertReportRequest evidenceUrl(String? evidenceUrl);

  InsertReportRequest status(InsertReportRequestStatusEnum status);

  InsertReportRequest handledById(String? handledById);

  InsertReportRequest resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReportRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReportRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReportRequest call({
    String? orderId,
    String reporterId,
    String targetUserId,
    InsertReportRequestCategoryEnum category,
    String description,
    String? evidenceUrl,
    InsertReportRequestStatusEnum status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertReportRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertReportRequest.copyWith.fieldName(...)`
class _$InsertReportRequestCWProxyImpl implements _$InsertReportRequestCWProxy {
  const _$InsertReportRequestCWProxyImpl(this._value);

  final InsertReportRequest _value;

  @override
  InsertReportRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  InsertReportRequest reporterId(String reporterId) =>
      this(reporterId: reporterId);

  @override
  InsertReportRequest targetUserId(String targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  InsertReportRequest category(InsertReportRequestCategoryEnum category) =>
      this(category: category);

  @override
  InsertReportRequest description(String description) =>
      this(description: description);

  @override
  InsertReportRequest evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  InsertReportRequest status(InsertReportRequestStatusEnum status) =>
      this(status: status);

  @override
  InsertReportRequest handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  InsertReportRequest resolution(String? resolution) =>
      this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertReportRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertReportRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertReportRequest call({
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
    return InsertReportRequest(
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
          : category as InsertReportRequestCategoryEnum,
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
          : status as InsertReportRequestStatusEnum,
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

extension $InsertReportRequestCopyWith on InsertReportRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsertReportRequest.copyWith(...)` or like so:`instanceOfInsertReportRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertReportRequestCWProxy get copyWith =>
      _$InsertReportRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertReportRequest _$InsertReportRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('InsertReportRequest', json, ($checkedConvert) {
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
      final val = InsertReportRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$InsertReportRequestCategoryEnumEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$InsertReportRequestStatusEnumEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$InsertReportRequestToJson(
  InsertReportRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'reporterId': instance.reporterId,
  'targetUserId': instance.targetUserId,
  'category': _$InsertReportRequestCategoryEnumEnumMap[instance.category]!,
  'description': instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': _$InsertReportRequestStatusEnumEnumMap[instance.status]!,
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
};

const _$InsertReportRequestCategoryEnumEnumMap = {
  InsertReportRequestCategoryEnum.behavior: 'behavior',
  InsertReportRequestCategoryEnum.safety: 'safety',
  InsertReportRequestCategoryEnum.fraud: 'fraud',
  InsertReportRequestCategoryEnum.other: 'other',
};

const _$InsertReportRequestStatusEnumEnumMap = {
  InsertReportRequestStatusEnum.pending: 'pending',
  InsertReportRequestStatusEnum.investigating: 'investigating',
  InsertReportRequestStatusEnum.resolved: 'resolved',
  InsertReportRequestStatusEnum.dismissed: 'dismissed',
};
