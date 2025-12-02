// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadCWProxy {
  OrderEnvelopePayload detail(OrderEnvelopePayloadDetail? detail);

  OrderEnvelopePayload driverAssigned(Driver? driverAssigned);

  OrderEnvelopePayload driverUpdateLocation(
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
  );

  OrderEnvelopePayload done(OrderEnvelopePayloadDone? done);

  OrderEnvelopePayload message(OrderEnvelopePayloadMessage? message);

  OrderEnvelopePayload cancelReason(String? cancelReason);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayload call({
    OrderEnvelopePayloadDetail? detail,
    Driver? driverAssigned,
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
    OrderEnvelopePayloadDone? done,
    OrderEnvelopePayloadMessage? message,
    String? cancelReason,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayload.copyWith(...)` or call `instanceOfOrderEnvelopePayload.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadCWProxyImpl
    implements _$OrderEnvelopePayloadCWProxy {
  const _$OrderEnvelopePayloadCWProxyImpl(this._value);

  final OrderEnvelopePayload _value;

  @override
  OrderEnvelopePayload detail(OrderEnvelopePayloadDetail? detail) =>
      call(detail: detail);

  @override
  OrderEnvelopePayload driverAssigned(Driver? driverAssigned) =>
      call(driverAssigned: driverAssigned);

  @override
  OrderEnvelopePayload driverUpdateLocation(
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
  ) => call(driverUpdateLocation: driverUpdateLocation);

  @override
  OrderEnvelopePayload done(OrderEnvelopePayloadDone? done) => call(done: done);

  @override
  OrderEnvelopePayload message(OrderEnvelopePayloadMessage? message) =>
      call(message: message);

  @override
  OrderEnvelopePayload cancelReason(String? cancelReason) =>
      call(cancelReason: cancelReason);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayload call({
    Object? detail = const $CopyWithPlaceholder(),
    Object? driverAssigned = const $CopyWithPlaceholder(),
    Object? driverUpdateLocation = const $CopyWithPlaceholder(),
    Object? done = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? cancelReason = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayload(
      detail: detail == const $CopyWithPlaceholder()
          ? _value.detail
          // ignore: cast_nullable_to_non_nullable
          : detail as OrderEnvelopePayloadDetail?,
      driverAssigned: driverAssigned == const $CopyWithPlaceholder()
          ? _value.driverAssigned
          // ignore: cast_nullable_to_non_nullable
          : driverAssigned as Driver?,
      driverUpdateLocation: driverUpdateLocation == const $CopyWithPlaceholder()
          ? _value.driverUpdateLocation
          // ignore: cast_nullable_to_non_nullable
          : driverUpdateLocation as OrderEnvelopePayloadDriverUpdateLocation?,
      done: done == const $CopyWithPlaceholder()
          ? _value.done
          // ignore: cast_nullable_to_non_nullable
          : done as OrderEnvelopePayloadDone?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as OrderEnvelopePayloadMessage?,
      cancelReason: cancelReason == const $CopyWithPlaceholder()
          ? _value.cancelReason
          // ignore: cast_nullable_to_non_nullable
          : cancelReason as String?,
    );
  }
}

extension $OrderEnvelopePayloadCopyWith on OrderEnvelopePayload {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayload.copyWith(...)` or `instanceOfOrderEnvelopePayload.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadCWProxy get copyWith =>
      _$OrderEnvelopePayloadCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayload _$OrderEnvelopePayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayload', json, ($checkedConvert) {
  final val = OrderEnvelopePayload(
    detail: $checkedConvert(
      'detail',
      (v) => v == null
          ? null
          : OrderEnvelopePayloadDetail.fromJson(v as Map<String, dynamic>),
    ),
    driverAssigned: $checkedConvert(
      'driverAssigned',
      (v) => v == null ? null : Driver.fromJson(v as Map<String, dynamic>),
    ),
    driverUpdateLocation: $checkedConvert(
      'driverUpdateLocation',
      (v) => v == null
          ? null
          : OrderEnvelopePayloadDriverUpdateLocation.fromJson(
              v as Map<String, dynamic>,
            ),
    ),
    done: $checkedConvert(
      'done',
      (v) => v == null
          ? null
          : OrderEnvelopePayloadDone.fromJson(v as Map<String, dynamic>),
    ),
    message: $checkedConvert(
      'message',
      (v) => v == null
          ? null
          : OrderEnvelopePayloadMessage.fromJson(v as Map<String, dynamic>),
    ),
    cancelReason: $checkedConvert('cancelReason', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadToJson(
  OrderEnvelopePayload instance,
) => <String, dynamic>{
  'detail': ?instance.detail?.toJson(),
  'driverAssigned': ?instance.driverAssigned?.toJson(),
  'driverUpdateLocation': ?instance.driverUpdateLocation?.toJson(),
  'done': ?instance.done?.toJson(),
  'message': ?instance.message?.toJson(),
  'cancelReason': ?instance.cancelReason,
};
