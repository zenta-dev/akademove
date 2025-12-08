// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_submit_answer200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerSubmitAnswer200ResponseCWProxy {
  DriverQuizAnswerSubmitAnswer200Response message(String message);

  DriverQuizAnswerSubmitAnswer200Response data(
    SubmitDriverQuizAnswerResponse data,
  );

  DriverQuizAnswerSubmitAnswer200Response pagination(
    PaginationResult? pagination,
  );

  DriverQuizAnswerSubmitAnswer200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerSubmitAnswer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerSubmitAnswer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerSubmitAnswer200Response call({
    String message,
    SubmitDriverQuizAnswerResponse data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerSubmitAnswer200Response.copyWith(...)` or call `instanceOfDriverQuizAnswerSubmitAnswer200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerSubmitAnswer200ResponseCWProxyImpl
    implements _$DriverQuizAnswerSubmitAnswer200ResponseCWProxy {
  const _$DriverQuizAnswerSubmitAnswer200ResponseCWProxyImpl(this._value);

  final DriverQuizAnswerSubmitAnswer200Response _value;

  @override
  DriverQuizAnswerSubmitAnswer200Response message(String message) =>
      call(message: message);

  @override
  DriverQuizAnswerSubmitAnswer200Response data(
    SubmitDriverQuizAnswerResponse data,
  ) => call(data: data);

  @override
  DriverQuizAnswerSubmitAnswer200Response pagination(
    PaginationResult? pagination,
  ) => call(pagination: pagination);

  @override
  DriverQuizAnswerSubmitAnswer200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerSubmitAnswer200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerSubmitAnswer200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerSubmitAnswer200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerSubmitAnswer200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as SubmitDriverQuizAnswerResponse,
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

extension $DriverQuizAnswerSubmitAnswer200ResponseCopyWith
    on DriverQuizAnswerSubmitAnswer200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerSubmitAnswer200Response.copyWith(...)` or `instanceOfDriverQuizAnswerSubmitAnswer200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerSubmitAnswer200ResponseCWProxy get copyWith =>
      _$DriverQuizAnswerSubmitAnswer200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerSubmitAnswer200Response
_$DriverQuizAnswerSubmitAnswer200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DriverQuizAnswerSubmitAnswer200Response', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = DriverQuizAnswerSubmitAnswer200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => SubmitDriverQuizAnswerResponse.fromJson(
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

Map<String, dynamic> _$DriverQuizAnswerSubmitAnswer200ResponseToJson(
  DriverQuizAnswerSubmitAnswer200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
