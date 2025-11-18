// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserList200ResponseCWProxy {
  BadgeUserList200Response message(String message);

  BadgeUserList200Response data(List<UserBadge> data);

  BadgeUserList200Response pagination(PaginationResult? pagination);

  BadgeUserList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserList200Response call({
    String message,
    List<UserBadge> data,
    PaginationResult? pagination,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeUserList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeUserList200Response.copyWith.fieldName(...)`
class _$BadgeUserList200ResponseCWProxyImpl
    implements _$BadgeUserList200ResponseCWProxy {
  const _$BadgeUserList200ResponseCWProxyImpl(this._value);

  final BadgeUserList200Response _value;

  @override
  BadgeUserList200Response message(String message) => this(message: message);

  @override
  BadgeUserList200Response data(List<UserBadge> data) => this(data: data);

  @override
  BadgeUserList200Response pagination(PaginationResult? pagination) =>
      this(pagination: pagination);

  @override
  BadgeUserList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? pagination = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeUserList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<UserBadge>,
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

extension $BadgeUserList200ResponseCopyWith on BadgeUserList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeUserList200Response.copyWith(...)` or like so:`instanceOfBadgeUserList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeUserList200ResponseCWProxy get copyWith =>
      _$BadgeUserList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeUserList200Response _$BadgeUserList200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeUserList200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BadgeUserList200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => (v as List<dynamic>)
          .map((e) => UserBadge.fromJson(e as Map<String, dynamic>))
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

Map<String, dynamic> _$BadgeUserList200ResponseToJson(
  BadgeUserList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'pagination': ?instance.pagination?.toJson(),
  'totalPages': ?instance.totalPages,
};
