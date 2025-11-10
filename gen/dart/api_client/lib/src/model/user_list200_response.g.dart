// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserList200ResponseCWProxy {
  UserList200Response message(String message);

  UserList200Response data(List<User> data);

  UserList200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  UserList200Response call({String message, List<User> data, int? totalPages});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserList200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserList200Response.copyWith.fieldName(...)`
class _$UserList200ResponseCWProxyImpl implements _$UserList200ResponseCWProxy {
  const _$UserList200ResponseCWProxyImpl(this._value);

  final UserList200Response _value;

  @override
  UserList200Response message(String message) => this(message: message);

  @override
  UserList200Response data(List<User> data) => this(data: data);

  @override
  UserList200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserList200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserList200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  UserList200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return UserList200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as List<User>,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $UserList200ResponseCopyWith on UserList200Response {
  /// Returns a callable class that can be used as follows: `instanceOfUserList200Response.copyWith(...)` or like so:`instanceOfUserList200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserList200ResponseCWProxy get copyWith =>
      _$UserList200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserList200Response _$UserList200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UserList200Response', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['message', 'data']);
      final val = UserList200Response(
        message: $checkedConvert('message', (v) => v as String),
        data: $checkedConvert(
          'data',
          (v) => (v as List<dynamic>)
              .map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$UserList200ResponseToJson(
  UserList200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalPages': ?instance.totalPages,
};
