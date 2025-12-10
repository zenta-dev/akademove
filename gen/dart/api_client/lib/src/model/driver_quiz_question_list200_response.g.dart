// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_question_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizQuestionList200ResponseCWProxy {
  DriverQuizQuestionList200Response message(String message);

  DriverQuizQuestionList200Response data(
    DriverQuizQuestionList200ResponseData data,
  );

  DriverQuizQuestionList200Response pagination(PaginationResult? pagination);

  DriverQuizQuestionList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionList200Response call({
    String message,
    DriverQuizQuestionList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizQuestionList200Response.copyWith(...)` or call `instanceOfDriverQuizQuestionList200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizQuestionList200ResponseCWProxyImpl
    implements _$DriverQuizQuestionList200ResponseCWProxy {
  const _$DriverQuizQuestionList200ResponseCWProxyImpl(this._value);

  final DriverQuizQuestionList200Response _value;

  @override
  DriverQuizQuestionList200Response message(String message) =>
      call(message: message);

  @override
  DriverQuizQuestionList200Response data(
    DriverQuizQuestionList200ResponseData data,
  ) => call(data: data);

  @override
  DriverQuizQuestionList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverQuizQuestionList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizQuestionList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizQuestionList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizQuestionList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizQuestionList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizQuestionList200ResponseData,
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

extension $DriverQuizQuestionList200ResponseCopyWith
    on DriverQuizQuestionList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizQuestionList200Response.copyWith(...)` or `instanceOfDriverQuizQuestionList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizQuestionList200ResponseCWProxy get copyWith =>
      _$DriverQuizQuestionList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizQuestionList200Response _$DriverQuizQuestionList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizQuestionList200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverQuizQuestionList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => DriverQuizQuestionList200ResponseData.fromJson(
        v as Map<String, dynamic>,
      ),
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

Map<String, dynamic> _$DriverQuizQuestionList200ResponseToJson(
  DriverQuizQuestionList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
