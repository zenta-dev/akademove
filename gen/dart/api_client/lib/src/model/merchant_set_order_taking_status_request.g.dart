// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_set_order_taking_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantSetOrderTakingStatusRequestCWProxy {
  MerchantSetOrderTakingStatusRequest isTakingOrders(bool isTakingOrders);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOrderTakingStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOrderTakingStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOrderTakingStatusRequest call({bool isTakingOrders});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantSetOrderTakingStatusRequest.copyWith(...)` or call `instanceOfMerchantSetOrderTakingStatusRequest.copyWith.fieldName(value)` for a single field.
class _$MerchantSetOrderTakingStatusRequestCWProxyImpl
    implements _$MerchantSetOrderTakingStatusRequestCWProxy {
  const _$MerchantSetOrderTakingStatusRequestCWProxyImpl(this._value);

  final MerchantSetOrderTakingStatusRequest _value;

  @override
  MerchantSetOrderTakingStatusRequest isTakingOrders(bool isTakingOrders) =>
      call(isTakingOrders: isTakingOrders);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantSetOrderTakingStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantSetOrderTakingStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantSetOrderTakingStatusRequest call({
    Object? isTakingOrders = const $CopyWithPlaceholder(),
  }) {
    return MerchantSetOrderTakingStatusRequest(
      isTakingOrders:
          isTakingOrders == const $CopyWithPlaceholder() ||
              isTakingOrders == null
          ? _value.isTakingOrders
          // ignore: cast_nullable_to_non_nullable
          : isTakingOrders as bool,
    );
  }
}

extension $MerchantSetOrderTakingStatusRequestCopyWith
    on MerchantSetOrderTakingStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantSetOrderTakingStatusRequest.copyWith(...)` or `instanceOfMerchantSetOrderTakingStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantSetOrderTakingStatusRequestCWProxy get copyWith =>
      _$MerchantSetOrderTakingStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantSetOrderTakingStatusRequest
_$MerchantSetOrderTakingStatusRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantSetOrderTakingStatusRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['isTakingOrders']);
      final val = MerchantSetOrderTakingStatusRequest(
        isTakingOrders: $checkedConvert('isTakingOrders', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$MerchantSetOrderTakingStatusRequestToJson(
  MerchantSetOrderTakingStatusRequest instance,
) => <String, dynamic>{'isTakingOrders': instance.isTakingOrders};
