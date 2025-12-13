// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopeCWProxy {
  OrderEnvelope e(OrderEnvelopeEvent? e);

  OrderEnvelope a(OrderEnvelopeAction? a);

  OrderEnvelope tg(EnvelopeTarget? tg);

  OrderEnvelope f(EnvelopeSender f);

  OrderEnvelope t(EnvelopeSender t);

  OrderEnvelope p(OrderEnvelopePayload p);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelope call({
    OrderEnvelopeEvent? e,
    OrderEnvelopeAction? a,
    EnvelopeTarget? tg,
    EnvelopeSender f,
    EnvelopeSender t,
    OrderEnvelopePayload p,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelope.copyWith(...)` or call `instanceOfOrderEnvelope.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopeCWProxyImpl implements _$OrderEnvelopeCWProxy {
  const _$OrderEnvelopeCWProxyImpl(this._value);

  final OrderEnvelope _value;

  @override
  OrderEnvelope e(OrderEnvelopeEvent? e) => call(e: e);

  @override
  OrderEnvelope a(OrderEnvelopeAction? a) => call(a: a);

  @override
  OrderEnvelope tg(EnvelopeTarget? tg) => call(tg: tg);

  @override
  OrderEnvelope f(EnvelopeSender f) => call(f: f);

  @override
  OrderEnvelope t(EnvelopeSender t) => call(t: t);

  @override
  OrderEnvelope p(OrderEnvelopePayload p) => call(p: p);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelope call({
    Object? e = const $CopyWithPlaceholder(),
    Object? a = const $CopyWithPlaceholder(),
    Object? tg = const $CopyWithPlaceholder(),
    Object? f = const $CopyWithPlaceholder(),
    Object? t = const $CopyWithPlaceholder(),
    Object? p = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelope(
      e: e == const $CopyWithPlaceholder()
          ? _value.e
          // ignore: cast_nullable_to_non_nullable
          : e as OrderEnvelopeEvent?,
      a: a == const $CopyWithPlaceholder()
          ? _value.a
          // ignore: cast_nullable_to_non_nullable
          : a as OrderEnvelopeAction?,
      tg: tg == const $CopyWithPlaceholder()
          ? _value.tg
          // ignore: cast_nullable_to_non_nullable
          : tg as EnvelopeTarget?,
      f: f == const $CopyWithPlaceholder() || f == null
          ? _value.f
          // ignore: cast_nullable_to_non_nullable
          : f as EnvelopeSender,
      t: t == const $CopyWithPlaceholder() || t == null
          ? _value.t
          // ignore: cast_nullable_to_non_nullable
          : t as EnvelopeSender,
      p: p == const $CopyWithPlaceholder() || p == null
          ? _value.p
          // ignore: cast_nullable_to_non_nullable
          : p as OrderEnvelopePayload,
    );
  }
}

extension $OrderEnvelopeCopyWith on OrderEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelope.copyWith(...)` or `instanceOfOrderEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopeCWProxy get copyWith => _$OrderEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelope _$OrderEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['f', 't', 'p']);
      final val = OrderEnvelope(
        e: $checkedConvert(
          'e',
          (v) => $enumDecodeNullable(_$OrderEnvelopeEventEnumMap, v),
        ),
        a: $checkedConvert(
          'a',
          (v) => $enumDecodeNullable(_$OrderEnvelopeActionEnumMap, v),
        ),
        tg: $checkedConvert(
          'tg',
          (v) => $enumDecodeNullable(_$EnvelopeTargetEnumMap, v),
        ),
        f: $checkedConvert('f', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        t: $checkedConvert('t', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        p: $checkedConvert(
          'p',
          (v) => OrderEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrderEnvelopeToJson(OrderEnvelope instance) =>
    <String, dynamic>{
      'e': ?_$OrderEnvelopeEventEnumMap[instance.e],
      'a': ?_$OrderEnvelopeActionEnumMap[instance.a],
      'tg': ?_$EnvelopeTargetEnumMap[instance.tg],
      'f': _$EnvelopeSenderEnumMap[instance.f]!,
      't': _$EnvelopeSenderEnumMap[instance.t]!,
      'p': instance.p.toJson(),
    };

const _$OrderEnvelopeEventEnumMap = {
  OrderEnvelopeEvent.CANCELED: 'CANCELED',
  OrderEnvelopeEvent.OFFER: 'OFFER',
  OrderEnvelopeEvent.UNAVAILABLE: 'UNAVAILABLE',
  OrderEnvelopeEvent.DRIVER_ACCEPTED: 'DRIVER_ACCEPTED',
  OrderEnvelopeEvent.DRIVER_LOCATION_UPDATE: 'DRIVER_LOCATION_UPDATE',
  OrderEnvelopeEvent.COMPLETED: 'COMPLETED',
  OrderEnvelopeEvent.MATCHING: 'MATCHING',
  OrderEnvelopeEvent.CHAT_MESSAGE: 'CHAT_MESSAGE',
  OrderEnvelopeEvent.CHAT_UNREAD_COUNT: 'CHAT_UNREAD_COUNT',
  OrderEnvelopeEvent.MERCHANT_ACCEPTED: 'MERCHANT_ACCEPTED',
  OrderEnvelopeEvent.MERCHANT_REJECTED: 'MERCHANT_REJECTED',
  OrderEnvelopeEvent.MERCHANT_PREPARING: 'MERCHANT_PREPARING',
  OrderEnvelopeEvent.MERCHANT_READY: 'MERCHANT_READY',
  OrderEnvelopeEvent.NO_SHOW: 'NO_SHOW',
  OrderEnvelopeEvent.DRIVER_CANCELLED_REMATCHING: 'DRIVER_CANCELLED_REMATCHING',
  OrderEnvelopeEvent.ORDER_STATUS_CHANGED: 'ORDER_STATUS_CHANGED',
  OrderEnvelopeEvent.NEW_DATA: 'NEW_DATA',
  OrderEnvelopeEvent.NO_DATA: 'NO_DATA',
};

const _$OrderEnvelopeActionEnumMap = {
  OrderEnvelopeAction.MATCHING: 'MATCHING',
  OrderEnvelopeAction.ACCEPTED: 'ACCEPTED',
  OrderEnvelopeAction.UPDATE_LOCATION: 'UPDATE_LOCATION',
  OrderEnvelopeAction.DONE: 'DONE',
  OrderEnvelopeAction.SEND_MESSAGE: 'SEND_MESSAGE',
  OrderEnvelopeAction.MERCHANT_ACCEPT: 'MERCHANT_ACCEPT',
  OrderEnvelopeAction.MERCHANT_REJECT: 'MERCHANT_REJECT',
  OrderEnvelopeAction.MERCHANT_MARK_PREPARING: 'MERCHANT_MARK_PREPARING',
  OrderEnvelopeAction.MERCHANT_MARK_READY: 'MERCHANT_MARK_READY',
  OrderEnvelopeAction.REPORT_NO_SHOW: 'REPORT_NO_SHOW',
  OrderEnvelopeAction.CHECK_NEW_DATA: 'CHECK_NEW_DATA',
};

const _$EnvelopeTargetEnumMap = {
  EnvelopeTarget.ADMIN: 'ADMIN',
  EnvelopeTarget.OPERATOR: 'OPERATOR',
  EnvelopeTarget.MERCHANT: 'MERCHANT',
  EnvelopeTarget.DRIVER: 'DRIVER',
  EnvelopeTarget.USER: 'USER',
  EnvelopeTarget.SYSTEM: 'SYSTEM',
  EnvelopeTarget.ALL: 'ALL',
};

const _$EnvelopeSenderEnumMap = {EnvelopeSender.s: 's', EnvelopeSender.c: 'c'};
