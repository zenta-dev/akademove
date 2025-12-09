// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_event_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudEventUserCWProxy {
  FraudEventUser id(String id);

  FraudEventUser name(String name);

  FraudEventUser email(String email);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventUser(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventUser call({String id, String name, String email});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudEventUser.copyWith(...)` or call `instanceOfFraudEventUser.copyWith.fieldName(value)` for a single field.
class _$FraudEventUserCWProxyImpl implements _$FraudEventUserCWProxy {
  const _$FraudEventUserCWProxyImpl(this._value);

  final FraudEventUser _value;

  @override
  FraudEventUser id(String id) => call(id: id);

  @override
  FraudEventUser name(String name) => call(name: name);

  @override
  FraudEventUser email(String email) => call(email: email);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudEventUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudEventUser(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudEventUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return FraudEventUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $FraudEventUserCopyWith on FraudEventUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudEventUser.copyWith(...)` or `instanceOfFraudEventUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudEventUserCWProxy get copyWith => _$FraudEventUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudEventUser _$FraudEventUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FraudEventUser', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name', 'email']);
      final val = FraudEventUser(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FraudEventUserToJson(FraudEventUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
