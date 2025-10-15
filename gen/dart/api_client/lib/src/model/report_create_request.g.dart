// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_create_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportCreateRequestCWProxy {
  ReportCreateRequest orderId(String? orderId);

  ReportCreateRequest reporterId(String reporterId);

  ReportCreateRequest targetUserId(String targetUserId);

  ReportCreateRequest category(ReportCreateRequestCategoryEnum category);

  ReportCreateRequest description(String description);

  ReportCreateRequest evidenceUrl(String? evidenceUrl);

  ReportCreateRequest status(ReportCreateRequestStatusEnum status);

  ReportCreateRequest handledById(String? handledById);

  ReportCreateRequest resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportCreateRequest call({
    String? orderId,
    String reporterId,
    String targetUserId,
    ReportCreateRequestCategoryEnum category,
    String description,
    String? evidenceUrl,
    ReportCreateRequestStatusEnum status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReportCreateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReportCreateRequest.copyWith.fieldName(...)`
class _$ReportCreateRequestCWProxyImpl implements _$ReportCreateRequestCWProxy {
  const _$ReportCreateRequestCWProxyImpl(this._value);

  final ReportCreateRequest _value;

  @override
  ReportCreateRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  ReportCreateRequest reporterId(String reporterId) =>
      this(reporterId: reporterId);

  @override
  ReportCreateRequest targetUserId(String targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  ReportCreateRequest category(ReportCreateRequestCategoryEnum category) =>
      this(category: category);

  @override
  ReportCreateRequest description(String description) =>
      this(description: description);

  @override
  ReportCreateRequest evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  ReportCreateRequest status(ReportCreateRequestStatusEnum status) =>
      this(status: status);

  @override
  ReportCreateRequest handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  ReportCreateRequest resolution(String? resolution) =>
      this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportCreateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportCreateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportCreateRequest call({
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
    return ReportCreateRequest(
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
          : category as ReportCreateRequestCategoryEnum,
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
          : status as ReportCreateRequestStatusEnum,
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

extension $ReportCreateRequestCopyWith on ReportCreateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReportCreateRequest.copyWith(...)` or like so:`instanceOfReportCreateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportCreateRequestCWProxy get copyWith =>
      _$ReportCreateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportCreateRequest _$ReportCreateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportCreateRequest', json, ($checkedConvert) {
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
      final val = ReportCreateRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String),
        category: $checkedConvert(
          'category',
          (v) => $enumDecode(_$ReportCreateRequestCategoryEnumEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ReportCreateRequestStatusEnumEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReportCreateRequestToJson(
  ReportCreateRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'reporterId': instance.reporterId,
  'targetUserId': instance.targetUserId,
  'category': _$ReportCreateRequestCategoryEnumEnumMap[instance.category]!,
  'description': instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': _$ReportCreateRequestStatusEnumEnumMap[instance.status]!,
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
};

const _$ReportCreateRequestCategoryEnumEnumMap = {
  ReportCreateRequestCategoryEnum.behavior: 'behavior',
  ReportCreateRequestCategoryEnum.safety: 'safety',
  ReportCreateRequestCategoryEnum.fraud: 'fraud',
  ReportCreateRequestCategoryEnum.other: 'other',
};

const _$ReportCreateRequestStatusEnumEnumMap = {
  ReportCreateRequestStatusEnum.pending: 'pending',
  ReportCreateRequestStatusEnum.investigating: 'investigating',
  ReportCreateRequestStatusEnum.resolved: 'resolved',
  ReportCreateRequestStatusEnum.dismissed: 'dismissed',
};
