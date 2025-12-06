// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_chat_envelope.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SupportChatEnvelopeCWProxy {
  SupportChatEnvelope e(SupportChatEnvelopeEvent? e);

  SupportChatEnvelope a(SupportChatEnvelopeAction? a);

  SupportChatEnvelope f(SupportChatEnvelopeFEnum f);

  SupportChatEnvelope t(SupportChatEnvelopeTEnum t);

  SupportChatEnvelope p(SupportChatEnvelopePayload p);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatEnvelope call({
    SupportChatEnvelopeEvent? e,
    SupportChatEnvelopeAction? a,
    SupportChatEnvelopeFEnum f,
    SupportChatEnvelopeTEnum t,
    SupportChatEnvelopePayload p,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfSupportChatEnvelope.copyWith(...)` or call `instanceOfSupportChatEnvelope.copyWith.fieldName(value)` for a single field.
class _$SupportChatEnvelopeCWProxyImpl implements _$SupportChatEnvelopeCWProxy {
  const _$SupportChatEnvelopeCWProxyImpl(this._value);

  final SupportChatEnvelope _value;

  @override
  SupportChatEnvelope e(SupportChatEnvelopeEvent? e) => call(e: e);

  @override
  SupportChatEnvelope a(SupportChatEnvelopeAction? a) => call(a: a);

  @override
  SupportChatEnvelope f(SupportChatEnvelopeFEnum f) => call(f: f);

  @override
  SupportChatEnvelope t(SupportChatEnvelopeTEnum t) => call(t: t);

  @override
  SupportChatEnvelope p(SupportChatEnvelopePayload p) => call(p: p);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `SupportChatEnvelope(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// SupportChatEnvelope(...).copyWith(id: 12, name: "My name")
  /// ```
  SupportChatEnvelope call({
    Object? e = const $CopyWithPlaceholder(),
    Object? a = const $CopyWithPlaceholder(),
    Object? f = const $CopyWithPlaceholder(),
    Object? t = const $CopyWithPlaceholder(),
    Object? p = const $CopyWithPlaceholder(),
  }) {
    return SupportChatEnvelope(
      e: e == const $CopyWithPlaceholder()
          ? _value.e
          // ignore: cast_nullable_to_non_nullable
          : e as SupportChatEnvelopeEvent?,
      a: a == const $CopyWithPlaceholder()
          ? _value.a
          // ignore: cast_nullable_to_non_nullable
          : a as SupportChatEnvelopeAction?,
      f: f == const $CopyWithPlaceholder() || f == null
          ? _value.f
          // ignore: cast_nullable_to_non_nullable
          : f as SupportChatEnvelopeFEnum,
      t: t == const $CopyWithPlaceholder() || t == null
          ? _value.t
          // ignore: cast_nullable_to_non_nullable
          : t as SupportChatEnvelopeTEnum,
      p: p == const $CopyWithPlaceholder() || p == null
          ? _value.p
          // ignore: cast_nullable_to_non_nullable
          : p as SupportChatEnvelopePayload,
    );
  }
}

extension $SupportChatEnvelopeCopyWith on SupportChatEnvelope {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfSupportChatEnvelope.copyWith(...)` or `instanceOfSupportChatEnvelope.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SupportChatEnvelopeCWProxy get copyWith =>
      _$SupportChatEnvelopeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportChatEnvelope _$SupportChatEnvelopeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SupportChatEnvelope', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['f', 't', 'p']);
      final val = SupportChatEnvelope(
        e: $checkedConvert(
          'e',
          (v) => $enumDecodeNullable(_$SupportChatEnvelopeEventEnumMap, v),
        ),
        a: $checkedConvert(
          'a',
          (v) => $enumDecodeNullable(_$SupportChatEnvelopeActionEnumMap, v),
        ),
        f: $checkedConvert(
          'f',
          (v) => $enumDecode(_$SupportChatEnvelopeFEnumEnumMap, v),
        ),
        t: $checkedConvert(
          't',
          (v) => $enumDecode(_$SupportChatEnvelopeTEnumEnumMap, v),
        ),
        p: $checkedConvert(
          'p',
          (v) => SupportChatEnvelopePayload.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SupportChatEnvelopeToJson(
  SupportChatEnvelope instance,
) => <String, dynamic>{
  'e': ?_$SupportChatEnvelopeEventEnumMap[instance.e],
  'a': ?_$SupportChatEnvelopeActionEnumMap[instance.a],
  'f': _$SupportChatEnvelopeFEnumEnumMap[instance.f]!,
  't': _$SupportChatEnvelopeTEnumEnumMap[instance.t]!,
  'p': instance.p.toJson(),
};

const _$SupportChatEnvelopeEventEnumMap = {
  SupportChatEnvelopeEvent.NEW_MESSAGE: 'NEW_MESSAGE',
  SupportChatEnvelopeEvent.MESSAGE_READ: 'MESSAGE_READ',
  SupportChatEnvelopeEvent.TICKET_UPDATED: 'TICKET_UPDATED',
  SupportChatEnvelopeEvent.TICKET_ASSIGNED: 'TICKET_ASSIGNED',
  SupportChatEnvelopeEvent.TICKET_CLOSED: 'TICKET_CLOSED',
  SupportChatEnvelopeEvent.TYPING: 'TYPING',
};

const _$SupportChatEnvelopeActionEnumMap = {
  SupportChatEnvelopeAction.SEND_MESSAGE: 'SEND_MESSAGE',
  SupportChatEnvelopeAction.MARK_READ: 'MARK_READ',
  SupportChatEnvelopeAction.START_TYPING: 'START_TYPING',
  SupportChatEnvelopeAction.STOP_TYPING: 'STOP_TYPING',
};

const _$SupportChatEnvelopeFEnumEnumMap = {
  SupportChatEnvelopeFEnum.s: 's',
  SupportChatEnvelopeFEnum.c: 'c',
};

const _$SupportChatEnvelopeTEnumEnumMap = {
  SupportChatEnvelopeTEnum.s: 's',
  SupportChatEnvelopeTEnum.c: 'c',
};
