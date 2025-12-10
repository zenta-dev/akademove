// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broadcast_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BroadcastList200ResponseCWProxy {
  BroadcastList200Response message(String? message);

  BroadcastList200Response data(List<BroadcastList200ResponseDataInner> data);

  BroadcastList200Response pagination(PaginationResult? pagination);

  BroadcastList200Response totalPages(int? totalPages);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastList200Response call({
    String? message,
    List<BroadcastList200ResponseDataInner> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfBroadcastList200Response.copyWith(...)` or call `instanceOfBroadcastList200Response.copyWith.fieldName(value)` for a single field.
class _$BroadcastList200ResponseCWProxyImpl
    implements _$BroadcastList200ResponseCWProxy {
  const _$BroadcastList200ResponseCWProxyImpl(this._value);

  final BroadcastList200Response _value;

  @override
  BroadcastList200Response message(String? message) => call(message: message);

  @override
  BroadcastList200Response data(List<BroadcastList200ResponseDataInner> data) =>
      call(data: data);

  @override
  BroadcastList200Response pagination(PaginationResult? pagination) =>
      call(pagination: pagination);

  @override
  BroadcastList200Response totalPages(int? totalPages) =>
      call(totalPages: totalPages);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `BroadcastList200Response(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// BroadcastList200Response(...).copyWith(id: 12, name: "My name")
  /// ```
  BroadcastList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BroadcastList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      data: data == const $CopyWithPlaceholder() || data == null
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<BroadcastList200ResponseDataInner>,
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

extension $BroadcastList200ResponseCopyWith on BroadcastList200Response {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfBroadcastList200Response.copyWith(...)` or `instanceOfBroadcastList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BroadcastList200ResponseCWProxy get copyWith =>
      _$BroadcastList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BroadcastList200Response _$BroadcastList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BroadcastList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BroadcastList200Response(
    message: $checkedConvert('message', (v) => v as String?),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map(
            (e) => BroadcastList200ResponseDataInner.fromJson(
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

Map<String, dynamic> _$BroadcastList200ResponseToJson(
  BroadcastList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
