// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderNoteCWProxy {
  OrderNote pickup(String? pickup);

  OrderNote dropoff(String? dropoff);

  OrderNote instructions(String? instructions);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `OrderNote(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// OrderNote(...).copyWith(id: 12, name: "My name")
  /// ```
  OrderNote call({String? pickup, String? dropoff, String? instructions});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfOrderNote.copyWith(...)` or call `instanceOfOrderNote.copyWith.fieldName(value)` for a single field.
class _$OrderNoteCWProxyImpl implements _$OrderNoteCWProxy {
  const _$OrderNoteCWProxyImpl(this._value);

  final OrderNote _value;

  @override
  OrderNote pickup(String? pickup) => call(pickup: pickup);

  @override
  OrderNote dropoff(String? dropoff) => call(dropoff: dropoff);

  @override
  OrderNote instructions(String? instructions) =>
      call(instructions: instructions);

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
    Object? dropoff = const $CopyWithPlaceholder(),
    Object? instructions = const $CopyWithPlaceholder(),
  }) {
    return OrderNote(
      pickup: pickup == const $CopyWithPlaceholder()
          ? _value.pickup
          // ignore: cast_nullable_to_non_nullable
          : pickup as String?,
      dropoff: dropoff == const $CopyWithPlaceholder()
          ? _value.dropoff
          // ignore: cast_nullable_to_non_nullable
          : dropoff as String?,
      instructions: instructions == const $CopyWithPlaceholder()
          ? _value.instructions
          // ignore: cast_nullable_to_non_nullable
          : instructions as String?,
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
        dropoff: $checkedConvert('dropoff', (v) => v as String?),
        instructions: $checkedConvert('instructions', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$OrderNoteToJson(OrderNote instance) => <String, dynamic>{
  'pickup': ?instance.pickup,
  'dropoff': ?instance.dropoff,
  'instructions': ?instance.instructions,
};
