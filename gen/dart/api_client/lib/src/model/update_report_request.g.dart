// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_report_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateReportRequestCWProxy {
  UpdateReportRequest orderId(String? orderId);

  UpdateReportRequest reporterId(String? reporterId);

  UpdateReportRequest targetUserId(String? targetUserId);

  UpdateReportRequest category(UpdateReportRequestCategoryEnum? category);

  UpdateReportRequest description(String? description);

  UpdateReportRequest evidenceUrl(String? evidenceUrl);

  UpdateReportRequest status(UpdateReportRequestStatusEnum? status);

  UpdateReportRequest handledById(String? handledById);

  UpdateReportRequest resolution(String? resolution);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReportRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReportRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReportRequest call({
    String? orderId,
    String? reporterId,
    String? targetUserId,
    UpdateReportRequestCategoryEnum? category,
    String? description,
    String? evidenceUrl,
    UpdateReportRequestStatusEnum? status,
    String? handledById,
    String? resolution,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateReportRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateReportRequest.copyWith.fieldName(...)`
class _$UpdateReportRequestCWProxyImpl implements _$UpdateReportRequestCWProxy {
  const _$UpdateReportRequestCWProxyImpl(this._value);

  final UpdateReportRequest _value;

  @override
  UpdateReportRequest orderId(String? orderId) => this(orderId: orderId);

  @override
  UpdateReportRequest reporterId(String? reporterId) =>
      this(reporterId: reporterId);

  @override
  UpdateReportRequest targetUserId(String? targetUserId) =>
      this(targetUserId: targetUserId);

  @override
  UpdateReportRequest category(UpdateReportRequestCategoryEnum? category) =>
      this(category: category);

  @override
  UpdateReportRequest description(String? description) =>
      this(description: description);

  @override
  UpdateReportRequest evidenceUrl(String? evidenceUrl) =>
      this(evidenceUrl: evidenceUrl);

  @override
  UpdateReportRequest status(UpdateReportRequestStatusEnum? status) =>
      this(status: status);

  @override
  UpdateReportRequest handledById(String? handledById) =>
      this(handledById: handledById);

  @override
  UpdateReportRequest resolution(String? resolution) =>
      this(resolution: resolution);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateReportRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateReportRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateReportRequest call({
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
    return UpdateReportRequest(
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
          : category as UpdateReportRequestCategoryEnum?,
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
          : status as UpdateReportRequestStatusEnum?,
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

extension $UpdateReportRequestCopyWith on UpdateReportRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateReportRequest.copyWith(...)` or like so:`instanceOfUpdateReportRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateReportRequestCWProxy get copyWith =>
      _$UpdateReportRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReportRequest _$UpdateReportRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateReportRequest', json, ($checkedConvert) {
      final val = UpdateReportRequest(
        orderId: $checkedConvert('orderId', (v) => v as String?),
        reporterId: $checkedConvert('reporterId', (v) => v as String?),
        targetUserId: $checkedConvert('targetUserId', (v) => v as String?),
        category: $checkedConvert(
          'category',
          (v) =>
              $enumDecodeNullable(_$UpdateReportRequestCategoryEnumEnumMap, v),
        ),
        description: $checkedConvert('description', (v) => v as String?),
        evidenceUrl: $checkedConvert('evidenceUrl', (v) => v as String?),
        status: $checkedConvert(
          'status',
          (v) => $enumDecodeNullable(_$UpdateReportRequestStatusEnumEnumMap, v),
        ),
        handledById: $checkedConvert('handledById', (v) => v as String?),
        resolution: $checkedConvert('resolution', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UpdateReportRequestToJson(
  UpdateReportRequest instance,
) => <String, dynamic>{
  'orderId': ?instance.orderId,
  'reporterId': ?instance.reporterId,
  'targetUserId': ?instance.targetUserId,
  'category': ?_$UpdateReportRequestCategoryEnumEnumMap[instance.category],
  'description': ?instance.description,
  'evidenceUrl': ?instance.evidenceUrl,
  'status': ?_$UpdateReportRequestStatusEnumEnumMap[instance.status],
  'handledById': ?instance.handledById,
  'resolution': ?instance.resolution,
};

const _$UpdateReportRequestCategoryEnumEnumMap = {
  UpdateReportRequestCategoryEnum.behavior: 'behavior',
  UpdateReportRequestCategoryEnum.safety: 'safety',
  UpdateReportRequestCategoryEnum.fraud: 'fraud',
  UpdateReportRequestCategoryEnum.other: 'other',
};

const _$UpdateReportRequestStatusEnumEnumMap = {
  UpdateReportRequestStatusEnum.pending: 'pending',
  UpdateReportRequestStatusEnum.investigating: 'investigating',
  UpdateReportRequestStatusEnum.resolved: 'resolved',
  UpdateReportRequestStatusEnum.dismissed: 'dismissed',
};
