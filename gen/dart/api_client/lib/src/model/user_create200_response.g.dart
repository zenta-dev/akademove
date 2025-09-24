// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserCreate200Response extends UserCreate200Response {
  @override
  final String message;
  @override
  final User data;

  factory _$UserCreate200Response([
    void Function(UserCreate200ResponseBuilder)? updates,
  ]) => (UserCreate200ResponseBuilder()..update(updates))._build();

  _$UserCreate200Response._({required this.message, required this.data})
    : super._();
  @override
  UserCreate200Response rebuild(
    void Function(UserCreate200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserCreate200ResponseBuilder toBuilder() =>
      UserCreate200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCreate200Response &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserCreate200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UserCreate200ResponseBuilder
    implements Builder<UserCreate200Response, UserCreate200ResponseBuilder> {
  _$UserCreate200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  UserBuilder? _data;
  UserBuilder get data => _$this._data ??= UserBuilder();
  set data(UserBuilder? data) => _$this._data = data;

  UserCreate200ResponseBuilder() {
    UserCreate200Response._defaults(this);
  }

  UserCreate200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCreate200Response other) {
    _$v = other as _$UserCreate200Response;
  }

  @override
  void update(void Function(UserCreate200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserCreate200Response build() => _build();

  _$UserCreate200Response _build() {
    _$UserCreate200Response _$result;
    try {
      _$result =
          _$v ??
          _$UserCreate200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UserCreate200Response',
              'message',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UserCreate200Response',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
