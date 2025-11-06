// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unban_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UnbanUserCWProxy {
  UnbanUser id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UnbanUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UnbanUser(...).copyWith(id: 12, name: "My name")
  /// ````
  UnbanUser call({String id});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUnbanUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUnbanUser.copyWith.fieldName(...)`
class _$UnbanUserCWProxyImpl implements _$UnbanUserCWProxy {
  const _$UnbanUserCWProxyImpl(this._value);

  final UnbanUser _value;

  @override
  UnbanUser id(String id) => this(id: id);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UnbanUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UnbanUser(...).copyWith(id: 12, name: "My name")
  /// ````
  UnbanUser call({Object? id = const $CopyWithPlaceholder()}) {
    return UnbanUser(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $UnbanUserCopyWith on UnbanUser {
  /// Returns a callable class that can be used as follows: `instanceOfUnbanUser.copyWith(...)` or like so:`instanceOfUnbanUser.copyWith.fieldName(...)`.
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
