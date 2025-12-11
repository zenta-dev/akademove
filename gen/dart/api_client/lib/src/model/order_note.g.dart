// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderNoteCWProxy {
  OrderNote pickup(String? pickup);

  OrderNote senderName(String? senderName);

  OrderNote senderPhone(String? senderPhone);

  OrderNote dropoff(String? dropoff);

  OrderNote recevierName(String? recevierName);

  OrderNote recevierPhone(String? recevierPhone);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderNote(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderNote(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderNote call({
    String? pickup,
    String? senderName,
    String? senderPhone,
    String? dropoff,
    String? recevierName,
    String? recevierPhone,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderNote.copyWith(...)` or call `instanceOfOrderNote.copyWith.fieldName(value)` for a single field.
class _$OrderNoteCWProxyImpl implements _$OrderNoteCWProxy {
  const _$OrderNoteCWProxyImpl(this._value);

  final OrderNote _value;

  @override
  OrderNote pickup(String? pickup) => call(pickup: pickup);

  @override
  OrderNote senderName(String? senderName) => call(senderName: senderName);

  @override
  OrderNote senderPhone(String? senderPhone) => call(senderPhone: senderPhone);

  @override
  OrderNote dropoff(String? dropoff) => call(dropoff: dropoff);

  @override
  OrderNote recevierName(String? recevierName) =>
      call(recevierName: recevierName);

  @override
  OrderNote recevierPhone(String? recevierPhone) =>
      call(recevierPhone: recevierPhone);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderNote(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderNote(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderNote call({
    Object? pickup = const $CopyWithPlaceholder(),
    Object? senderName = const $CopyWithPlaceholder(),
    Object? senderPhone = const $CopyWithPlaceholder(),
    Object? dropoff = const $CopyWithPlaceholder(),
    Object? recevierName = const $CopyWithPlaceholder(),
    Object? recevierPhone = const $CopyWithPlaceholder(),
  }) {
    return OrderNote(
      pickup: pickup == const $CopyWithPlaceholder()
          ? _value.pickup
          // ignore: cast_nullable_to_non_nullable
          : pickup as String?,
      senderName: senderName == const $CopyWithPlaceholder()
          ? _value.senderName
          // ignore: cast_nullable_to_non_nullable
          : senderName as String?,
      senderPhone: senderPhone == const $CopyWithPlaceholder()
          ? _value.senderPhone
          // ignore: cast_nullable_to_non_nullable
          : senderPhone as String?,
      dropoff: dropoff == const $CopyWithPlaceholder()
          ? _value.dropoff
          // ignore: cast_nullable_to_non_nullable
          : dropoff as String?,
      recevierName: recevierName == const $CopyWithPlaceholder()
          ? _value.recevierName
          // ignore: cast_nullable_to_non_nullable
          : recevierName as String?,
      recevierPhone: recevierPhone == const $CopyWithPlaceholder()
          ? _value.recevierPhone
          // ignore: cast_nullable_to_non_nullable
          : recevierPhone as String?,
    );
  }
}

extension $OrderNoteCopyWith on OrderNote {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfOrderNote.copyWith(...)` or `instanceOfOrderNote.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderNoteCWProxy get copyWith => _$OrderNoteCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderNote _$OrderNoteFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderNote', json, ($checkedConvert) {
      final val = OrderNote(
        pickup: $checkedConvert('pickup', (v) => v as String?),
        senderName: $checkedConvert('senderName', (v) => v as String?),
        senderPhone: $checkedConvert('senderPhone', (v) => v as String?),
        dropoff: $checkedConvert('dropoff', (v) => v as String?),
        recevierName: $checkedConvert('recevierName', (v) => v as String?),
        recevierPhone: $checkedConvert('recevierPhone', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$OrderNoteToJson(OrderNote instance) => <String, dynamic>{
  'pickup': ?instance.pickup,
  'senderName': ?instance.senderName,
  'senderPhone': ?instance.senderPhone,
  'dropoff': ?instance.dropoff,
  'recevierName': ?instance.recevierName,
  'recevierPhone': ?instance.recevierPhone,
};
