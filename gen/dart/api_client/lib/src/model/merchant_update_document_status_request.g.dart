// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_update_document_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantUpdateDocumentStatusRequestCWProxy {
  MerchantUpdateDocumentStatusRequest document(
    MerchantUpdateDocumentStatusRequestDocumentEnum document,
  );

  MerchantUpdateDocumentStatusRequest status(
    MerchantUpdateDocumentStatusRequestStatusEnum status,
  );

  MerchantUpdateDocumentStatusRequest reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantUpdateDocumentStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantUpdateDocumentStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantUpdateDocumentStatusRequest call({
    MerchantUpdateDocumentStatusRequestDocumentEnum document,
    MerchantUpdateDocumentStatusRequestStatusEnum status,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantUpdateDocumentStatusRequest.copyWith(...)` or call `instanceOfMerchantUpdateDocumentStatusRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantUpdateDocumentStatusRequestCWProxyImpl
    implements _$MerchantUpdateDocumentStatusRequestCWProxy {
  const _$MerchantUpdateDocumentStatusRequestCWProxyImpl(this._value);

  final MerchantUpdateDocumentStatusRequest _value;

  @override
  MerchantUpdateDocumentStatusRequest document(
    MerchantUpdateDocumentStatusRequestDocumentEnum document,
  ) => call(document: document);

  @override
  MerchantUpdateDocumentStatusRequest status(
    MerchantUpdateDocumentStatusRequestStatusEnum status,
  ) => call(status: status);

  @override
  MerchantUpdateDocumentStatusRequest reason(String? reason) =>
      call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantUpdateDocumentStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantUpdateDocumentStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantUpdateDocumentStatusRequest call({
    Object? document = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return MerchantUpdateDocumentStatusRequest(
      document: document == const $CopyWithPlaceholder() || document == null
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as MerchantUpdateDocumentStatusRequestDocumentEnum,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as MerchantUpdateDocumentStatusRequestStatusEnum,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $MerchantUpdateDocumentStatusRequestCopyWith
    on MerchantUpdateDocumentStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantUpdateDocumentStatusRequest.copyWith(...)` or `instanceOfMerchantUpdateDocumentStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantUpdateDocumentStatusRequestCWProxy get copyWith =>
      _$MerchantUpdateDocumentStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantUpdateDocumentStatusRequest
_$MerchantUpdateDocumentStatusRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantUpdateDocumentStatusRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['document', 'status']);
      final val = MerchantUpdateDocumentStatusRequest(
        document: $checkedConvert(
          'document',
          (v) => $enumDecode(
            _$MerchantUpdateDocumentStatusRequestDocumentEnumEnumMap,
            v,
          ),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(
            _$MerchantUpdateDocumentStatusRequestStatusEnumEnumMap,
            v,
          ),
        ),
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$MerchantUpdateDocumentStatusRequestToJson(
  MerchantUpdateDocumentStatusRequest instance,
) => <String, dynamic>{
  'document':
      _$MerchantUpdateDocumentStatusRequestDocumentEnumEnumMap[instance
          .document]!,
  'status':
      _$MerchantUpdateDocumentStatusRequestStatusEnumEnumMap[instance.status]!,
  'reason': ?instance.reason,
};

const _$MerchantUpdateDocumentStatusRequestDocumentEnumEnumMap = {
  MerchantUpdateDocumentStatusRequestDocumentEnum.businessDocument:
      'businessDocument',
};

const _$MerchantUpdateDocumentStatusRequestStatusEnumEnumMap = {
  MerchantUpdateDocumentStatusRequestStatusEnum.APPROVED: 'APPROVED',
  MerchantUpdateDocumentStatusRequestStatusEnum.REJECTED: 'REJECTED',
};
