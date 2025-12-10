// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lookup_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLookupQueryCWProxy {
  UserLookupQuery phone(String phone);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupQuery call({String phone});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserLookupQuery.copyWith(...)` or call `instanceOfUserLookupQuery.copyWith.fieldName(value)` for a single field.
class _$UserLookupQueryCWProxyImpl implements _$UserLookupQueryCWProxy {
  const _$UserLookupQueryCWProxyImpl(this._value);

  final UserLookupQuery _value;

  @override
  UserLookupQuery phone(String phone) => call(phone: phone);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupQuery call({Object? phone = const $CopyWithPlaceholder()}) {
    return UserLookupQuery(
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
    );
  }
}

extension $UserLookupQueryCopyWith on UserLookupQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserLookupQuery.copyWith(...)` or `instanceOfUserLookupQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserLookupQueryCWProxy get copyWith => _$UserLookupQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLookupQuery _$UserLookupQueryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserLookupQuery', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['phone']);
      final val = UserLookupQuery(
        phone: $checkedConvert('phone', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$UserLookupQueryToJson(UserLookupQuery instance) =>
    <String, dynamic>{'phone': instance.phone};
