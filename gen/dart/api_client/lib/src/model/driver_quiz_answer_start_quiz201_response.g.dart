// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_start_quiz201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerStartQuiz201ResponseCWProxy {
  DriverQuizAnswerStartQuiz201Response message(String message);

  DriverQuizAnswerStartQuiz201Response data(DriverQuizAttempt data);

  DriverQuizAnswerStartQuiz201Response pagination(PaginationResult? pagination);

  DriverQuizAnswerStartQuiz201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerStartQuiz201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerStartQuiz201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerStartQuiz201Response call({
    String message,
    DriverQuizAttempt data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerStartQuiz201Response.copyWith(...)` or call `instanceOfDriverQuizAnswerStartQuiz201Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerStartQuiz201ResponseCWProxyImpl
    implements _$DriverQuizAnswerStartQuiz201ResponseCWProxy {
  const _$DriverQuizAnswerStartQuiz201ResponseCWProxyImpl(this._value);

  final DriverQuizAnswerStartQuiz201Response _value;

  @override
  DriverQuizAnswerStartQuiz201Response message(String message) =>
      call(message: message);

  @override
  DriverQuizAnswerStartQuiz201Response data(DriverQuizAttempt data) =>
      call(data: data);

  @override
  DriverQuizAnswerStartQuiz201Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizAnswerStartQuiz201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerStartQuiz201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerStartQuiz201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerStartQuiz201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerStartQuiz201Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizAttempt,
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

extension $DriverQuizAnswerStartQuiz201ResponseCopyWith
    on DriverQuizAnswerStartQuiz201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerStartQuiz201Response.copyWith(...)` or `instanceOfDriverQuizAnswerStartQuiz201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerStartQuiz201ResponseCWProxy get copyWith =>
      _$DriverQuizAnswerStartQuiz201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerStartQuiz201Response
_$DriverQuizAnswerStartQuiz201ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAnswerStartQuiz201Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverQuizAnswerStartQuiz201Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => DriverQuizAttempt.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverQuizAnswerStartQuiz201ResponseToJson(
  DriverQuizAnswerStartQuiz201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
