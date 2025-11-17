// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserRulesCWProxy {
  UserRules newUserOnly(bool? newUserOnly);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserRules(...).copyWith(id: 12, name: "My name")
  /// ````
  UserRules call({bool? newUserOnly});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserRules.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserRules.copyWith.fieldName(...)`
class _$UserRulesCWProxyImpl implements _$UserRulesCWProxy {
  const _$UserRulesCWProxyImpl(this._value);

  final UserRules _value;

  @override
  UserRules newUserOnly(bool? newUserOnly) => this(newUserOnly: newUserOnly);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserRules(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserRules(...).copyWith(id: 12, name: "My name")
  /// ````
  UserRules call({Object? newUserOnly = const $CopyWithPlaceholder()}) {
    return UserRules(
      newUserOnly: newUserOnly == const $CopyWithPlaceholder()
          ? _value.newUserOnly
          // ignore: cast_nullable_to_non_nullable
          : newUserOnly as bool?,
    );
  }
}

extension $UserRulesCopyWith on UserRules {
  /// Returns a callable class that can be used as follows: `instanceOfUserRules.copyWith(...)` or like so:`instanceOfUserRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserRulesCWProxy get copyWith => _$UserRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRules _$UserRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserRules', json, ($checkedConvert) {
      final val = UserRules(
        newUserOnly: $checkedConvert('newUserOnly', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$UserRulesToJson(UserRules instance) => <String, dynamic>{
  'newUserOnly': ?instance.newUserOnly,
};
