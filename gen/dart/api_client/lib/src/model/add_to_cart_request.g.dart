// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddToCartRequestCWProxy {
  AddToCartRequest menuId(String menuId);

  AddToCartRequest quantity(int? quantity);

  AddToCartRequest notes(String? notes);

  AddToCartRequest replaceIfConflict(bool? replaceIfConflict);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCartRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCartRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCartRequest call({
    String menuId,
    int? quantity,
    String? notes,
    bool? replaceIfConflict,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAddToCartRequest.copyWith(...)` or call `instanceOfAddToCartRequest.copyWith.fieldName(value)` for a single field.
class _$AddToCartRequestCWProxyImpl implements _$AddToCartRequestCWProxy {
  const _$AddToCartRequestCWProxyImpl(this._value);

  final AddToCartRequest _value;

  @override
  AddToCartRequest menuId(String menuId) => call(menuId: menuId);

  @override
  AddToCartRequest quantity(int? quantity) => call(quantity: quantity);

  @override
  AddToCartRequest notes(String? notes) => call(notes: notes);

  @override
  AddToCartRequest replaceIfConflict(bool? replaceIfConflict) =>
      call(replaceIfConflict: replaceIfConflict);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AddToCartRequest(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AddToCartRequest(...).copyWith(id: 12, name: "My name")
  /// ```
  AddToCartRequest call({
    Object? menuId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? replaceIfConflict = const $CopyWithPlaceholder(),
  }) {
    return AddToCartRequest(
      menuId: menuId == const $CopyWithPlaceholder() || menuId == null
          ? _value.menuId
          // ignore: cast_nullable_to_non_nullable
          : menuId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as int?,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      replaceIfConflict: replaceIfConflict == const $CopyWithPlaceholder()
          ? _value.replaceIfConflict
          // ignore: cast_nullable_to_non_nullable
          : replaceIfConflict as bool?,
    );
  }
}

extension $AddToCartRequestCopyWith on AddToCartRequest {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAddToCartRequest.copyWith(...)` or `instanceOfAddToCartRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddToCartRequestCWProxy get copyWith => _$AddToCartRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartRequest _$AddToCartRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AddToCartRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['menuId']);
      final val = AddToCartRequest(
        menuId: $checkedConvert('menuId', (v) => v as String),
        quantity: $checkedConvert('quantity', (v) => (v as num?)?.toInt() ?? 1),
        notes: $checkedConvert('notes', (v) => v as String?),
        replaceIfConflict: $checkedConvert(
          'replaceIfConflict',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

Map<String, dynamic> _$AddToCartRequestToJson(AddToCartRequest instance) =>
    <String, dynamic>{
      'menuId': instance.menuId,
      'quantity': ?instance.quantity,
      'notes': ?instance.notes,
      'replaceIfConflict': ?instance.replaceIfConflict,
    };
