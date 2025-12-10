// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_get_user_profile200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudGetUserProfile200ResponseCWProxy {
  FraudGetUserProfile200Response message(String? message);

  FraudGetUserProfile200Response data(UserFraudProfile? data);

  FraudGetUserProfile200Response pagination(PaginationResult? pagination);

  FraudGetUserProfile200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetUserProfile200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetUserProfile200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetUserProfile200Response call({
    String? message,
    UserFraudProfile? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudGetUserProfile200Response.copyWith(...)` or call `instanceOfFraudGetUserProfile200Response.copyWith.fieldName(value)` for a single field.
class _$FraudGetUserProfile200ResponseCWProxyImpl
    implements _$FraudGetUserProfile200ResponseCWProxy {
  const _$FraudGetUserProfile200ResponseCWProxyImpl(this._value);

  final FraudGetUserProfile200Response _value;

  @override
  FraudGetUserProfile200Response message(String? message) =>
      call(message: message);

  @override
  FraudGetUserProfile200Response data(UserFraudProfile? data) =>
      call(data: data);

  @override
  FraudGetUserProfile200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  FraudGetUserProfile200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudGetUserProfile200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudGetUserProfile200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudGetUserProfile200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return FraudGetUserProfile200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as UserFraudProfile?,
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

extension $FraudGetUserProfile200ResponseCopyWith
    on FraudGetUserProfile200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudGetUserProfile200Response.copyWith(...)` or `instanceOfFraudGetUserProfile200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudGetUserProfile200ResponseCWProxy get copyWith =>
      _$FraudGetUserProfile200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudGetUserProfile200Response _$FraudGetUserProfile200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudGetUserProfile200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = FraudGetUserProfile200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => v == null
          ? null
          : UserFraudProfile.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$FraudGetUserProfile200ResponseToJson(
  FraudGetUserProfile200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data?.toJson(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
