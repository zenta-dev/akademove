// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserList200Response extends UserList200Response {
  @override
  final String message;
  @override
  final BuiltList<User> data;

  factory _$UserList200Response([
    void Function(UserList200ResponseBuilder)? updates,
  ]) => (UserList200ResponseBuilder()..update(updates))._build();

  _$UserList200Response._({required this.message, required this.data})
    : super._();
  @override
  UserList200Response rebuild(
    void Function(UserList200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UserList200ResponseBuilder toBuilder() =>
      UserList200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserList200Response &&
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
    return (newBuiltValueToStringHelper(r'UserList200Response')
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UserList200ResponseBuilder
    implements Builder<UserList200Response, UserList200ResponseBuilder> {
  _$UserList200Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<User>? _data;
  ListBuilder<User> get data => _$this._data ??= ListBuilder<User>();
  set data(ListBuilder<User>? data) => _$this._data = data;

  UserList200ResponseBuilder() {
    UserList200Response._defaults(this);
  }

  UserList200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserList200Response other) {
    _$v = other as _$UserList200Response;
  }

  @override
  void update(void Function(UserList200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserList200Response build() => _build();

  _$UserList200Response _build() {
    _$UserList200Response _$result;
    try {
      _$result =
          _$v ??
          _$UserList200Response._(
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UserList200Response',
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
          r'UserList200Response',
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
