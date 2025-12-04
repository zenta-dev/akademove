// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_quick_message_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListQuickMessageQueryCWProxy {
  ListQuickMessageQuery role(ListQuickMessageQueryRoleEnum? role);

  ListQuickMessageQuery orderType(
    ListQuickMessageQueryOrderTypeEnum? orderType,
  );

  ListQuickMessageQuery locale(String? locale);

  ListQuickMessageQuery isActive(bool? isActive);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListQuickMessageQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListQuickMessageQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListQuickMessageQuery call({
    ListQuickMessageQueryRoleEnum? role,
    ListQuickMessageQueryOrderTypeEnum? orderType,
    String? locale,
    bool? isActive,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfListQuickMessageQuery.copyWith(...)` or call `instanceOfListQuickMessageQuery.copyWith.fieldName(value)` for a single field.
class _$ListQuickMessageQueryCWProxyImpl
    implements _$ListQuickMessageQueryCWProxy {
  const _$ListQuickMessageQueryCWProxyImpl(this._value);

  final ListQuickMessageQuery _value;

  @override
  ListQuickMessageQuery role(ListQuickMessageQueryRoleEnum? role) =>
      call(role: role);

  @override
  ListQuickMessageQuery orderType(
    ListQuickMessageQueryOrderTypeEnum? orderType,
  ) => call(orderType: orderType);

  @override
  ListQuickMessageQuery locale(String? locale) => call(locale: locale);

  @override
  ListQuickMessageQuery isActive(bool? isActive) => call(isActive: isActive);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListQuickMessageQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListQuickMessageQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListQuickMessageQuery call({
    Object? role = const $CopyWithPlaceholder(),
    Object? orderType = const $CopyWithPlaceholder(),
    Object? locale = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
  }) {
    return ListQuickMessageQuery(
      role: role == const $CopyWithPlaceholder()
          ? _value.role
          // ignore: cast_nullable_to_non_nullable
          : role as ListQuickMessageQueryRoleEnum?,
      orderType: orderType == const $CopyWithPlaceholder()
          ? _value.orderType
          // ignore: cast_nullable_to_non_nullable
          : orderType as ListQuickMessageQueryOrderTypeEnum?,
      locale: locale == const $CopyWithPlaceholder()
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
    );
  }
}

extension $ListQuickMessageQueryCopyWith on ListQuickMessageQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfListQuickMessageQuery.copyWith(...)` or `instanceOfListQuickMessageQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListQuickMessageQueryCWProxy get copyWith =>
      _$ListQuickMessageQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListQuickMessageQuery _$ListQuickMessageQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ListQuickMessageQuery', json, ($checkedConvert) {
  final val = ListQuickMessageQuery(
    role: $checkedConvert(
      'role',
      (v) => $enumDecodeNullable(_$ListQuickMessageQueryRoleEnumEnumMap, v),
    ),
    orderType: $checkedConvert(
      'orderType',
      (v) =>
          $enumDecodeNullable(_$ListQuickMessageQueryOrderTypeEnumEnumMap, v),
    ),
    locale: $checkedConvert('locale', (v) => v as String?),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$ListQuickMessageQueryToJson(
  ListQuickMessageQuery instance,
) => <String, dynamic>{
  'role': ?_$ListQuickMessageQueryRoleEnumEnumMap[instance.role],
  'orderType': ?_$ListQuickMessageQueryOrderTypeEnumEnumMap[instance.orderType],
  'locale': ?instance.locale,
  'isActive': ?instance.isActive,
};

const _$ListQuickMessageQueryRoleEnumEnumMap = {
  ListQuickMessageQueryRoleEnum.ADMIN: 'ADMIN',
  ListQuickMessageQueryRoleEnum.OPERATOR: 'OPERATOR',
  ListQuickMessageQueryRoleEnum.MERCHANT: 'MERCHANT',
  ListQuickMessageQueryRoleEnum.DRIVER: 'DRIVER',
  ListQuickMessageQueryRoleEnum.USER: 'USER',
};

const _$ListQuickMessageQueryOrderTypeEnumEnumMap = {
  ListQuickMessageQueryOrderTypeEnum.RIDE: 'RIDE',
  ListQuickMessageQueryOrderTypeEnum.DELIVERY: 'DELIVERY',
  ListQuickMessageQueryOrderTypeEnum.FOOD: 'FOOD',
};
