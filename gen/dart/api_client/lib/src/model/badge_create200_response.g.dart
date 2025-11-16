// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BadgeCreate200ResponseCWProxy {
  BadgeCreate200Response message(String message);

  BadgeCreate200Response data(Badge data);

  BadgeCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreate200Response call({String message, Badge data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBadgeCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBadgeCreate200Response.copyWith.fieldName(...)`
class _$BadgeCreate200ResponseCWProxyImpl
    implements _$BadgeCreate200ResponseCWProxy {
  const _$BadgeCreate200ResponseCWProxyImpl(this._value);

  final BadgeCreate200Response _value;

  @override
  BadgeCreate200Response message(String message) => this(message: message);

  @override
  BadgeCreate200Response data(Badge data) => this(data: data);

  @override
  BadgeCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BadgeCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BadgeCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  BadgeCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return BadgeCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as Badge,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $BadgeCreate200ResponseCopyWith on BadgeCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfBadgeCreate200Response.copyWith(...)` or like so:`instanceOfBadgeCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BadgeCreate200ResponseCWProxy get copyWith =>
      _$BadgeCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeCreate200Response _$BadgeCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BadgeCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = BadgeCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => Badge.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$BadgeCreate200ResponseToJson(
  BadgeCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
