// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_rules.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$GeneralRulesCWProxy {
  GeneralRules type(GeneralRuleType? type);

  GeneralRules minOrderAmount(num? minOrderAmount);

  GeneralRules maxDiscountAmount(num? maxDiscountAmount);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `GeneralRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GeneralRules(...).copyWith(id: 12, name: "My name")
  /// ```
  GeneralRules call({GeneralRuleType? type, num? minOrderAmount, num? maxDiscountAmount});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfGeneralRules.copyWith(...)` or call `instanceOfGeneralRules.copyWith.fieldName(value)` for a single field.
class _$GeneralRulesCWProxyImpl implements _$GeneralRulesCWProxy {
  const _$GeneralRulesCWProxyImpl(this._value);

  final GeneralRules _value;

  @override
  GeneralRules type(GeneralRuleType? type) => call(type: type);

  @override
  GeneralRules minOrderAmount(num? minOrderAmount) => call(minOrderAmount: minOrderAmount);

  @override
  GeneralRules maxDiscountAmount(num? maxDiscountAmount) => call(maxDiscountAmount: maxDiscountAmount);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `GeneralRules(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// GeneralRules(...).copyWith(id: 12, name: "My name")
  /// ```
  GeneralRules call({
    Object? type = const $CopyWithPlaceholder(),
    Object? minOrderAmount = const $CopyWithPlaceholder(),
    Object? maxDiscountAmount = const $CopyWithPlaceholder(),
  }) {
    return GeneralRules(
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as GeneralRuleType?,
      minOrderAmount: minOrderAmount == const $CopyWithPlaceholder()
          ? _value.minOrderAmount
          // ignore: cast_nullable_to_non_nullable
          : minOrderAmount as num?,
      maxDiscountAmount: maxDiscountAmount == const $CopyWithPlaceholder()
          ? _value.maxDiscountAmount
          // ignore: cast_nullable_to_non_nullable
          : maxDiscountAmount as num?,
    );
  }
}

extension $GeneralRulesCopyWith on GeneralRules {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfGeneralRules.copyWith(...)` or `instanceOfGeneralRules.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GeneralRulesCWProxy get copyWith => _$GeneralRulesCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralRules _$GeneralRulesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GeneralRules', json, ($checkedConvert) {
      final val = GeneralRules(
        type: $checkedConvert('type', (v) => $enumDecodeNullable(_$GeneralRuleTypeEnumMap, v)),
        minOrderAmount: $checkedConvert('minOrderAmount', (v) => v as num?),
        maxDiscountAmount: $checkedConvert('maxDiscountAmount', (v) => v as num?),
      );
      return val;
    });

Map<String, dynamic> _$GeneralRulesToJson(GeneralRules instance) => <String, dynamic>{
  'type': ?_$GeneralRuleTypeEnumMap[instance.type],
  'minOrderAmount': ?instance.minOrderAmount,
  'maxDiscountAmount': ?instance.maxDiscountAmount,
};

const _$GeneralRuleTypeEnumMap = {GeneralRuleType.PERCENTAGE: 'PERCENTAGE', GeneralRuleType.FIXED: 'FIXED'};
