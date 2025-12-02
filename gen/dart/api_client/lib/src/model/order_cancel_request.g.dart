// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cancel_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCancelRequestCWProxy {
  OrderCancelRequest reason(String? reason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCancelRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCancelRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCancelRequest call({String? reason});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderCancelRequest.copyWith(...)` or call `instanceOfOrderCancelRequest.copyWith.fieldName(value)` for a single field.
class _$OrderCancelRequestCWProxyImpl implements _$OrderCancelRequestCWProxy {
  const _$OrderCancelRequestCWProxyImpl(this._value);

  final OrderCancelRequest _value;

  @override
  OrderCancelRequest reason(String? reason) => call(reason: reason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderCancelRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderCancelRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderCancelRequest call({Object? reason = const $CopyWithPlaceholder()}) {
    return OrderCancelRequest(
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
    );
  }
}

extension $OrderCancelRequestCopyWith on OrderCancelRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderCancelRequest.copyWith(...)` or `instanceOfOrderCancelRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCancelRequestCWProxy get copyWith => _$OrderCancelRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancelRequest _$OrderCancelRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderCancelRequest', json, ($checkedConvert) {
      final val = OrderCancelRequest(reason: $checkedConvert('reason', (v) => v as String?));
      return val;
    });

Map<String, dynamic> _$OrderCancelRequestToJson(OrderCancelRequest instance) => <String, dynamic>{
  'reason': ?instance.reason,
};
