// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_create201_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionCreate201ResponseCWProxy {
  DriverQuizQuestionCreate201Response message(String? message);

  DriverQuizQuestionCreate201Response data(DriverQuizQuestion data);

  DriverQuizQuestionCreate201Response pagination(PaginationResult? pagination);

  DriverQuizQuestionCreate201Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionCreate201Response call({
    String? message,
    DriverQuizQuestion data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionCreate201Response.copyWith(...)` or call `instanceOfDriverQuizQuestionCreate201Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionCreate201ResponseCWProxyImpl
    implements _$DriverQuizQuestionCreate201ResponseCWProxy {
  const _$DriverQuizQuestionCreate201ResponseCWProxyImpl(this._value);

  final DriverQuizQuestionCreate201Response _value;

  @override
  DriverQuizQuestionCreate201Response message(String? message) =>
      call(message: message);

  @override
  DriverQuizQuestionCreate201Response data(DriverQuizQuestion data) =>
      call(data: data);

  @override
  DriverQuizQuestionCreate201Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizQuestionCreate201Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionCreate201Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionCreate201Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionCreate201Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionCreate201Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizQuestion,
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

extension $DriverQuizQuestionCreate201ResponseCopyWith
    on DriverQuizQuestionCreate201Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionCreate201Response.copyWith(...)` or `instanceOfDriverQuizQuestionCreate201Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionCreate201ResponseCWProxy get copyWith =>
      _$DriverQuizQuestionCreate201ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionCreate201Response
_$DriverQuizQuestionCreate201ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizQuestionCreate201Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverQuizQuestionCreate201Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => DriverQuizQuestion.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverQuizQuestionCreate201ResponseToJson(
  DriverQuizQuestionCreate201Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
