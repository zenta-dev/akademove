// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_message_template.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuickMessageTemplateCWProxy {
  QuickMessageTemplate id(String id);

  QuickMessageTemplate role(QuickMessageTemplateRoleEnum role);

  QuickMessageTemplate message(String message);

  QuickMessageTemplate orderType(QuickMessageTemplateOrderTypeEnum? orderType);

  QuickMessageTemplate locale(String? locale);

  QuickMessageTemplate isActive(bool isActive);

  QuickMessageTemplate displayOrder(int displayOrder);

  QuickMessageTemplate createdAt(DateTime createdAt);

  QuickMessageTemplate updatedAt(DateTime updatedAt);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageTemplate call({
    String id,
    QuickMessageTemplateRoleEnum role,
    String message,
    QuickMessageTemplateOrderTypeEnum? orderType,
    String? locale,
    bool isActive,
    int displayOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfQuickMessageTemplate.copyWith(...)` or call `instanceOfQuickMessageTemplate.copyWith.fieldName(value)` for a single field.
class _$QuickMessageTemplateCWProxyImpl
    implements _$QuickMessageTemplateCWProxy {
  const _$QuickMessageTemplateCWProxyImpl(this._value);

  final QuickMessageTemplate _value;

  @override
  QuickMessageTemplate id(String id) => call(id: id);

  @override
  QuickMessageTemplate role(QuickMessageTemplateRoleEnum role) =>
      call(role: role);

  @override
  QuickMessageTemplate message(String message) => call(message: message);

  @override
  QuickMessageTemplate orderType(
    QuickMessageTemplateOrderTypeEnum? orderType,
  ) => call(orderType: orderType);

  @override
  QuickMessageTemplate locale(String? locale) => call(locale: locale);

  @override
  QuickMessageTemplate isActive(bool isActive) => call(isActive: isActive);

  @override
  QuickMessageTemplate displayOrder(int displayOrder) =>
      call(displayOrder: displayOrder);

  @override
  QuickMessageTemplate createdAt(DateTime createdAt) =>
      call(createdAt: createdAt);

  @override
  QuickMessageTemplate updatedAt(DateTime updatedAt) =>
      call(updatedAt: updatedAt);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `QuickMessageTemplate(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// QuickMessageTemplate(...).copyWith(id: 12, name: "My name")
  /// ```
  QuickMessageTemplate call({
    Object? id = const $CopyWithPlaceholder(),
    Object? role = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return QuickMessageTemplate(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      role: role == const $CopyWithPlaceholder() || role == null
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as QuickMessageTemplateRoleEnum,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as QuickMessageTemplateOrderTypeEnum?,
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
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      updatedAt: updatedAt == const $CopyWithPlaceholder() || updatedAt == null
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $QuickMessageTemplateCopyWith on QuickMessageTemplate {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfQuickMessageTemplate.copyWith(...)` or `instanceOfQuickMessageTemplate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuickMessageTemplateCWProxy get copyWith =>
      _$QuickMessageTemplateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuickMessageTemplate _$QuickMessageTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('QuickMessageTemplate', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'role',
      'message',
      'orderType',
      'isActive',
      'displayOrder',
      'createdAt',
      'updatedAt',
    ],
  );
  final val = QuickMessageTemplate(
    id: $checkedConvert('id', (v) => v as String),
    role: $checkedConvert(
      'role',
      (v) => $enumDecode(_$QuickMessageTemplateRoleEnumEnumMap, v),
    ),
    message: $checkedConvert('message', (v) => v as String),
    orderType: $checkedConvert(
      'orderType',
      (v) => $enumDecodeNullable(_$QuickMessageTemplateOrderTypeEnumEnumMap, v),
    ),
    locale: $checkedConvert('locale', (v) => v as String? ?? 'en'),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    displayOrder: $checkedConvert('displayOrder', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$QuickMessageTemplateToJson(
  QuickMessageTemplate instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': _$QuickMessageTemplateRoleEnumEnumMap[instance.role]!,
  'message': instance.message,
  'orderType': _$QuickMessageTemplateOrderTypeEnumEnumMap[instance.orderType],
  'locale': ?instance.locale,
  'isActive': instance.isActive,
  'displayOrder': instance.displayOrder,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$QuickMessageTemplateRoleEnumEnumMap = {
  QuickMessageTemplateRoleEnum.ADMIN: 'ADMIN',
  QuickMessageTemplateRoleEnum.OPERATOR: 'OPERATOR',
  QuickMessageTemplateRoleEnum.MERCHANT: 'MERCHANT',
  QuickMessageTemplateRoleEnum.DRIVER: 'DRIVER',
  QuickMessageTemplateRoleEnum.USER: 'USER',
};

const _$QuickMessageTemplateOrderTypeEnumEnumMap = {
  QuickMessageTemplateOrderTypeEnum.RIDE: 'RIDE',
  QuickMessageTemplateOrderTypeEnum.DELIVERY: 'DELIVERY',
  QuickMessageTemplateOrderTypeEnum.FOOD: 'FOOD',
};
