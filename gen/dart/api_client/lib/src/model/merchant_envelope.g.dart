// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MerchantEnvelopeCWProxy {
  MerchantEnvelope e(MerchantEnvelopeEvent? e);

  MerchantEnvelope a(MerchantEnvelopeAction? a);

  MerchantEnvelope tg(EnvelopeTarget? tg);

  MerchantEnvelope f(EnvelopeSender f);

  MerchantEnvelope t(EnvelopeSender t);

  MerchantEnvelope p(MerchantEnvelopePayload p);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelope call({
    MerchantEnvelopeEvent? e,
    MerchantEnvelopeAction? a,
    EnvelopeTarget? tg,
    EnvelopeSender f,
    EnvelopeSender t,
    MerchantEnvelopePayload p,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfMerchantEnvelope.copyWith(...)` or call `instanceOfMerchantEnvelope.copyWith.fieldName(value)` for a single field.
class _$MerchantEnvelopeCWProxyImpl implements _$MerchantEnvelopeCWProxy {
  const _$MerchantEnvelopeCWProxyImpl(this._value);

  final MerchantEnvelope _value;

  @override
  MerchantEnvelope e(MerchantEnvelopeEvent? e) => call(e: e);

  @override
  MerchantEnvelope a(MerchantEnvelopeAction? a) => call(a: a);

  @override
  MerchantEnvelope tg(EnvelopeTarget? tg) => call(tg: tg);

  @override
  MerchantEnvelope f(EnvelopeSender f) => call(f: f);

  @override
  MerchantEnvelope t(EnvelopeSender t) => call(t: t);

  @override
  MerchantEnvelope p(MerchantEnvelopePayload p) => call(p: p);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `MerchantEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// MerchantEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  MerchantEnvelope call({
    Object? e = const $CopyWithPlaceholder(),
    Object? a = const $CopyWithPlaceholder(),
    Object? tg = const $CopyWithPlaceholder(),
    Object? f = const $CopyWithPlaceholder(),
    Object? t = const $CopyWithPlaceholder(),
    Object? p = const $CopyWithPlaceholder(),
  }) {
    return MerchantEnvelope(
      e: e == const $CopyWithPlaceholder()
          ? _value.e
          // ignore: cast_nullable_to_non_nullable
          : e as MerchantEnvelopeEvent?,
      a: a == const $CopyWithPlaceholder()
          ? _value.a
          // ignore: cast_nullable_to_non_nullable
          : a as MerchantEnvelopeAction?,
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
          : p as MerchantEnvelopePayload,
    );
  }
}

extension $MerchantEnvelopeCopyWith on MerchantEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfMerchantEnvelope.copyWith(...)` or `instanceOfMerchantEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MerchantEnvelopeCWProxy get copyWith => _$MerchantEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantEnvelope _$MerchantEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('MerchantEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['f', 't', 'p']);
      final val = MerchantEnvelope(
        e: $checkedConvert(
          'e',
          (v) => $enumDecodeNullable(_$MerchantEnvelopeEventEnumMap, v),
        ),
        a: $checkedConvert(
          'a',
          (v) => $enumDecodeNullable(_$MerchantEnvelopeActionEnumMap, v),
        ),
        tg: $checkedConvert(
          'tg',
          (v) => $enumDecodeNullable(_$EnvelopeTargetEnumMap, v),
        ),
        f: $checkedConvert('f', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        t: $checkedConvert('t', (v) => $enumDecode(_$EnvelopeSenderEnumMap, v)),
        p: $checkedConvert(
          'p',
          (v) => MerchantEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MerchantEnvelopeToJson(MerchantEnvelope instance) =>
    <String, dynamic>{
      'e': ?_$MerchantEnvelopeEventEnumMap[instance.e],
      'a': ?_$MerchantEnvelopeActionEnumMap[instance.a],
      'tg': ?_$EnvelopeTargetEnumMap[instance.tg],
      'f': _$EnvelopeSenderEnumMap[instance.f]!,
      't': _$EnvelopeSenderEnumMap[instance.t]!,
      'p': instance.p.toJson(),
    };

const _$MerchantEnvelopeEventEnumMap = {
  MerchantEnvelopeEvent.NEW_ORDER: 'NEW_ORDER',
  MerchantEnvelopeEvent.ORDER_CANCELLED: 'ORDER_CANCELLED',
  MerchantEnvelopeEvent.DRIVER_ASSIGNED: 'DRIVER_ASSIGNED',
  MerchantEnvelopeEvent.ORDER_COMPLETED: 'ORDER_COMPLETED',
  MerchantEnvelopeEvent.ORDER_STATUS_CHANGED: 'ORDER_STATUS_CHANGED',
};

const _$MerchantEnvelopeActionEnumMap = {MerchantEnvelopeAction.NONE: 'NONE'};

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
