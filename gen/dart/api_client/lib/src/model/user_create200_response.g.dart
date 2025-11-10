// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCreate200ResponseCWProxy {
  UserCreate200Response message(String message);

  UserCreate200Response data(User data);

  UserCreate200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreate200Response call({String message, User data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserCreate200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserCreate200Response.copyWith.fieldName(...)`
class _$UserCreate200ResponseCWProxyImpl
    implements _$UserCreate200ResponseCWProxy {
  const _$UserCreate200ResponseCWProxyImpl(this._value);

  final UserCreate200Response _value;

  @override
  UserCreate200Response message(String message) => this(message: message);

  @override
  UserCreate200Response data(User data) => this(data: data);

  @override
  UserCreate200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCreate200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCreate200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCreate200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserCreate200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as User,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $UserCreate200ResponseCopyWith on UserCreate200Response {
  /// Returns a callable class that can be used as follows: `instanceOfUserCreate200Response.copyWith(...)` or like so:`instanceOfUserCreate200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCreate200ResponseCWProxy get copyWith =>
      _$UserCreate200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreate200Response _$UserCreate200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UserCreate200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = UserCreate200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert(
      'data',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$UserCreate200ResponseToJson(
  UserCreate200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
  'totalPages': ?instance.totalPages,
};
