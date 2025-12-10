// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_delete200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ContactDelete200ResponseCWProxy {
  ContactDelete200Response message(String? message);

  ContactDelete200Response data(Object? data);

  ContactDelete200Response pagination(PaginationResult? pagination);

  ContactDelete200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactDelete200Response call({
    String? message,
    Object? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfContactDelete200Response.copyWith(...)` or call `instanceOfContactDelete200Response.copyWith.fieldName(value)` for a single field.
class _$ContactDelete200ResponseCWProxyImpl
    implements _$ContactDelete200ResponseCWProxy {
  const _$ContactDelete200ResponseCWProxyImpl(this._value);

  final ContactDelete200Response _value;

  @override
  ContactDelete200Response message(String? message) => call(message: message);

  @override
  ContactDelete200Response data(Object? data) => call(data: data);

  @override
  ContactDelete200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  ContactDelete200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ContactDelete200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ContactDelete200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  ContactDelete200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return ContactDelete200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Object?,
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

extension $ContactDelete200ResponseCopyWith on ContactDelete200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfContactDelete200Response.copyWith(...)` or `instanceOfContactDelete200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ContactDelete200ResponseCWProxy get copyWith =>
      _$ContactDelete200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDelete200Response _$ContactDelete200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContactDelete200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = ContactDelete200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert('data', (v) => v),
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

Map<String, dynamic> _$ContactDelete200ResponseToJson(
  ContactDelete200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
