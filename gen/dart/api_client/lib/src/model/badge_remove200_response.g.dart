// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_remove200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeRemove200ResponseCWProxy {
  BadgeRemove200Response message(String message);

  BadgeRemove200Response data(Object? data);

  BadgeRemove200Response pagination(PaginationResult? pagination);

  BadgeRemove200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeRemove200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeRemove200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeRemove200Response call({
    String message,
    Object? data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeRemove200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeRemove200Response.copyWith.fieldName(...)`
class _$BadgeRemove200ResponseCWProxyImpl
    implements _$BadgeRemove200ResponseCWProxy {
  const _$BadgeRemove200ResponseCWProxyImpl(this._value);

  final BadgeRemove200Response _value;

  @override
  BadgeRemove200Response message(String message) => this(message: message);

  @override
  BadgeRemove200Response data(Object? data) => this(data: data);

  @override
  BadgeRemove200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  BadgeRemove200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeRemove200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeRemove200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeRemove200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeRemove200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
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

extension $BadgeRemove200ResponseCopyWith on BadgeRemove200Response {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeRemove200Response.copyWith(...)` or like so:`instanceOfBadgeRemove200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeRemove200ResponseCWProxy get copyWith =>
      _$BadgeRemove200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeRemove200Response _$BadgeRemove200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeRemove200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BadgeRemove200Response(
    message: $checkedConvert('message', (v) => v as String),
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

Map<String, dynamic> _$BadgeRemove200ResponseToJson(
  BadgeRemove200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
