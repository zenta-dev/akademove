// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_complete_quiz200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerCompleteQuiz200ResponseCWProxy {
  DriverQuizAnswerCompleteQuiz200Response message(String message);

  DriverQuizAnswerCompleteQuiz200Response data(DriverQuizResult data);

  DriverQuizAnswerCompleteQuiz200Response pagination(
    PaginationResult? pagination,
  );

  DriverQuizAnswerCompleteQuiz200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerCompleteQuiz200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerCompleteQuiz200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerCompleteQuiz200Response call({
    String message,
    DriverQuizResult data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerCompleteQuiz200Response.copyWith(...)` or call `instanceOfDriverQuizAnswerCompleteQuiz200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerCompleteQuiz200ResponseCWProxyImpl
    implements _$DriverQuizAnswerCompleteQuiz200ResponseCWProxy {
  const _$DriverQuizAnswerCompleteQuiz200ResponseCWProxyImpl(this._value);

  final DriverQuizAnswerCompleteQuiz200Response _value;

  @override
  DriverQuizAnswerCompleteQuiz200Response message(String message) =>
      call(message: message);

  @override
  DriverQuizAnswerCompleteQuiz200Response data(DriverQuizResult data) =>
      call(data: data);

  @override
  DriverQuizAnswerCompleteQuiz200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizAnswerCompleteQuiz200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerCompleteQuiz200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerCompleteQuiz200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerCompleteQuiz200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerCompleteQuiz200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizResult,
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

extension $DriverQuizAnswerCompleteQuiz200ResponseCopyWith
    on DriverQuizAnswerCompleteQuiz200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerCompleteQuiz200Response.copyWith(...)` or `instanceOfDriverQuizAnswerCompleteQuiz200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerCompleteQuiz200ResponseCWProxy get copyWith =>
      _$DriverQuizAnswerCompleteQuiz200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerCompleteQuiz200Response
_$DriverQuizAnswerCompleteQuiz200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAnswerCompleteQuiz200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverQuizAnswerCompleteQuiz200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => DriverQuizResult.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverQuizAnswerCompleteQuiz200ResponseToJson(
  DriverQuizAnswerCompleteQuiz200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
