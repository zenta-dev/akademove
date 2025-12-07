// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_document_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateDocumentStatusRequestCWProxy {
  DriverUpdateDocumentStatusRequest document(
    DriverUpdateDocumentStatusRequestDocumentEnum document,
  );

  DriverUpdateDocumentStatusRequest status(
    DriverUpdateDocumentStatusRequestStatusEnum status,
  );

  DriverUpdateDocumentStatusRequest reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateDocumentStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateDocumentStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateDocumentStatusRequest call({
    DriverUpdateDocumentStatusRequestDocumentEnum document,
    DriverUpdateDocumentStatusRequestStatusEnum status,
    String? reason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverUpdateDocumentStatusRequest.copyWith(...)` or call `instanceOfDriverUpdateDocumentStatusRequest.copyWith.fieldName(value)` for a single field.
class _$DriverUpdateDocumentStatusRequestCWProxyImpl
    implements _$DriverUpdateDocumentStatusRequestCWProxy {
  const _$DriverUpdateDocumentStatusRequestCWProxyImpl(this._value);

  final DriverUpdateDocumentStatusRequest _value;

  @override
  DriverUpdateDocumentStatusRequest document(
    DriverUpdateDocumentStatusRequestDocumentEnum document,
  ) => call(document: document);

  @override
  DriverUpdateDocumentStatusRequest status(
    DriverUpdateDocumentStatusRequestStatusEnum status,
  ) => call(status: status);

  @override
  DriverUpdateDocumentStatusRequest reason(String? reason) =>
      call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateDocumentStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateDocumentStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateDocumentStatusRequest call({
    Object? document = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateDocumentStatusRequest(
      document: document == const $CopyWithPlaceholder() || document == null
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as DriverUpdateDocumentStatusRequestDocumentEnum,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DriverUpdateDocumentStatusRequestStatusEnum,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $DriverUpdateDocumentStatusRequestCopyWith
    on DriverUpdateDocumentStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverUpdateDocumentStatusRequest.copyWith(...)` or `instanceOfDriverUpdateDocumentStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateDocumentStatusRequestCWProxy get copyWith =>
      _$DriverUpdateDocumentStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateDocumentStatusRequest _$DriverUpdateDocumentStatusRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverUpdateDocumentStatusRequest', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['document', 'status']);
  final val = DriverUpdateDocumentStatusRequest(
    document: $checkedConvert(
      'document',
      (v) => $enumDecode(
        _$DriverUpdateDocumentStatusRequestDocumentEnumEnumMap,
        v,
      ),
    ),
    status: $checkedConvert(
      'status',
      (v) =>
          $enumDecode(_$DriverUpdateDocumentStatusRequestStatusEnumEnumMap, v),
    ),
    reason: $checkedConvert('reason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DriverUpdateDocumentStatusRequestToJson(
  DriverUpdateDocumentStatusRequest instance,
) => <String, dynamic>{
  'document':
      _$DriverUpdateDocumentStatusRequestDocumentEnumEnumMap[instance
          .document]!,
  'status':
      _$DriverUpdateDocumentStatusRequestStatusEnumEnumMap[instance.status]!,
  'reason': ?instance.reason,
};

const _$DriverUpdateDocumentStatusRequestDocumentEnumEnumMap = {
  DriverUpdateDocumentStatusRequestDocumentEnum.studentCard: 'studentCard',
  DriverUpdateDocumentStatusRequestDocumentEnum.driverLicense: 'driverLicense',
  DriverUpdateDocumentStatusRequestDocumentEnum.vehicleRegistration:
      'vehicleRegistration',
};

const _$DriverUpdateDocumentStatusRequestStatusEnumEnumMap = {
  DriverUpdateDocumentStatusRequestStatusEnum.APPROVED: 'APPROVED',
  DriverUpdateDocumentStatusRequestStatusEnum.REJECTED: 'REJECTED',
};
