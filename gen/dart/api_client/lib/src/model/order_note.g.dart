// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderNoteCWProxy {
  OrderNote pickup(String? pickup);

  OrderNote dropoff(String? dropoff);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderNote(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderNote(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderNote call({String? pickup, String? dropoff});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderNote.copyWith.fieldName(...)`
class _$OrderNoteCWProxyImpl implements _$OrderNoteCWProxy {
  const _$OrderNoteCWProxyImpl(this._value);

  final OrderNote _value;

  @override
  OrderNote pickup(String? pickup) => this(pickup: pickup);

  @override
  OrderNote dropoff(String? dropoff) => this(dropoff: dropoff);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderNote(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderNote(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderNote call({
    Object? pickup = const $CopyWithPlaceholder(),
    Object? dropoff = const $CopyWithPlaceholder(),
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
    );
  }
}

extension $OrderNoteCopyWith on OrderNote {
  /// Returns a callable class that can be used as follows: `instanceOfOrderNote.copyWith(...)` or like so:`instanceOfOrderNote.copyWith.fieldName(...)`.
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
      );
      return val;
    });

Map<String, dynamic> _$OrderNoteToJson(OrderNote instance) => <String, dynamic>{
  'pickup': ?instance.pickup,
  'dropoff': ?instance.dropoff,
};
