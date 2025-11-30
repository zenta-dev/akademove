// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_chat_message_sender.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderChatMessageSenderCWProxy {
  OrderChatMessageSender name(String name);

  OrderChatMessageSender image(String? image);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessageSender(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessageSender(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessageSender call({String name, String? image});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderChatMessageSender.copyWith(...)` or call `instanceOfOrderChatMessageSender.copyWith.fieldName(value)` for a single field.
class _$OrderChatMessageSenderCWProxyImpl
    implements _$OrderChatMessageSenderCWProxy {
  const _$OrderChatMessageSenderCWProxyImpl(this._value);

  final OrderChatMessageSender _value;

  @override
  OrderChatMessageSender name(String name) => call(name: name);

  @override
  OrderChatMessageSender image(String? image) => call(image: image);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderChatMessageSender(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderChatMessageSender(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderChatMessageSender call({
    Object? name = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return OrderChatMessageSender(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
    );
  }
}

extension $OrderChatMessageSenderCopyWith on OrderChatMessageSender {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderChatMessageSender.copyWith(...)` or `instanceOfOrderChatMessageSender.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderChatMessageSenderCWProxy get copyWith =>
      _$OrderChatMessageSenderCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderChatMessageSender _$OrderChatMessageSenderFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderChatMessageSender', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name']);
  final val = OrderChatMessageSender(
    name: $checkedConvert('name', (v) => v as String),
    image: $checkedConvert('image', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderChatMessageSenderToJson(
  OrderChatMessageSender instance,
) => <String, dynamic>{'name': instance.name, 'image': ?instance.image};
