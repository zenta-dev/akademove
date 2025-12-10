// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lookup_result.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserLookupResultCWProxy {
  UserLookupResult id(String id);

  UserLookupResult name(String name);

  UserLookupResult phone(UserLookupResultPhone? phone);

  UserLookupResult image(String? image);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupResult(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupResult call({
    String id,
    String name,
    UserLookupResultPhone? phone,
    String? image,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserLookupResult.copyWith(...)` or call `instanceOfUserLookupResult.copyWith.fieldName(value)` for a single field.
class _$UserLookupResultCWProxyImpl implements _$UserLookupResultCWProxy {
  const _$UserLookupResultCWProxyImpl(this._value);

  final UserLookupResult _value;

  @override
  UserLookupResult id(String id) => call(id: id);

  @override
  UserLookupResult name(String name) => call(name: name);

  @override
  UserLookupResult phone(UserLookupResultPhone? phone) => call(phone: phone);

  @override
  UserLookupResult image(String? image) => call(image: image);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserLookupResult(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserLookupResult(...).copyWith(id: 12, name: "My name")
  /// ```
  UserLookupResult call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
  }) {
    return UserLookupResult(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as UserLookupResultPhone?,
      image: image == const $CopyWithPlaceholder()
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String?,
    );
  }
}

extension $UserLookupResultCopyWith on UserLookupResult {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserLookupResult.copyWith(...)` or `instanceOfUserLookupResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserLookupResultCWProxy get copyWith => _$UserLookupResultCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLookupResult _$UserLookupResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserLookupResult', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'name']);
      final val = UserLookupResult(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        phone: $checkedConvert(
          'phone',
          (v) => v == null
              ? null
              : UserLookupResultPhone.fromJson(v as Map<String, dynamic>),
        ),
        image: $checkedConvert('image', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$UserLookupResultToJson(UserLookupResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': ?instance.phone?.toJson(),
      'image': ?instance.image,
    };
