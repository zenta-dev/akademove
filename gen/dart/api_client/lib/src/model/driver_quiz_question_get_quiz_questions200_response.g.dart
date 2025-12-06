// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_get_quiz_questions200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxy {
  DriverQuizQuestionGetQuizQuestions200Response message(String message);

  DriverQuizQuestionGetQuizQuestions200Response data(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> data,
  );

  DriverQuizQuestionGetQuizQuestions200Response pagination(
    PaginationResult? pagination,
  );

  DriverQuizQuestionGetQuizQuestions200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200Response call({
    String message,
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionGetQuizQuestions200Response.copyWith(...)` or call `instanceOfDriverQuizQuestionGetQuizQuestions200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxyImpl
    implements _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxy {
  const _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxyImpl(this._value);

  final DriverQuizQuestionGetQuizQuestions200Response _value;

  @override
  DriverQuizQuestionGetQuizQuestions200Response message(String message) =>
      call(message: message);

  @override
  DriverQuizQuestionGetQuizQuestions200Response data(
    List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> data,
  ) => call(data: data);

  @override
  DriverQuizQuestionGetQuizQuestions200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizQuestionGetQuizQuestions200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionGetQuizQuestions200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionGetQuizQuestions200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionGetQuizQuestions200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionGetQuizQuestions200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data
                as List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner>,
      pagination: pagination == const $CopyWithPlaceholder()
          ? _value.pagination
          // ignore: cast_nullable_to_non_nullable
          : pagination as PaginationResult?,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $DriverQuizQuestionGetQuizQuestions200ResponseCopyWith
    on DriverQuizQuestionGetQuizQuestions200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionGetQuizQuestions200Response.copyWith(...)` or `instanceOfDriverQuizQuestionGetQuizQuestions200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxy get copyWith =>
      _$DriverQuizQuestionGetQuizQuestions200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionGetQuizQuestions200Response
_$DriverQuizQuestionGetQuizQuestions200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizQuestionGetQuizQuestions200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverQuizQuestionGetQuizQuestions200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                DriverQuizQuestionGetQuizQuestions200ResponseDataInner.fromJson(
                  e as Map<String, dynamic>,
                ),
          )
          .toList(),
    ),
    pagination: $checkedConvert(
      'pagination',
      (v) => v == null
          ? null
          : PaginationResult.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$DriverQuizQuestionGetQuizQuestions200ResponseToJson(
  DriverQuizQuestionGetQuizQuestions200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
