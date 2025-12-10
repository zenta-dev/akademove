// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cancel_scheduled_order_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCancelScheduledOrderRequestCWProxy {
  OrderCancelScheduledOrderRequest reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCancelScheduledOrderRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCancelScheduledOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCancelScheduledOrderRequest call({String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCancelScheduledOrderRequest.copyWith(...)` or call `instanceOfOrderCancelScheduledOrderRequest.copyWith.fieldName(value)` for a single field.
class _$OrderCancelScheduledOrderRequestCWProxyImpl
    implements _$OrderCancelScheduledOrderRequestCWProxy {
  const _$OrderCancelScheduledOrderRequestCWProxyImpl(this._value);

  final OrderCancelScheduledOrderRequest _value;

  @override
  OrderCancelScheduledOrderRequest reason(String? reason) =>
      call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCancelScheduledOrderRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCancelScheduledOrderRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCancelScheduledOrderRequest call({
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return OrderCancelScheduledOrderRequest(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderCancelScheduledOrderRequestCopyWith
    on OrderCancelScheduledOrderRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCancelScheduledOrderRequest.copyWith(...)` or `instanceOfOrderCancelScheduledOrderRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCancelScheduledOrderRequestCWProxy get copyWith =>
      _$OrderCancelScheduledOrderRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancelScheduledOrderRequest _$OrderCancelScheduledOrderRequestFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('OrderCancelScheduledOrderRequest', json, ($checkedConvert) {
      final val = OrderCancelScheduledOrderRequest(
        reason: $checkedConvert('reason', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$OrderCancelScheduledOrderRequestToJson(
  OrderCancelScheduledOrderRequest instance,
) => <String, dynamic>{'reason': ?instance.reason};
