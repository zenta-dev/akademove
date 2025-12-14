// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentEnvelopeCWProxy {
  PaymentEnvelope e(PaymentEnvelopeEvent? e);

  PaymentEnvelope a(PaymentEnvelopeAction? a);

  PaymentEnvelope tg(EnvelopeTarget? tg);

  PaymentEnvelope f(EnvelopeSender f);

  PaymentEnvelope t(EnvelopeSender t);

  PaymentEnvelope p(PaymentEnvelopePayload p);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelope call({
    PaymentEnvelopeEvent? e,
    PaymentEnvelopeAction? a,
    EnvelopeTarget? tg,
    EnvelopeSender f,
    EnvelopeSender t,
    PaymentEnvelopePayload p,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfPaymentEnvelope.copyWith(...)` or call `instanceOfPaymentEnvelope.copyWith.fieldName(value)` for a single field.
class _$PaymentEnvelopeCWProxyImpl implements _$PaymentEnvelopeCWProxy {
  const _$PaymentEnvelopeCWProxyImpl(this._value);

  final PaymentEnvelope _value;

  @override
  PaymentEnvelope e(PaymentEnvelopeEvent? e) => call(e: e);

  @override
  PaymentEnvelope a(PaymentEnvelopeAction? a) => call(a: a);

  @override
  PaymentEnvelope tg(EnvelopeTarget? tg) => call(tg: tg);

  @override
  PaymentEnvelope f(EnvelopeSender f) => call(f: f);

  @override
  PaymentEnvelope t(EnvelopeSender t) => call(t: t);

  @override
  PaymentEnvelope p(PaymentEnvelopePayload p) => call(p: p);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `PaymentEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// PaymentEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  PaymentEnvelope call({
    Object? e = const $CopyWithPlaceholder(),
    Object? a = const $CopyWithPlaceholder(),
    Object? tg = const $CopyWithPlaceholder(),
    Object? f = const $CopyWithPlaceholder(),
    Object? t = const $CopyWithPlaceholder(),
    Object? p = const $CopyWithPlaceholder(),
  }) {
    return PaymentEnvelope(
      e: e == const $CopyWithPlaceholder()
          ? _value.e
          // ignore: cast_nullable_to_non_nullable
          : e as PaymentEnvelopeEvent?,
      a: a == const $CopyWithPlaceholder()
          ? _value.a
          // ignore: cast_nullable_to_non_nullable
          : a as PaymentEnvelopeAction?,
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
          : p as PaymentEnvelopePayload,
    );
  }
}

extension $PaymentEnvelopeCopyWith on PaymentEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfPaymentEnvelope.copyWith(...)` or `instanceOfPaymentEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentEnvelopeCWProxy get copyWith => _$PaymentEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentEnvelope _$PaymentEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaymentEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['f', 't', 'p']);
      final val = PaymentEnvelope(
        e: $checkedConvert(
          'e',
          (v) => $enumDecodeNullable(_$PaymentEnvelopeEventEnumMap, v),
        ),
        a: $checkedConvert(
          'a',
          (v) => $enumDecodeNullable(_$PaymentEnvelopeActionEnumMap, v),
        ),
        tg: $checkedConvert(
          'tg',
          (v) => $enumDecodeNullable(_$EnvelopeTargetEnumMap, v),
        ),
        f: $checkedConvert('f', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        t: $checkedConvert('t', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        p: $checkedConvert(
          'p',
          (v) => PaymentEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PaymentEnvelopeToJson(PaymentEnvelope instance) =>
    <String, dynamic>{
      'e': ?_$PaymentEnvelopeEventEnumMap[instance.e],
      'a': ?_$PaymentEnvelopeActionEnumMap[instance.a],
      'tg': ?_$EnvelopeTargetEnumMap[instance.tg],
      'f': _$EnvelopeSenderEnumMap[instance.f]!,
      't': _$EnvelopeSenderEnumMap[instance.t]!,
      'p': instance.p.toJson(),
    };

const _$PaymentEnvelopeEventEnumMap = {
  PaymentEnvelopeEvent.TOP_UP_SUCCESS: 'TOP_UP_SUCCESS',
  PaymentEnvelopeEvent.PAYMENT_SUCCESS: 'PAYMENT_SUCCESS',
  PaymentEnvelopeEvent.TOP_UP_FAILED: 'TOP_UP_FAILED',
  PaymentEnvelopeEvent.PAYMENT_FAILED: 'PAYMENT_FAILED',
  PaymentEnvelopeEvent.NEW_DATA: 'NEW_DATA',
  PaymentEnvelopeEvent.NO_DATA: 'NO_DATA',
};

const _$PaymentEnvelopeActionEnumMap = {
  PaymentEnvelopeAction.NONE: 'NONE',
  PaymentEnvelopeAction.CHECK_NEW_DATA: 'CHECK_NEW_DATA',
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
