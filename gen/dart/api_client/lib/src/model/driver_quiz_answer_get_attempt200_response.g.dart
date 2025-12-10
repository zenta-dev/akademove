// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_get_attempt200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerGetAttempt200ResponseCWProxy {
  DriverQuizAnswerGetAttempt200Response message(String? message);

  DriverQuizAnswerGetAttempt200Response data(DriverQuizAnswer data);

  DriverQuizAnswerGetAttempt200Response pagination(
    PaginationResult? pagination,
  );

  DriverQuizAnswerGetAttempt200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerGetAttempt200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerGetAttempt200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerGetAttempt200Response call({
    String? message,
    DriverQuizAnswer data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerGetAttempt200Response.copyWith(...)` or call `instanceOfDriverQuizAnswerGetAttempt200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerGetAttempt200ResponseCWProxyImpl
    implements _$DriverQuizAnswerGetAttempt200ResponseCWProxy {
  const _$DriverQuizAnswerGetAttempt200ResponseCWProxyImpl(this._value);

  final DriverQuizAnswerGetAttempt200Response _value;

  @override
  DriverQuizAnswerGetAttempt200Response message(String? message) =>
      call(message: message);

  @override
  DriverQuizAnswerGetAttempt200Response data(DriverQuizAnswer data) =>
      call(data: data);

  @override
  DriverQuizAnswerGetAttempt200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizAnswerGetAttempt200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerGetAttempt200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerGetAttempt200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerGetAttempt200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerGetAttempt200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizAnswer,
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

extension $DriverQuizAnswerGetAttempt200ResponseCopyWith
    on DriverQuizAnswerGetAttempt200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerGetAttempt200Response.copyWith(...)` or `instanceOfDriverQuizAnswerGetAttempt200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerGetAttempt200ResponseCWProxy get copyWith =>
      _$DriverQuizAnswerGetAttempt200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerGetAttempt200Response
_$DriverQuizAnswerGetAttempt200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAnswerGetAttempt200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverQuizAnswerGetAttempt200Response(
        message: $checkedConvert('message', (v) => v as String?),
        data: $checkedConvert(
          'data',
          (v) => DriverQuizAnswer.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$DriverQuizAnswerGetAttempt200ResponseToJson(
  DriverQuizAnswerGetAttempt200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
