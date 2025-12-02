// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserRulesCWProxy {
  UserRules newUserOnly(bool? newUserOnly);

  UserRules perUserLimit(int? perUserLimit);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserRules(...).copyWith(id: 12, name: "My name")
  /// ```
  UserRules call({bool? newUserOnly, int? perUserLimit});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUserRules.copyWith(...)` or call `instanceOfUserRules.copyWith.fieldName(value)` for a single field.
class _$UserRulesCWProxyImpl implements _$UserRulesCWProxy {
  const _$UserRulesCWProxyImpl(this._value);

  final UserRules _value;

  @override
  UserRules newUserOnly(bool? newUserOnly) => call(newUserOnly: newUserOnly);

  @override
  UserRules perUserLimit(int? perUserLimit) => call(perUserLimit: perUserLimit);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UserRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UserRules(...).copyWith(id: 12, name: "My name")
  /// ```
  UserRules call({
    Object? newUserOnly = const $CopyWithPlaceholder(),
    Object? perUserLimit = const $CopyWithPlaceholder(),
  }) {
    return UserRules(
      newUserOnly: newUserOnly == const $CopyWithPlaceholder()
          ? _value.newUserOnly
          // ignore: cast_nullable_to_non_nullable
          : newUserOnly as bool?,
      perUserLimit: perUserLimit == const $CopyWithPlaceholder()
          ? _value.perUserLimit
          // ignore: cast_nullable_to_non_nullable
          : perUserLimit as int?,
    );
  }
}

extension $UserRulesCopyWith on UserRules {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUserRules.copyWith(...)` or `instanceOfUserRules.copyWith.fieldName(...)`.
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
        perUserLimit: $checkedConvert(
          'perUserLimit',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UserRulesToJson(UserRules instance) => <String, dynamic>{
  'newUserOnly': ?instance.newUserOnly,
  'perUserLimit': ?instance.perUserLimit,
};
