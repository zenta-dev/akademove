// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadCWProxy {
  OrderEnvelopePayload detail(OrderEnvelopePayloadDetail? detail);

  OrderEnvelopePayload driverAccept(Driver? driverAccept);

  OrderEnvelopePayload driverUpdateLocation(
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
  );

  OrderEnvelopePayload done(OrderEnvelopePayloadDone? done);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayload(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayload(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayload call({
    OrderEnvelopePayloadDetail? detail,
    Driver? driverAccept,
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
    OrderEnvelopePayloadDone? done,
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
  OrderEnvelopePayload driverAccept(Driver? driverAccept) =>
      call(driverAccept: driverAccept);

  @override
  OrderEnvelopePayload driverUpdateLocation(
    OrderEnvelopePayloadDriverUpdateLocation? driverUpdateLocation,
  ) => call(driverUpdateLocation: driverUpdateLocation);

  @override
  OrderEnvelopePayload done(OrderEnvelopePayloadDone? done) => call(done: done);

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
    Object? driverAccept = const $CopyWithPlaceholder(),
    Object? driverUpdateLocation = const $CopyWithPlaceholder(),
    Object? done = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayload(
      detail: detail == const $CopyWithPlaceholder()
          ? _value.detail
          // ignore: cast_nullable_to_non_nullable
          : detail as OrderEnvelopePayloadDetail?,
      driverAccept: driverAccept == const $CopyWithPlaceholder()
          ? _value.driverAccept
          // ignore: cast_nullable_to_non_nullable
          : driverAccept as Driver?,
      driverUpdateLocation: driverUpdateLocation == const $CopyWithPlaceholder()
          ? _value.driverUpdateLocation
          // ignore: cast_nullable_to_non_nullable
          : driverUpdateLocation as OrderEnvelopePayloadDriverUpdateLocation?,
      done: done == const $CopyWithPlaceholder()
          ? _value.done
          // ignore: cast_nullable_to_non_nullable
          : done as OrderEnvelopePayloadDone?,
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
    driverAccept: $checkedConvert(
      'driverAccept',
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
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadToJson(
  OrderEnvelopePayload instance,
) => <String, dynamic>{
  'detail': ?instance.detail?.toJson(),
  'driverAccept': ?instance.driverAccept?.toJson(),
  'driverUpdateLocation': ?instance.driverUpdateLocation?.toJson(),
  'done': ?instance.done?.toJson(),
};
