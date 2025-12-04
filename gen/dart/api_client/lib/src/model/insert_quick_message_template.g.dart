// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_quick_message_template.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsertQuickMessageTemplateCWProxy {
  InsertQuickMessageTemplate role(InsertQuickMessageTemplateRoleEnum role);

  InsertQuickMessageTemplate message(String message);

  InsertQuickMessageTemplate orderType(
    InsertQuickMessageTemplateOrderTypeEnum? orderType,
  );

  InsertQuickMessageTemplate locale(String? locale);

  InsertQuickMessageTemplate isActive(bool isActive);

  InsertQuickMessageTemplate displayOrder(int displayOrder);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertQuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertQuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertQuickMessageTemplate call({
    InsertQuickMessageTemplateRoleEnum role,
    String message,
    InsertQuickMessageTemplateOrderTypeEnum? orderType,
    String? locale,
    bool isActive,
    int displayOrder,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfInsertQuickMessageTemplate.copyWith(...)` or call `instanceOfInsertQuickMessageTemplate.copyWith.fieldName(value)` for a single field.
class _$InsertQuickMessageTemplateCWProxyImpl
    implements _$InsertQuickMessageTemplateCWProxy {
  const _$InsertQuickMessageTemplateCWProxyImpl(this._value);

  final InsertQuickMessageTemplate _value;

  @override
  InsertQuickMessageTemplate role(InsertQuickMessageTemplateRoleEnum role) =>
      call(role: role);

  @override
  InsertQuickMessageTemplate message(String message) => call(message: message);

  @override
  InsertQuickMessageTemplate orderType(
    InsertQuickMessageTemplateOrderTypeEnum? orderType,
  ) => call(orderType: orderType);

  @override
  InsertQuickMessageTemplate locale(String? locale) => call(locale: locale);

  @override
  InsertQuickMessageTemplate isActive(bool isActive) =>
      call(isActive: isActive);

  @override
  InsertQuickMessageTemplate displayOrder(int displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `InsertQuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// InsertQuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  InsertQuickMessageTemplate call({
    Object? role = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
  }) {
    return InsertQuickMessageTemplate(
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as InsertQuickMessageTemplateRoleEnum,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as InsertQuickMessageTemplateOrderTypeEnum?,
      locale: locale == const $CopyWithPlaceholder()
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String?,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      displayOrder:
          displayOrder == const $CopyWithPlaceholder() || displayOrder == null
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
    );
  }
}

extension $InsertQuickMessageTemplateCopyWith on InsertQuickMessageTemplate {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfInsertQuickMessageTemplate.copyWith(...)` or `instanceOfInsertQuickMessageTemplate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertQuickMessageTemplateCWProxy get copyWith =>
      _$InsertQuickMessageTemplateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertQuickMessageTemplate _$InsertQuickMessageTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('InsertQuickMessageTemplate', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'role',
      'message',
      'orderType',
      'isActive',
      'displayOrder',
    ],
  );
  final val = InsertQuickMessageTemplate(
    role: $checkedConvert(
      'role',
      (v) => $enumDecode(_$InsertQuickMessageTemplateRoleEnumEnumMap, v),
    ),
    message: $checkedConvert('message', (v) => v as String),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecodeNullable(
        _$InsertQuickMessageTemplateOrderTypeEnumEnumMap,
        v,
      ),
    ),
    locale: $checkedConvert('locale', (v) => v as String? ?? 'en'),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    displayOrder: $checkedConvert('displayOrder', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$InsertQuickMessageTemplateToJson(
  InsertQuickMessageTemplate instance,
) => <String, dynamic>{
  'role': _$InsertQuickMessageTemplateRoleEnumEnumMap[instance.role]!,
  'message': instance.message,
  'orderType':
      _$InsertQuickMessageTemplateOrderTypeEnumEnumMap[instance.orderType],
  'locale': ?instance.locale,
  'isActive': instance.isActive,
  'displayOrder': instance.displayOrder,
};

const _$InsertQuickMessageTemplateRoleEnumEnumMap = {
  InsertQuickMessageTemplateRoleEnum.ADMIN: 'ADMIN',
  InsertQuickMessageTemplateRoleEnum.OPERATOR: 'OPERATOR',
  InsertQuickMessageTemplateRoleEnum.MERCHANT: 'MERCHANT',
  InsertQuickMessageTemplateRoleEnum.DRIVER: 'DRIVER',
  InsertQuickMessageTemplateRoleEnum.USER: 'USER',
};

const _$InsertQuickMessageTemplateOrderTypeEnumEnumMap = {
  InsertQuickMessageTemplateOrderTypeEnum.RIDE: 'RIDE',
  InsertQuickMessageTemplateOrderTypeEnum.DELIVERY: 'DELIVERY',
  InsertQuickMessageTemplateOrderTypeEnum.FOOD: 'FOOD',
};
