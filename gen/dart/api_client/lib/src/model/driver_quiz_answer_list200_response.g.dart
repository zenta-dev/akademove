// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_quiz_answer_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DriverQuizAnswerList200ResponseCWProxy {
  DriverQuizAnswerList200Response message(String message);

  DriverQuizAnswerList200Response data(
    DriverQuizAnswerList200ResponseData data,
  );

  DriverQuizAnswerList200Response pagination(PaginationResult? pagination);

  DriverQuizAnswerList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerList200Response call({
    String message,
    DriverQuizAnswerList200ResponseData data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfDriverQuizAnswerList200Response.copyWith(...)` or call `instanceOfDriverQuizAnswerList200Response.copyWith.fieldName(value)` for a single field.
class _$DriverQuizAnswerList200ResponseCWProxyImpl
    implements _$DriverQuizAnswerList200ResponseCWProxy {
  const _$DriverQuizAnswerList200ResponseCWProxyImpl(this._value);

  final DriverQuizAnswerList200Response _value;

  @override
  DriverQuizAnswerList200Response message(String message) =>
      call(message: message);

  @override
  DriverQuizAnswerList200Response data(
    DriverQuizAnswerList200ResponseData data,
  ) => call(data: data);

  @override
  DriverQuizAnswerList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  DriverQuizAnswerList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `DriverQuizAnswerList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// DriverQuizAnswerList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  DriverQuizAnswerList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return DriverQuizAnswerList200Response(
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as DriverQuizAnswerList200ResponseData,
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

extension $DriverQuizAnswerList200ResponseCopyWith
    on DriverQuizAnswerList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfDriverQuizAnswerList200Response.copyWith(...)` or `instanceOfDriverQuizAnswerList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DriverQuizAnswerList200ResponseCWProxy get copyWith =>
      _$DriverQuizAnswerList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverQuizAnswerList200Response _$DriverQuizAnswerList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DriverQuizAnswerList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = DriverQuizAnswerList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => DriverQuizAnswerList200ResponseData.fromJson(
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

Map<String, dynamic> _$DriverQuizAnswerList200ResponseToJson(
  DriverQuizAnswerList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
