// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantEnvelopePayloadCWProxy {
  MerchantEnvelopePayload order(Order? order);

  MerchantEnvelopePayload orderId(String? orderId);

  MerchantEnvelopePayload merchantId(String? merchantId);

  MerchantEnvelopePayload itemCount(num? itemCount);

  MerchantEnvelopePayload totalAmount(num? totalAmount);

  MerchantEnvelopePayload cancelReason(String? cancelReason);

  MerchantEnvelopePayload driverName(String? driverName);

  MerchantEnvelopePayload newStatus(String? newStatus);

  MerchantEnvelopePayload syncRequest(
    MerchantEnvelopePayloadSyncRequest? syncRequest,
  );

  MerchantEnvelopePayload orders(List<Order>? orders);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelopePayload call({
    Order? order,
    String? orderId,
    String? merchantId,
    num? itemCount,
    num? totalAmount,
    String? cancelReason,
    String? driverName,
    String? newStatus,
    MerchantEnvelopePayloadSyncRequest? syncRequest,
    List<Order>? orders,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantEnvelopePayload.copyWith(...)` or call `instanceOfMerchantEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$MerchantEnvelopePayloadCWProxyImpl
    implements _$MerchantEnvelopePayloadCWProxy {
  const _$MerchantEnvelopePayloadCWProxyImpl(this._value);

  final MerchantEnvelopePayload _value;

  @override
  MerchantEnvelopePayload order(Order? order) => call(order: order);

  @override
  MerchantEnvelopePayload orderId(String? orderId) => call(orderId: orderId);

  @override
  MerchantEnvelopePayload merchantId(String? merchantId) =>
      call(merchantId: merchantId);

  @override
  MerchantEnvelopePayload itemCount(num? itemCount) =>
      call(itemCount: itemCount);

  @override
  MerchantEnvelopePayload totalAmount(num? totalAmount) =>
      call(totalAmount: totalAmount);

  @override
  MerchantEnvelopePayload cancelReason(String? cancelReason) =>
      call(cancelReason: cancelReason);

  @override
  MerchantEnvelopePayload driverName(String? driverName) =>
      call(driverName: driverName);

  @override
  MerchantEnvelopePayload newStatus(String? newStatus) =>
      call(newStatus: newStatus);

  @override
  MerchantEnvelopePayload syncRequest(
    MerchantEnvelopePayloadSyncRequest? syncRequest,
  ) => call(syncRequest: syncRequest);

  @override
  MerchantEnvelopePayload orders(List<Order>? orders) => call(orders: orders);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelopePayload call({
    Object? order = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? merchantId = const $CopyWithPlaceholder(),
    Object? itemCount = const $CopyWithPlaceholder(),
    Object? totalAmount = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
    Object? driverName = const $CopyWithPlaceholder(),
    Object? newStatus = const $CopyWithPlaceholder(),
    Object? syncRequest = const $CopyWithPlaceholder(),
    Object? orders = const $CopyWithPlaceholder(),
  }) {
    return MerchantEnvelopePayload(
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as Order?,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String?,
      merchantId: merchantId == const $CopyWithPlaceholder()
          ? _value.merchantId
          // ignore: cast_nullable_to_non_nullable
          : merchantId as String?,
      itemCount: itemCount == const $CopyWithPlaceholder()
          ? _value.itemCount
          // ignore: cast_nullable_to_non_nullable
          : itemCount as num?,
      totalAmount: totalAmount == const $CopyWithPlaceholder()
          ? _value.totalAmount
          // ignore: cast_nullable_to_non_nullable
          : totalAmount as num?,
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
      driverName: driverName == const $CopyWithPlaceholder()
          ? _value.driverName
          // ignore: cast_nullable_to_non_nullable
          : driverName as String?,
      newStatus: newStatus == const $CopyWithPlaceholder()
          ? _value.newStatus
          // ignore: cast_nullable_to_non_nullable
          : newStatus as String?,
      syncRequest: syncRequest == const $CopyWithPlaceholder()
          ? _value.syncRequest
          // ignore: cast_nullable_to_non_nullable
          : syncRequest as MerchantEnvelopePayloadSyncRequest?,
      orders: orders == const $CopyWithPlaceholder()
          ? _value.orders
          // ignore: cast_nullable_to_non_nullable
          : orders as List<Order>?,
    );
  }
}

extension $MerchantEnvelopePayloadCopyWith on MerchantEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantEnvelopePayload.copyWith(...)` or `instanceOfMerchantEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantEnvelopePayloadCWProxy get copyWith =>
      _$MerchantEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantEnvelopePayload _$MerchantEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('MerchantEnvelopePayload', json, ($checkedConvert) {
  final val = MerchantEnvelopePayload(
    order: $checkedConvert(
      'order',
      (v) => v == null ? null : Order.fromJson(v as Map<String, dynamic>),
    ),
    orderId: $checkedConvert('orderId', (v) => v as String?),
    merchantId: $checkedConvert('merchantId', (v) => v as String?),
    itemCount: $checkedConvert('itemCount', (v) => v as num?),
    totalAmount: $checkedConvert('totalAmount', (v) => v as num?),
    cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
    driverName: $checkedConvert('driverName', (v) => v as String?),
    newStatus: $checkedConvert('newStatus', (v) => v as String?),
    syncRequest: $checkedConvert(
      'syncRequest',
      (v) => v == null
          ? null
          : MerchantEnvelopePayloadSyncRequest.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
    orders: $checkedConvert(
      'orders',
      (v) => (v as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$MerchantEnvelopePayloadToJson(
  MerchantEnvelopePayload instance,
) => <String, dynamic>{
  'order': ?instance.order?.toJson(),
  'orderId': ?instance.orderId,
  'merchantId': ?instance.merchantId,
  'itemCount': ?instance.itemCount,
  'totalAmount': ?instance.totalAmount,
  'cancelReason': ?instance.cancelReason,
  'driverName': ?instance.driverName,
  'newStatus': ?instance.newStatus,
  'syncRequest': ?instance.syncRequest?.toJson(),
  'orders': ?instance.orders?.map((e) => e.toJson()).toList(),
};
