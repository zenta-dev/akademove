// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_user_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeUserCreate200ResponseCWProxy {
  BadgeUserCreate200Response message(String message);

  BadgeUserCreate200Response data(UserBadge data);

  BadgeUserCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserCreate200Response call({
    String message,
    UserBadge data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeUserCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeUserCreate200Response.copyWith.fieldName(...)`
class _$BadgeUserCreate200ResponseCWProxyImpl
    implements _$BadgeUserCreate200ResponseCWProxy {
  const _$BadgeUserCreate200ResponseCWProxyImpl(this._value);

  final BadgeUserCreate200Response _value;

  @override
  BadgeUserCreate200Response message(String message) => this(message: message);

  @override
  BadgeUserCreate200Response data(UserBadge data) => this(data: data);

  @override
  BadgeUserCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeUserCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeUserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeUserCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeUserCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as UserBadge,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $BadgeUserCreate200ResponseCopyWith on BadgeUserCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeUserCreate200Response.copyWith(...)` or like so:`instanceOfBadgeUserCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeUserCreate200ResponseCWProxy get copyWith =>
      _$BadgeUserCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeUserCreate200Response _$BadgeUserCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeUserCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BadgeUserCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => UserBadge.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$BadgeUserCreate200ResponseToJson(
  BadgeUserCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
