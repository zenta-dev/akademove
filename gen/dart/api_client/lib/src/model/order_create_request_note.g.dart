// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request_note.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderCreateRequestNoteCWProxy {
  OrderCreateRequestNote pickup(String? pickup);

  OrderCreateRequestNote dropoff(String? dropoff);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestNote(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestNote(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestNote call({String? pickup, String? dropoff});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderCreateRequestNote.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderCreateRequestNote.copyWith.fieldName(...)`
class _$OrderCreateRequestNoteCWProxyImpl
    implements _$OrderCreateRequestNoteCWProxy {
  const _$OrderCreateRequestNoteCWProxyImpl(this._value);

  final OrderCreateRequestNote _value;

  @override
  OrderCreateRequestNote pickup(String? pickup) => this(pickup: pickup);

  @override
  OrderCreateRequestNote dropoff(String? dropoff) => this(dropoff: dropoff);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderCreateRequestNote(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderCreateRequestNote(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderCreateRequestNote call({
    Object? pickup = const $CopyWithPlaceholder(),
    Object? dropoff = const $CopyWithPlaceholder(),
  }) {
    return OrderCreateRequestNote(
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

extension $OrderCreateRequestNoteCopyWith on OrderCreateRequestNote {
  /// Returns a callable class that can be used as follows: `instanceOfOrderCreateRequestNote.copyWith(...)` or like so:`instanceOfOrderCreateRequestNote.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderCreateRequestNoteCWProxy get copyWith =>
      _$OrderCreateRequestNoteCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequestNote _$OrderCreateRequestNoteFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('OrderCreateRequestNote', json, ($checkedConvert) {
  final val = OrderCreateRequestNote(
    pickup: $checkedConvert('pickup', (v) => v as String?),
    dropoff: $checkedConvert('dropoff', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$OrderCreateRequestNoteToJson(
  OrderCreateRequestNote instance,
) => <String, dynamic>{
  'pickup': ?instance.pickup,
  'dropoff': ?instance.dropoff,
};
