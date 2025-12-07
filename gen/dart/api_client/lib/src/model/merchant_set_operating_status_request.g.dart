// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_set_operating_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantSetOperatingStatusRequestCWProxy {
  MerchantSetOperatingStatusRequest operatingStatus(
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOperatingStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOperatingStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOperatingStatusRequest call({
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantSetOperatingStatusRequest.copyWith(...)` or call `instanceOfMerchantSetOperatingStatusRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantSetOperatingStatusRequestCWProxyImpl
    implements _$MerchantSetOperatingStatusRequestCWProxy {
  const _$MerchantSetOperatingStatusRequestCWProxyImpl(this._value);

  final MerchantSetOperatingStatusRequest _value;

  @override
  MerchantSetOperatingStatusRequest operatingStatus(
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  ) => call(operatingStatus: operatingStatus);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOperatingStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOperatingStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOperatingStatusRequest call({
    Object? operatingStatus = const $CopyWithPlaceholder(),
  }) {
    return MerchantSetOperatingStatusRequest(
      operatingStatus:
          operatingStatus == const $CopyWithPlaceholder() ||
              operatingStatus == null
          ? _value.operatingStatus
          // ignore: cast_nullable_to_non_nullable
          : operatingStatus
                as MerchantSetOperatingStatusRequestOperatingStatusEnum,
    );
  }
}

extension $MerchantSetOperatingStatusRequestCopyWith
    on MerchantSetOperatingStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantSetOperatingStatusRequest.copyWith(...)` or `instanceOfMerchantSetOperatingStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantSetOperatingStatusRequestCWProxy get copyWith =>
      _$MerchantSetOperatingStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSetOperatingStatusRequest _$MerchantSetOperatingStatusRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantSetOperatingStatusRequest', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['operatingStatus']);
  final val = MerchantSetOperatingStatusRequest(
    operatingStatus: $checkedConvert(
      'operatingStatus',
      (v) => $enumDecode(
        _$MerchantSetOperatingStatusRequestOperatingStatusEnumEnumMap,
        v,
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$MerchantSetOperatingStatusRequestToJson(
  MerchantSetOperatingStatusRequest instance,
) => <String, dynamic>{
  'operatingStatus':
      _$MerchantSetOperatingStatusRequestOperatingStatusEnumEnumMap[instance
          .operatingStatus]!,
};

const _$MerchantSetOperatingStatusRequestOperatingStatusEnumEnumMap = {
  MerchantSetOperatingStatusRequestOperatingStatusEnum.OPEN: 'OPEN',
  MerchantSetOperatingStatusRequestOperatingStatusEnum.CLOSED: 'CLOSED',
  MerchantSetOperatingStatusRequestOperatingStatusEnum.BREAK: 'BREAK',
  MerchantSetOperatingStatusRequestOperatingStatusEnum.MAINTENANCE:
      'MAINTENANCE',
};
