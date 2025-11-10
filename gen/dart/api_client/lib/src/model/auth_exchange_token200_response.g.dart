// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_exchange_token200_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthExchangeToken200ResponseCWProxy {
  AuthExchangeToken200Response message(String message);

  AuthExchangeToken200Response data(String data);

  AuthExchangeToken200Response totalPages(int? totalPages);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthExchangeToken200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthExchangeToken200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthExchangeToken200Response call({
    String message,
    String data,
    int? totalPages,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthExchangeToken200Response.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthExchangeToken200Response.copyWith.fieldName(...)`
class _$AuthExchangeToken200ResponseCWProxyImpl
    implements _$AuthExchangeToken200ResponseCWProxy {
  const _$AuthExchangeToken200ResponseCWProxyImpl(this._value);

  final AuthExchangeToken200Response _value;

  @override
  AuthExchangeToken200Response message(String message) =>
      this(message: message);

  @override
  AuthExchangeToken200Response data(String data) => this(data: data);

  @override
  AuthExchangeToken200Response totalPages(int? totalPages) =>
      this(totalPages: totalPages);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthExchangeToken200Response(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthExchangeToken200Response(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthExchangeToken200Response call({
    Object? message = const $CopyWithPlaceholder(),
    Object? data = const $CopyWithPlaceholder(),
    Object? totalPages = const $CopyWithPlaceholder(),
  }) {
    return AuthExchangeToken200Response(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      data: data == const $CopyWithPlaceholder()
          ? _value.data
          // ignore: cast_nullable_to_non_nullable
          : data as String,
      totalPages: totalPages == const $CopyWithPlaceholder()
          ? _value.totalPages
          // ignore: cast_nullable_to_non_nullable
          : totalPages as int?,
    );
  }
}

extension $AuthExchangeToken200ResponseCopyWith
    on AuthExchangeToken200Response {
  /// Returns a callable class that can be used as follows: `instanceOfAuthExchangeToken200Response.copyWith(...)` or like so:`instanceOfAuthExchangeToken200Response.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthExchangeToken200ResponseCWProxy get copyWith =>
      _$AuthExchangeToken200ResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthExchangeToken200Response _$AuthExchangeToken200ResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthExchangeToken200Response', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['message', 'data']);
  final val = AuthExchangeToken200Response(
    message: $checkedConvert('message', (v) => v as String),
    data: $checkedConvert('data', (v) => v as String),
    totalPages: $checkedConvert('totalPages', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$AuthExchangeToken200ResponseToJson(
  AuthExchangeToken200Response instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data,
  'totalPages': ?instance.totalPages,
};
