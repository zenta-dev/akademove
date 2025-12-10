// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuditList200ResponseCWProxy {
  AuditList200Response message(String? message);

  AuditList200Response data(List<AuditList200ResponseDataInner> data);

  AuditList200Response pagination(PaginationResult? pagination);

  AuditList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditList200Response call({
    String? message,
    List<AuditList200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfAuditList200Response.copyWith(...)` or call `instanceOfAuditList200Response.copyWith.fieldName(value)` for a single field.
class _$AuditList200ResponseCWProxyImpl
    implements _$AuditList200ResponseCWProxy {
  const _$AuditList200ResponseCWProxyImpl(this._value);

  final AuditList200Response _value;

  @override
  AuditList200Response message(String? message) => call(message: message);

  @override
  AuditList200Response data(List<AuditList200ResponseDataInner> data) =>
      call(data: data);

  @override
  AuditList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  AuditList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `AuditList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// AuditList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  AuditList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuditList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<AuditList200ResponseDataInner>,
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

extension $AuditList200ResponseCopyWith on AuditList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfAuditList200Response.copyWith(...)` or `instanceOfAuditList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuditList200ResponseCWProxy get copyWith =>
      _$AuditList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditList200Response _$AuditList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuditList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuditList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) => AuditList200ResponseDataInner.fromJson(
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

Map<String, dynamic> _$AuditList200ResponseToJson(
  AuditList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
