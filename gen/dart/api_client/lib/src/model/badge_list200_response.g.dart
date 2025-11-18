// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeList200ResponseCWProxy {
  BadgeList200Response message(String message);

  BadgeList200Response data(List<Badge> data);

  BadgeList200Response pagination(PaginationResult? pagination);

  BadgeList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeList200Response call({
    String message,
    List<Badge> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeList200Response.copyWith.fieldName(...)`
class _$BadgeList200ResponseCWProxyImpl
    implements _$BadgeList200ResponseCWProxy {
  const _$BadgeList200ResponseCWProxyImpl(this._value);

  final BadgeList200Response _value;

  @override
  BadgeList200Response message(String message) => this(message: message);

  @override
  BadgeList200Response data(List<Badge> data) => this(data: data);

  @override
  BadgeList200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  BadgeList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<Badge>,
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

extension $BadgeList200ResponseCopyWith on BadgeList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeList200Response.copyWith(...)` or like so:`instanceOfBadgeList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeList200ResponseCWProxy get copyWith =>
      _$BadgeList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeList200Response _$BadgeList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BadgeList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => Badge.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$BadgeList200ResponseToJson(
  BadgeList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
