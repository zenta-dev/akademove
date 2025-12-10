// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_review200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetReview200ResponseDataCWProxy {
  MerchantGetReview200ResponseData id(String? id);

  MerchantGetReview200ResponseData merchantId(String? merchantId);

  MerchantGetReview200ResponseData status(
    MerchantGetReview200ResponseDataStatusEnum status,
  );

  MerchantGetReview200ResponseData businessDocumentStatus(
    MerchantGetReview200ResponseDataBusinessDocumentStatusEnum
    businessDocumentStatus,
  );

  MerchantGetReview200ResponseData businessDocumentReason(
    String? businessDocumentReason,
  );

  MerchantGetReview200ResponseData reviewedBy(String? reviewedBy);

  MerchantGetReview200ResponseData reviewedAt(DateTime? reviewedAt);

  MerchantGetReview200ResponseData reviewNotes(String? reviewNotes);

  MerchantGetReview200ResponseData createdAt(DateTime? createdAt);

  MerchantGetReview200ResponseData updatedAt(DateTime? updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetReview200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetReview200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetReview200ResponseData call({
    String? id,
    String? merchantId,
    MerchantGetReview200ResponseDataStatusEnum status,
    MerchantGetReview200ResponseDataBusinessDocumentStatusEnum
    businessDocumentStatus,
    String? businessDocumentReason,
    String? reviewedBy,
    DateTime? reviewedAt,
    String? reviewNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetReview200ResponseData.copyWith(...)` or call `instanceOfMerchantGetReview200ResponseData.copyWith.fieldName(value)` for a single field.
class _$MerchantGetReview200ResponseDataCWProxyImpl
    implements _$MerchantGetReview200ResponseDataCWProxy {
  const _$MerchantGetReview200ResponseDataCWProxyImpl(this._value);

  final MerchantGetReview200ResponseData _value;

  @override
  MerchantGetReview200ResponseData id(String? id) => call(id: id);

  @override
  MerchantGetReview200ResponseData merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  MerchantGetReview200ResponseData status(
    MerchantGetReview200ResponseDataStatusEnum status,
  ) => call(status: status);

  @override
  MerchantGetReview200ResponseData businessDocumentStatus(
    MerchantGetReview200ResponseDataBusinessDocumentStatusEnum
    businessDocumentStatus,
  ) => call(businessDocumentStatus: businessDocumentStatus);

  @override
  MerchantGetReview200ResponseData businessDocumentReason(
    String? businessDocumentReason,
  ) => call(businessDocumentReason: businessDocumentReason);

  @override
  MerchantGetReview200ResponseData reviewedBy(String? reviewedBy) =>
      call(reviewedBy: reviewedBy);

  @override
  MerchantGetReview200ResponseData reviewedAt(DateTime? reviewedAt) =>
      call(reviewedAt: reviewedAt);

  @override
  MerchantGetReview200ResponseData reviewNotes(String? reviewNotes) =>
      call(reviewNotes: reviewNotes);

  @override
  MerchantGetReview200ResponseData createdAt(DateTime? createdAt) =>
      call(createdAt: createdAt);

  @override
  MerchantGetReview200ResponseData updatedAt(DateTime? updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetReview200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetReview200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetReview200ResponseData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? businessDocumentStatus = const $CopyWithPlaceholder(),
    Object? businessDocumentReason = const $CopyWithPlaceholder(),
    Object? reviewedBy = const $CopyWithPlaceholder(),
    Object? reviewedAt = const $CopyWithPlaceholder(),
    Object? reviewNotes = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetReview200ResponseData(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as MerchantGetReview200ResponseDataStatusEnum,
      businessDocumentStatus:
          businessDocumentStatus == const $CopyWithPlaceholder() ||
              businessDocumentStatus == null
          ? _value.businessDocumentStatus
          // ignore: cast_nullable_to_non_nullable
          : businessDocumentStatus
                as MerchantGetReview200ResponseDataBusinessDocumentStatusEnum,
      businessDocumentReason:
          businessDocumentReason == const $CopyWithPlaceholder()
          ? _value.businessDocumentReason
          // ignore: cast_nullable_to_non_nullable
          : businessDocumentReason as String?,
      reviewedBy: reviewedBy == const $CopyWithPlaceholder()
          ? _value.reviewedBy
          // ignore: cast_nullable_to_non_nullable
          : reviewedBy as String?,
      reviewedAt: reviewedAt == const $CopyWithPlaceholder()
          ? _value.reviewedAt
          // ignore: cast_nullable_to_non_nullable
          : reviewedAt as DateTime?,
      reviewNotes: reviewNotes == const $CopyWithPlaceholder()
          ? _value.reviewNotes
          // ignore: cast_nullable_to_non_nullable
          : reviewNotes as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $MerchantGetReview200ResponseDataCopyWith
    on MerchantGetReview200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetReview200ResponseData.copyWith(...)` or `instanceOfMerchantGetReview200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetReview200ResponseDataCWProxy get copyWith =>
      _$MerchantGetReview200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetReview200ResponseData _$MerchantGetReview200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGetReview200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'merchantId',
      'status',
      'businessDocumentStatus',
      'businessDocumentReason',
      'reviewedBy',
      'reviewedAt',
      'reviewNotes',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = MerchantGetReview200ResponseData(
    id: $checkedConvert('id', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    status: $checkedConvert(
      'status',
      (v) =>
          $enumDecode(_$MerchantGetReview200ResponseDataStatusEnumEnumMap, v),
    ),
    businessDocumentStatus: $checkedConvert(
      'businessDocumentStatus',
      (v) => $enumDecode(
        _$MerchantGetReview200ResponseDataBusinessDocumentStatusEnumEnumMap,
        v,
      ),
    ),
    businessDocumentReason: $checkedConvert(
      'businessDocumentReason',
      (v) => v as String?,
    ),
    reviewedBy: $checkedConvert('reviewedBy', (v) => v as String?),
    reviewedAt: $checkedConvert(
      'reviewedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    reviewNotes: $checkedConvert('reviewNotes', (v) => v as String?),
    createdAt: $checkedConvert(
      'createdAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$MerchantGetReview200ResponseDataToJson(
  MerchantGetReview200ResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'merchantId': instance.merchantId,
  'status':
      _$MerchantGetReview200ResponseDataStatusEnumEnumMap[instance.status]!,
  'businessDocumentStatus':
      _$MerchantGetReview200ResponseDataBusinessDocumentStatusEnumEnumMap[instance
          .businessDocumentStatus]!,
  'businessDocumentReason': instance.businessDocumentReason,
  'reviewedBy': instance.reviewedBy,
  'reviewedAt': instance.reviewedAt?.toIso8601String(),
  'reviewNotes': instance.reviewNotes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$MerchantGetReview200ResponseDataStatusEnumEnumMap = {
  MerchantGetReview200ResponseDataStatusEnum.PENDING: 'PENDING',
  MerchantGetReview200ResponseDataStatusEnum.APPROVED: 'APPROVED',
  MerchantGetReview200ResponseDataStatusEnum.REJECTED: 'REJECTED',
};

const _$MerchantGetReview200ResponseDataBusinessDocumentStatusEnumEnumMap = {
  MerchantGetReview200ResponseDataBusinessDocumentStatusEnum.PENDING: 'PENDING',
  MerchantGetReview200ResponseDataBusinessDocumentStatusEnum.APPROVED:
      'APPROVED',
  MerchantGetReview200ResponseDataBusinessDocumentStatusEnum.REJECTED:
      'REJECTED',
};
