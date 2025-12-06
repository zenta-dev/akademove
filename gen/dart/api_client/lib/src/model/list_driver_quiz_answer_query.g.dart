// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_driver_quiz_answer_query.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListDriverQuizAnswerQueryCWProxy {
  ListDriverQuizAnswerQuery driverId(String? driverId);

  ListDriverQuizAnswerQuery status(DriverQuizAnswerStatus? status);

  ListDriverQuizAnswerQuery page(int? page);

  ListDriverQuizAnswerQuery limit(int? limit);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizAnswerQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizAnswerQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizAnswerQuery call({
    String? driverId,
    DriverQuizAnswerStatus? status,
    int? page,
    int? limit,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfListDriverQuizAnswerQuery.copyWith(...)` or call `instanceOfListDriverQuizAnswerQuery.copyWith.fieldName(value)` for a single field.
class _$ListDriverQuizAnswerQueryCWProxyImpl
    implements _$ListDriverQuizAnswerQueryCWProxy {
  const _$ListDriverQuizAnswerQueryCWProxyImpl(this._value);

  final ListDriverQuizAnswerQuery _value;

  @override
  ListDriverQuizAnswerQuery driverId(String? driverId) =>
      call(driverId: driverId);

  @override
  ListDriverQuizAnswerQuery status(DriverQuizAnswerStatus? status) =>
      call(status: status);

  @override
  ListDriverQuizAnswerQuery page(int? page) => call(page: page);

  @override
  ListDriverQuizAnswerQuery limit(int? limit) => call(limit: limit);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ListDriverQuizAnswerQuery(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ListDriverQuizAnswerQuery(...).copyWith(id: 12, name: "My name")
  /// ```
  ListDriverQuizAnswerQuery call({
    Object? driverId = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? page = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
  }) {
    return ListDriverQuizAnswerQuery(
      driverId: driverId == const $CopyWithPlaceholder()
          ? _value.driverId
          // ignore: cast_nullable_to_non_nullable
          : driverId as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as DriverQuizAnswerStatus?,
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

extension $ListDriverQuizAnswerQueryCopyWith on ListDriverQuizAnswerQuery {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfListDriverQuizAnswerQuery.copyWith(...)` or `instanceOfListDriverQuizAnswerQuery.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListDriverQuizAnswerQueryCWProxy get copyWith =>
      _$ListDriverQuizAnswerQueryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDriverQuizAnswerQuery _$ListDriverQuizAnswerQueryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ListDriverQuizAnswerQuery', json, ($checkedConvert) {
  final val = ListDriverQuizAnswerQuery(
    driverId: $checkedConvert('driverId', (v) => v as String?),
    status: $checkedConvert(
      'status',
      (v) => $enumDecodeNullable(_$DriverQuizAnswerStatusEnumMap, v),
    ),
    page: $checkedConvert('page', (v) => (v as num?)?.toInt()),
    limit: $checkedConvert('limit', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$ListDriverQuizAnswerQueryToJson(
  ListDriverQuizAnswerQuery instance,
) => <String, dynamic>{
  'driverId': ?instance.driverId,
  'status': ?_$DriverQuizAnswerStatusEnumMap[instance.status],
  'page': ?instance.page,
  'limit': ?instance.limit,
};

const _$DriverQuizAnswerStatusEnumMap = {
  DriverQuizAnswerStatus.IN_PROGRESS: 'IN_PROGRESS',
  DriverQuizAnswerStatus.COMPLETED: 'COMPLETED',
  DriverQuizAnswerStatus.PASSED: 'PASSED',
  DriverQuizAnswerStatus.FAILED: 'FAILED',
};
