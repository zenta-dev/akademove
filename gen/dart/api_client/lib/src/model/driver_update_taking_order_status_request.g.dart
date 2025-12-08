// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_taking_order_status_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverUpdateTakingOrderStatusRequestCWProxy {
  DriverUpdateTakingOrderStatusRequest isTakingOrder(bool isTakingOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateTakingOrderStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateTakingOrderStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateTakingOrderStatusRequest call({bool isTakingOrder});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverUpdateTakingOrderStatusRequest.copyWith(...)` or call `instanceOfDriverUpdateTakingOrderStatusRequest.copyWith.fieldName(value)` for a single field.
class _$DriverUpdateTakingOrderStatusRequestCWProxyImpl
    implements _$DriverUpdateTakingOrderStatusRequestCWProxy {
  const _$DriverUpdateTakingOrderStatusRequestCWProxyImpl(this._value);

  final DriverUpdateTakingOrderStatusRequest _value;

  @override
  DriverUpdateTakingOrderStatusRequest isTakingOrder(bool isTakingOrder) =>
      call(isTakingOrder: isTakingOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverUpdateTakingOrderStatusRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverUpdateTakingOrderStatusRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverUpdateTakingOrderStatusRequest call({
    Object? isTakingOrder = const $CopyWithPlaceholder(),
  }) {
    return DriverUpdateTakingOrderStatusRequest(
      isTakingOrder:
          isTakingOrder == const $CopyWithPlaceholder() || isTakingOrder == null
          ? _value.isTakingOrder
          // ignore: cast_nullable_to_non_nullable
          : isTakingOrder as bool,
    );
  }
}

extension $DriverUpdateTakingOrderStatusRequestCopyWith
    on DriverUpdateTakingOrderStatusRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverUpdateTakingOrderStatusRequest.copyWith(...)` or `instanceOfDriverUpdateTakingOrderStatusRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverUpdateTakingOrderStatusRequestCWProxy get copyWith =>
      _$DriverUpdateTakingOrderStatusRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverUpdateTakingOrderStatusRequest
_$DriverUpdateTakingOrderStatusRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverUpdateTakingOrderStatusRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['isTakingOrder']);
      final val = DriverUpdateTakingOrderStatusRequest(
        isTakingOrder: $checkedConvert('isTakingOrder', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$DriverUpdateTakingOrderStatusRequestToJson(
  DriverUpdateTakingOrderStatusRequest instance,
) => <String, dynamic>{'isTakingOrder': instance.isTakingOrder};
