// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_driver_quiz_question_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListDriverQuizQuestionQueryCWProxy {
  ListDriverQuizQuestionQuery category(DriverQuizQuestionCategory? category);

  ListDriverQuizQuestionQuery type(DriverQuizQuestionType? type);

  ListDriverQuizQuestionQuery isActive(bool? isActive);

  ListDriverQuizQuestionQuery page(int? page);

  ListDriverQuizQuestionQuery limit(int? limit);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizQuestionQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizQuestionQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizQuestionQuery call({
    DriverQuizQuestionCategory? category,
    DriverQuizQuestionType? type,
    bool? isActive,
    int? page,
    int? limit,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfListDriverQuizQuestionQuery.copyWith(...)` or call `instanceOfListDriverQuizQuestionQuery.copyWith.fieldName(value)` for a single field.
class _$ListDriverQuizQuestionQueryCWProxyImpl
    implements _$ListDriverQuizQuestionQueryCWProxy {
  const _$ListDriverQuizQuestionQueryCWProxyImpl(this._value);

  final ListDriverQuizQuestionQuery _value;

  @override
  ListDriverQuizQuestionQuery category(DriverQuizQuestionCategory? category) =>
      call(category: category);

  @override
  ListDriverQuizQuestionQuery type(DriverQuizQuestionType? type) =>
      call(type: type);

  @override
  ListDriverQuizQuestionQuery isActive(bool? isActive) =>
      call(isActive: isActive);

  @override
  ListDriverQuizQuestionQuery page(int? page) => call(page: page);

  @override
  ListDriverQuizQuestionQuery limit(int? limit) => call(limit: limit);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizQuestionQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizQuestionQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizQuestionQuery call({
    Object? category = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
  }) {
    return ListDriverQuizQuestionQuery(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as DriverQuizQuestionCategory?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as DriverQuizQuestionType?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      page: page == const $CopyWithPlaceholder()
          ? _value.page
          // ignore: cast_nullable_to_non_nullable
          : page as int?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as int?,
    );
  }
}

extension $ListDriverQuizQuestionQueryCopyWith on ListDriverQuizQuestionQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfListDriverQuizQuestionQuery.copyWith(...)` or `instanceOfListDriverQuizQuestionQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListDriverQuizQuestionQueryCWProxy get copyWith =>
      _$ListDriverQuizQuestionQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDriverQuizQuestionQuery _$ListDriverQuizQuestionQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ListDriverQuizQuestionQuery', json, ($checkedConvert) {
  final val = ListDriverQuizQuestionQuery(
    category: $checkedConvert(
      'category',
      (v) => $enumDecodeNullable(_$DriverQuizQuestionCategoryEnumMap, v),
    ),
    type: $checkedConvert(
      'type',
      (v) => $enumDecodeNullable(_$DriverQuizQuestionTypeEnumMap, v),
    ),
    isActive: $checkedConvert('isActive', (v) => v as bool?),
    page: $checkedConvert('page', (v) => (v as num?)?.toInt()),
    limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ListDriverQuizQuestionQueryToJson(
  ListDriverQuizQuestionQuery instance,
) => <String, dynamic>{
  'category': ?_$DriverQuizQuestionCategoryEnumMap[instance.category],
  'type': ?_$DriverQuizQuestionTypeEnumMap[instance.type],
  'isActive': ?instance.isActive,
  'page': ?instance.page,
  'limit': ?instance.limit,
};

const _$DriverQuizQuestionCategoryEnumMap = {
  DriverQuizQuestionCategory.SAFETY: 'SAFETY',
  DriverQuizQuestionCategory.NAVIGATION: 'NAVIGATION',
  DriverQuizQuestionCategory.CUSTOMER_SERVICE: 'CUSTOMER_SERVICE',
  DriverQuizQuestionCategory.PLATFORM_RULES: 'PLATFORM_RULES',
  DriverQuizQuestionCategory.EMERGENCY_PROCEDURES: 'EMERGENCY_PROCEDURES',
  DriverQuizQuestionCategory.VEHICLE_MAINTENANCE: 'VEHICLE_MAINTENANCE',
  DriverQuizQuestionCategory.GENERAL: 'GENERAL',
};

const _$DriverQuizQuestionTypeEnumMap = {
  DriverQuizQuestionType.MULTIPLE_CHOICE: 'MULTIPLE_CHOICE',
  DriverQuizQuestionType.TRUE_FALSE: 'TRUE_FALSE',
};
