// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_quick_message_template.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateQuickMessageTemplateCWProxy {
  UpdateQuickMessageTemplate role(UpdateQuickMessageTemplateRoleEnum? role);

  UpdateQuickMessageTemplate message(String? message);

  UpdateQuickMessageTemplate orderType(
    UpdateQuickMessageTemplateOrderTypeEnum? orderType,
  );

  UpdateQuickMessageTemplate locale(String? locale);

  UpdateQuickMessageTemplate isActive(bool? isActive);

  UpdateQuickMessageTemplate displayOrder(int? displayOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateQuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateQuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateQuickMessageTemplate call({
    UpdateQuickMessageTemplateRoleEnum? role,
    String? message,
    UpdateQuickMessageTemplateOrderTypeEnum? orderType,
    String? locale,
    bool? isActive,
    int? displayOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUpdateQuickMessageTemplate.copyWith(...)` or call `instanceOfUpdateQuickMessageTemplate.copyWith.fieldName(value)` for a single field.
class _$UpdateQuickMessageTemplateCWProxyImpl
    implements _$UpdateQuickMessageTemplateCWProxy {
  const _$UpdateQuickMessageTemplateCWProxyImpl(this._value);

  final UpdateQuickMessageTemplate _value;

  @override
  UpdateQuickMessageTemplate role(UpdateQuickMessageTemplateRoleEnum? role) =>
      call(role: role);

  @override
  UpdateQuickMessageTemplate message(String? message) => call(message: message);

  @override
  UpdateQuickMessageTemplate orderType(
    UpdateQuickMessageTemplateOrderTypeEnum? orderType,
  ) => call(orderType: orderType);

  @override
  UpdateQuickMessageTemplate locale(String? locale) => call(locale: locale);

  @override
  UpdateQuickMessageTemplate isActive(bool? isActive) =>
      call(isActive: isActive);

  @override
  UpdateQuickMessageTemplate displayOrder(int? displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `UpdateQuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// UpdateQuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  UpdateQuickMessageTemplate call({
    Object? role = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
  }) {
    return UpdateQuickMessageTemplate(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as UpdateQuickMessageTemplateRoleEnum?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as UpdateQuickMessageTemplateOrderTypeEnum?,
      locale: locale == const $CopyWithPlaceholder()
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
    );
  }
}

extension $UpdateQuickMessageTemplateCopyWith on UpdateQuickMessageTemplate {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUpdateQuickMessageTemplate.copyWith(...)` or `instanceOfUpdateQuickMessageTemplate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateQuickMessageTemplateCWProxy get copyWith =>
      _$UpdateQuickMessageTemplateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuickMessageTemplate _$UpdateQuickMessageTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateQuickMessageTemplate', json, ($checkedConvert) {
  final val = UpdateQuickMessageTemplate(
    role: $checkedConvert(
      'role',
      (v) =>
          $enumDecodeNullable(_$UpdateQuickMessageTemplateRoleEnumEnumMap, v),
    ),
    message: $checkedConvert('message', (v) => v as String?),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecodeNullable(
        _$UpdateQuickMessageTemplateOrderTypeEnumEnumMap,
        v,
      ),
    ),
    locale: $checkedConvert('locale', (v) => v as String? ?? 'en'),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
    displayOrder: $checkedConvert('displayOrder', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$UpdateQuickMessageTemplateToJson(
  UpdateQuickMessageTemplate instance,
) => <String, dynamic>{
  'role': ?_$UpdateQuickMessageTemplateRoleEnumEnumMap[instance.role],
  'message': ?instance.message,
  'orderType':
      ?_$UpdateQuickMessageTemplateOrderTypeEnumEnumMap[instance.orderType],
  'locale': ?instance.locale,
  'isActive': ?instance.isActive,
  'displayOrder': ?instance.displayOrder,
};

const _$UpdateQuickMessageTemplateRoleEnumEnumMap = {
  UpdateQuickMessageTemplateRoleEnum.ADMIN: 'ADMIN',
  UpdateQuickMessageTemplateRoleEnum.OPERATOR: 'OPERATOR',
  UpdateQuickMessageTemplateRoleEnum.MERCHANT: 'MERCHANT',
  UpdateQuickMessageTemplateRoleEnum.DRIVER: 'DRIVER',
  UpdateQuickMessageTemplateRoleEnum.USER: 'USER',
};

const _$UpdateQuickMessageTemplateOrderTypeEnumEnumMap = {
  UpdateQuickMessageTemplateOrderTypeEnum.RIDE: 'RIDE',
  UpdateQuickMessageTemplateOrderTypeEnum.DELIVERY: 'DELIVERY',
  UpdateQuickMessageTemplateOrderTypeEnum.FOOD: 'FOOD',
};
