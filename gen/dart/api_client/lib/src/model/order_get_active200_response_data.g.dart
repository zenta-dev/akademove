// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_get_active200_response_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderGetActive200ResponseDataCWProxy {
  OrderGetActive200ResponseData order(Order? order);

  OrderGetActive200ResponseData payment(Payment? payment);

  OrderGetActive200ResponseData transaction(Transaction? transaction);

  OrderGetActive200ResponseData driver(Driver? driver);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetActive200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetActive200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetActive200ResponseData call({
    Order? order,
    Payment? payment,
    Transaction? transaction,
    Driver? driver,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderGetActive200ResponseData.copyWith(...)` or call `instanceOfOrderGetActive200ResponseData.copyWith.fieldName(value)` for a single field.
class _$OrderGetActive200ResponseDataCWProxyImpl
    implements _$OrderGetActive200ResponseDataCWProxy {
  const _$OrderGetActive200ResponseDataCWProxyImpl(this._value);

  final OrderGetActive200ResponseData _value;

  @override
  OrderGetActive200ResponseData order(Order? order) => call(order: order);

  @override
  OrderGetActive200ResponseData payment(Payment? payment) =>
      call(payment: payment);

  @override
  OrderGetActive200ResponseData transaction(Transaction? transaction) =>
      call(transaction: transaction);

  @override
  OrderGetActive200ResponseData driver(Driver? driver) => call(driver: driver);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderGetActive200ResponseData(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderGetActive200ResponseData(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderGetActive200ResponseData call({
    Object? order = const $CopyWithPlaceholder(),
    Object? payment = const $CopyWithPlaceholder(),
    Object? transaction = const $CopyWithPlaceholder(),
    Object? driver = const $CopyWithPlaceholder(),
  }) {
    return OrderGetActive200ResponseData(
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order?,
      payment: payment == const $CopyWithPlaceholder()
          ? _value.payment
          // ignore: cast_nullable_to_non_nullable
          : payment as Payment?,
      transaction: transaction == const $CopyWithPlaceholder()
          ? _value.transaction
          // ignore: cast_nullable_to_non_nullable
          : transaction as Transaction?,
      driver: driver == const $CopyWithPlaceholder()
          ? _value.driver
          // ignore: cast_nullable_to_non_nullable
          : driver as Driver?,
    );
  }
}

extension $OrderGetActive200ResponseDataCopyWith
    on OrderGetActive200ResponseData {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderGetActive200ResponseData.copyWith(...)` or `instanceOfOrderGetActive200ResponseData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderGetActive200ResponseDataCWProxy get copyWith =>
      _$OrderGetActive200ResponseDataCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGetActive200ResponseData _$OrderGetActive200ResponseDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderGetActive200ResponseData', json, ($checkedConvert) {
  final val = OrderGetActive200ResponseData(
    order: $checkedConvert(
      'order',
      (v) => v == null ? null : Order.fromJson(v as Map<String, dynamic>),
    ),
    payment: $checkedConvert(
      'payment',
      (v) => v == null ? null : Payment.fromJson(v as Map<String, dynamic>),
    ),
    transaction: $checkedConvert(
      'transaction',
      (v) => v == null ? null : Transaction.fromJson(v as Map<String, dynamic>),
    ),
    driver: $checkedConvert(
      'driver',
      (v) => v == null ? null : Driver.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$OrderGetActive200ResponseDataToJson(
  OrderGetActive200ResponseData instance,
) => <String, dynamic>{
  'order': ?instance.order?.toJson(),
  'payment': ?instance.payment?.toJson(),
  'transaction': ?instance.transaction?.toJson(),
  'driver': ?instance.driver?.toJson(),
};
