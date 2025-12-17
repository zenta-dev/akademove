// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_envelope_payload_error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderEnvelopePayloadErrorCWProxy {
  OrderEnvelopePayloadError code(String code);

  OrderEnvelopePayloadError message(String message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadError(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadError(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadError call({String code, String message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderEnvelopePayloadError.copyWith(...)` or call `instanceOfOrderEnvelopePayloadError.copyWith.fieldName(value)` for a single field.
class _$OrderEnvelopePayloadErrorCWProxyImpl
    implements _$OrderEnvelopePayloadErrorCWProxy {
  const _$OrderEnvelopePayloadErrorCWProxyImpl(this._value);

  final OrderEnvelopePayloadError _value;

  @override
  OrderEnvelopePayloadError code(String code) => call(code: code);

  @override
  OrderEnvelopePayloadError message(String message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderEnvelopePayloadError(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderEnvelopePayloadError(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderEnvelopePayloadError call({
    Object? code = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return OrderEnvelopePayloadError(
      code: code == const $CopyWithPlaceholder() || code == null
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
    );
  }
}

extension $OrderEnvelopePayloadErrorCopyWith on OrderEnvelopePayloadError {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderEnvelopePayloadError.copyWith(...)` or `instanceOfOrderEnvelopePayloadError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderEnvelopePayloadErrorCWProxy get copyWith =>
      _$OrderEnvelopePayloadErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderEnvelopePayloadError _$OrderEnvelopePayloadErrorFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderEnvelopePayloadError', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['code', 'message']);
  final val = OrderEnvelopePayloadError(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$OrderEnvelopePayloadErrorToJson(
  OrderEnvelopePayloadError instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
