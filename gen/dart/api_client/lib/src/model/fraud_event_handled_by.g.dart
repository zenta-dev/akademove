// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_event_handled_by.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudEventHandledByCWProxy {
  FraudEventHandledBy id(String id);

  FraudEventHandledBy name(String name);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventHandledBy(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventHandledBy(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventHandledBy call({String id, String name});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudEventHandledBy.copyWith(...)` or call `instanceOfFraudEventHandledBy.copyWith.fieldName(value)` for a single field.
class _$FraudEventHandledByCWProxyImpl implements _$FraudEventHandledByCWProxy {
  const _$FraudEventHandledByCWProxyImpl(this._value);

  final FraudEventHandledBy _value;

  @override
  FraudEventHandledBy id(String id) => call(id: id);

  @override
  FraudEventHandledBy name(String name) => call(name: name);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventHandledBy(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventHandledBy(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventHandledBy call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return FraudEventHandledBy(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $FraudEventHandledByCopyWith on FraudEventHandledBy {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudEventHandledBy.copyWith(...)` or `instanceOfFraudEventHandledBy.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudEventHandledByCWProxy get copyWith =>
      _$FraudEventHandledByCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudEventHandledBy _$FraudEventHandledByFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudEventHandledBy', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = FraudEventHandledBy(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FraudEventHandledByToJson(
  FraudEventHandledBy instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
