// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_get_availability_status200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantGetAvailabilityStatus200ResponseDataCWProxy {
  MerchantGetAvailabilityStatus200ResponseData id(String? id);

  MerchantGetAvailabilityStatus200ResponseData isOnline(bool isOnline);

  MerchantGetAvailabilityStatus200ResponseData isTakingOrders(
    bool isTakingOrders,
  );

  MerchantGetAvailabilityStatus200ResponseData operatingStatus(
    MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum
    operatingStatus,
  );

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetAvailabilityStatus200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetAvailabilityStatus200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetAvailabilityStatus200ResponseData call({
    String? id,
    bool isOnline,
    bool isTakingOrders,
    MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum
    operatingStatus,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantGetAvailabilityStatus200ResponseData.copyWith(...)` or call `instanceOfMerchantGetAvailabilityStatus200ResponseData.copyWith.fieldName(value)` for a single field.
class _$MerchantGetAvailabilityStatus200ResponseDataCWProxyImpl
    implements _$MerchantGetAvailabilityStatus200ResponseDataCWProxy {
  const _$MerchantGetAvailabilityStatus200ResponseDataCWProxyImpl(this._value);

  final MerchantGetAvailabilityStatus200ResponseData _value;

  @override
  MerchantGetAvailabilityStatus200ResponseData id(String? id) => call(id: id);

  @override
  MerchantGetAvailabilityStatus200ResponseData isOnline(bool isOnline) =>
      call(isOnline: isOnline);

  @override
  MerchantGetAvailabilityStatus200ResponseData isTakingOrders(
    bool isTakingOrders,
  ) => call(isTakingOrders: isTakingOrders);

  @override
  MerchantGetAvailabilityStatus200ResponseData operatingStatus(
    MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum
    operatingStatus,
  ) => call(operatingStatus: operatingStatus);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantGetAvailabilityStatus200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantGetAvailabilityStatus200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantGetAvailabilityStatus200ResponseData call({
    Object? id = const $CopyWithPlaceholder(),
    Object? isOnline = const $CopyWithPlaceholder(),
    Object? isTakingOrders = const $CopyWithPlaceholder(),
    Object? operatingStatus = const $CopyWithPlaceholder(),
  }) {
    return MerchantGetAvailabilityStatus200ResponseData(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      isOnline: isOnline == const $CopyWithPlaceholder() || isOnline == null
          ? _value.isOnline
          // ignore: cast_nullable_to_non_nullable
          : isOnline as bool,
      isTakingOrders:
          isTakingOrders == const $CopyWithPlaceholder() ||
              isTakingOrders == null
          ? _value.isTakingOrders
          // ignore: cast_nullable_to_non_nullable
          : isTakingOrders as bool,
      operatingStatus:
          operatingStatus == const $CopyWithPlaceholder() ||
              operatingStatus == null
          ? _value.operatingStatus
          // ignore: cast_nullable_to_non_nullable
          : operatingStatus
                as MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum,
    );
  }
}

extension $MerchantGetAvailabilityStatus200ResponseDataCopyWith
    on MerchantGetAvailabilityStatus200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantGetAvailabilityStatus200ResponseData.copyWith(...)` or `instanceOfMerchantGetAvailabilityStatus200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantGetAvailabilityStatus200ResponseDataCWProxy get copyWith =>
      _$MerchantGetAvailabilityStatus200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantGetAvailabilityStatus200ResponseData
_$MerchantGetAvailabilityStatus200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantGetAvailabilityStatus200ResponseData', json, (
  $checkedConvert,
) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'isOnline', 'isTakingOrders', 'operatingStatus'],
  );
  final val = MerchantGetAvailabilityStatus200ResponseData(
    id: $checkedConvert('id', (v) => v as String?),
    isOnline: $checkedConvert('isOnline', (v) => v as bool),
    isTakingOrders: $checkedConvert('isTakingOrders', (v) => v as bool),
    operatingStatus: $checkedConvert(
      'operatingStatus',
      (v) => $enumDecode(
        _$MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnumEnumMap,
        v,
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$MerchantGetAvailabilityStatus200ResponseDataToJson(
  MerchantGetAvailabilityStatus200ResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'isOnline': instance.isOnline,
  'isTakingOrders': instance.isTakingOrders,
  'operatingStatus':
      _$MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnumEnumMap[instance
          .operatingStatus]!,
};

const _$MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnumEnumMap =
    {
      MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum.OPEN:
          'OPEN',
      MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum.CLOSED:
          'CLOSED',
      MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum.BREAK:
          'BREAK',
      MerchantGetAvailabilityStatus200ResponseDataOperatingStatusEnum
              .MAINTENANCE:
          'MAINTENANCE',
    };
