// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fraud_list_high_risk_users200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FraudListHighRiskUsers200ResponseCWProxy {
  FraudListHighRiskUsers200Response message(String? message);

  FraudListHighRiskUsers200Response data(List<UserFraudProfile> data);

  FraudListHighRiskUsers200Response pagination(PaginationResult? pagination);

  FraudListHighRiskUsers200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudListHighRiskUsers200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudListHighRiskUsers200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudListHighRiskUsers200Response call({
    String? message,
    List<UserFraudProfile> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFraudListHighRiskUsers200Response.copyWith(...)` or call `instanceOfFraudListHighRiskUsers200Response.copyWith.fieldName(value)` for a single field.
class _$FraudListHighRiskUsers200ResponseCWProxyImpl
    implements _$FraudListHighRiskUsers200ResponseCWProxy {
  const _$FraudListHighRiskUsers200ResponseCWProxyImpl(this._value);

  final FraudListHighRiskUsers200Response _value;

  @override
  FraudListHighRiskUsers200Response message(String? message) =>
      call(message: message);

  @override
  FraudListHighRiskUsers200Response data(List<UserFraudProfile> data) =>
      call(data: data);

  @override
  FraudListHighRiskUsers200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  FraudListHighRiskUsers200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FraudListHighRiskUsers200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FraudListHighRiskUsers200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  FraudListHighRiskUsers200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return FraudListHighRiskUsers200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<UserFraudProfile>,
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

extension $FraudListHighRiskUsers200ResponseCopyWith
    on FraudListHighRiskUsers200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFraudListHighRiskUsers200Response.copyWith(...)` or `instanceOfFraudListHighRiskUsers200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FraudListHighRiskUsers200ResponseCWProxy get copyWith =>
      _$FraudListHighRiskUsers200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FraudListHighRiskUsers200Response _$FraudListHighRiskUsers200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('FraudListHighRiskUsers200Response', json, (
  $checkedConvert,
) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = FraudListHighRiskUsers200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => UserFraudProfile.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$FraudListHighRiskUsers200ResponseToJson(
  FraudListHighRiskUsers200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
