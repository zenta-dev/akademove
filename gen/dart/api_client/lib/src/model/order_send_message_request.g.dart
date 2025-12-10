// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_send_message_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderSendMessageRequestCWProxy {
  OrderSendMessageRequest message(String? message);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderSendMessageRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderSendMessageRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderSendMessageRequest call({String? message});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderSendMessageRequest.copyWith(...)` or call `instanceOfOrderSendMessageRequest.copyWith.fieldName(value)` for a single field.
class _$OrderSendMessageRequestCWProxyImpl
    implements _$OrderSendMessageRequestCWProxy {
  const _$OrderSendMessageRequestCWProxyImpl(this._value);

  final OrderSendMessageRequest _value;

  @override
  OrderSendMessageRequest message(String? message) => call(message: message);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderSendMessageRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderSendMessageRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderSendMessageRequest call({
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return OrderSendMessageRequest(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $OrderSendMessageRequestCopyWith on OrderSendMessageRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderSendMessageRequest.copyWith(...)` or `instanceOfOrderSendMessageRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderSendMessageRequestCWProxy get copyWith =>
      _$OrderSendMessageRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSendMessageRequest _$OrderSendMessageRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderSendMessageRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message']);
  final val = OrderSendMessageRequest(
    message: $checkedConvert('message', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderSendMessageRequestToJson(
  OrderSendMessageRequest instance,
) => <String, dynamic>{'message': instance.message};
