// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unban_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UnbanUserCWProxy {
  UnbanUser id(String id);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UnbanUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnbanUser(...).copyWith(id: 12, name: "My name")
  /// ```
  UnbanUser call({String id});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUnbanUser.copyWith(...)` or call `instanceOfUnbanUser.copyWith.fieldName(value)` for a single field.
class _$UnbanUserCWProxyImpl implements _$UnbanUserCWProxy {
  const _$UnbanUserCWProxyImpl(this._value);

  final UnbanUser _value;

  @override
  UnbanUser id(String id) => call(id: id);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UnbanUser(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UnbanUser(...).copyWith(id: 12, name: "My name")
  /// ```
  UnbanUser call({Object? id = const $CopyWithPlaceholder()}) {
    return UnbanUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $UnbanUserCopyWith on UnbanUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUnbanUser.copyWith(...)` or `instanceOfUnbanUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UnbanUserCWProxy get copyWith => _$UnbanUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnbanUser _$UnbanUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UnbanUser', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id']);
      final val = UnbanUser(id: $checkedConvert('id', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$UnbanUserToJson(UnbanUser instance) => <String, dynamic>{
  'id': instance.id,
};
