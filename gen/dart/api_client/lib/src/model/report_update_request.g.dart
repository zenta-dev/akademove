// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_update_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReportUpdateRequestCWProxy {
  ReportUpdateRequest orderId(String? orderId);

  ReportUpdateRequest reporterId(String? reporterId);

  ReportUpdateRequest targetUserId(String? targetUserId);

  ReportUpdateRequest category(ReportUpdateRequestCategoryEnum? category);

  ReportUpdateRequest description(String? description);

  ReportUpdateRequest evidenceUrl(String? evidenceUrl);

  ReportUpdateRequest status(ReportUpdateRequestStatusEnum? status);

  ReportUpdateRequest handledById(String? handledById);

  ReportUpdateRequest resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportUpdateRequest call({
    String? orderId,
    String? reporterId,
    String? targetUserId,
    ReportUpdateRequestCategoryEnum? category,
    String? description,
    String? evidenceUrl,
    ReportUpdateRequestStatusEnum? status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReportUpdateRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReportUpdateRequest.copyWith.fieldName(...)`
class _$ReportUpdateRequestCWProxyImpl implements _$ReportUpdateRequestCWProxy {
  const _$ReportUpdateRequestCWProxyImpl(this._value);

  final ReportUpdateRequest _value;

  @override
  ReportUpdateRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  ReportUpdateRequest reporterId(String? reporterId) =>
      this(reporterId: reporterId);

  @override
  ReportUpdateRequest targetUserId(String? targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  ReportUpdateRequest category(ReportUpdateRequestCategoryEnum? category) =>
      this(category: category);

  @override
  ReportUpdateRequest description(String? description) =>
      this(description: description);

  @override
  ReportUpdateRequest evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  ReportUpdateRequest status(ReportUpdateRequestStatusEnum? status) =>
      this(status: status);

  @override
  ReportUpdateRequest handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  ReportUpdateRequest resolution(String? resolution) =>
      this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReportUpdateRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReportUpdateRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReportUpdateRequest call({
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
    return ReportUpdateRequest(
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
          : category as ReportUpdateRequestCategoryEnum?,
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
          : status as ReportUpdateRequestStatusEnum?,
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

extension $ReportUpdateRequestCopyWith on ReportUpdateRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReportUpdateRequest.copyWith(...)` or like so:`instanceOfReportUpdateRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReportUpdateRequestCWProxy get copyWith =>
      _$ReportUpdateRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportUpdateRequest _$ReportUpdateRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ReportUpdateRequest', json, ($checkedConvert) {
      final val = ReportUpdateRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String?),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) =>
              $enumDecodeNullable(_$ReportUpdateRequestCategoryEnumEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$ReportUpdateRequestStatusEnumEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ReportUpdateRequestToJson(
  ReportUpdateRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'reporterId': ?instance.reporterId,
  'targetUserId': ?instance.targetUserId,
  'category': ?_$ReportUpdateRequestCategoryEnumEnumMap[instance.category],
  'description': ?instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': ?_$ReportUpdateRequestStatusEnumEnumMap[instance.status],
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
};

const _$ReportUpdateRequestCategoryEnumEnumMap = {
  ReportUpdateRequestCategoryEnum.behavior: 'behavior',
  ReportUpdateRequestCategoryEnum.safety: 'safety',
  ReportUpdateRequestCategoryEnum.fraud: 'fraud',
  ReportUpdateRequestCategoryEnum.other: 'other',
};

const _$ReportUpdateRequestStatusEnumEnumMap = {
  ReportUpdateRequestStatusEnum.pending: 'pending',
  ReportUpdateRequestStatusEnum.investigating: 'investigating',
  ReportUpdateRequestStatusEnum.resolved: 'resolved',
  ReportUpdateRequestStatusEnum.dismissed: 'dismissed',
};
