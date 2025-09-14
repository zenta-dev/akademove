// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteUserPostRequest extends DeleteUserPostRequest {
  @override
  final String? callbackURL;
  @override
  final String? password;
  @override
  final String? token;

  factory _$DeleteUserPostRequest(
          [void Function(DeleteUserPostRequestBuilder)? updates]) =>
      (DeleteUserPostRequestBuilder()..update(updates))._build();

  _$DeleteUserPostRequest._({this.callbackURL, this.password, this.token})
      : super._();
  @override
  DeleteUserPostRequest rebuild(
          void Function(DeleteUserPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteUserPostRequestBuilder toBuilder() =>
      DeleteUserPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUserPostRequest &&
        callbackURL == other.callbackURL &&
        password == other.password &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteUserPostRequest')
          ..add('callbackURL', callbackURL)
          ..add('password', password)
          ..add('token', token))
        .toString();
  }
}

class DeleteUserPostRequestBuilder
    implements Builder<DeleteUserPostRequest, DeleteUserPostRequestBuilder> {
  _$DeleteUserPostRequest? _$v;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  DeleteUserPostRequestBuilder() {
    DeleteUserPostRequest._defaults(this);
  }

  DeleteUserPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callbackURL = $v.callbackURL;
      _password = $v.password;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteUserPostRequest other) {
    _$v = other as _$DeleteUserPostRequest;
  }

  @override
  void update(void Function(DeleteUserPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUserPostRequest build() => _build();

  _$DeleteUserPostRequest _build() {
    final _$result = _$v ??
        _$DeleteUserPostRequest._(
          callbackURL: callbackURL,
          password: password,
          token: token,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
