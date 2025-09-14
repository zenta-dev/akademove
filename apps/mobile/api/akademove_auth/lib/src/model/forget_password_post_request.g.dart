// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgetPasswordPostRequest extends ForgetPasswordPostRequest {
  @override
  final String email;
  @override
  final String? redirectTo;

  factory _$ForgetPasswordPostRequest(
          [void Function(ForgetPasswordPostRequestBuilder)? updates]) =>
      (ForgetPasswordPostRequestBuilder()..update(updates))._build();

  _$ForgetPasswordPostRequest._({required this.email, this.redirectTo})
      : super._();
  @override
  ForgetPasswordPostRequest rebuild(
          void Function(ForgetPasswordPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgetPasswordPostRequestBuilder toBuilder() =>
      ForgetPasswordPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgetPasswordPostRequest &&
        email == other.email &&
        redirectTo == other.redirectTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, redirectTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ForgetPasswordPostRequest')
          ..add('email', email)
          ..add('redirectTo', redirectTo))
        .toString();
  }
}

class ForgetPasswordPostRequestBuilder
    implements
        Builder<ForgetPasswordPostRequest, ForgetPasswordPostRequestBuilder> {
  _$ForgetPasswordPostRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _redirectTo;
  String? get redirectTo => _$this._redirectTo;
  set redirectTo(String? redirectTo) => _$this._redirectTo = redirectTo;

  ForgetPasswordPostRequestBuilder() {
    ForgetPasswordPostRequest._defaults(this);
  }

  ForgetPasswordPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _redirectTo = $v.redirectTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgetPasswordPostRequest other) {
    _$v = other as _$ForgetPasswordPostRequest;
  }

  @override
  void update(void Function(ForgetPasswordPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgetPasswordPostRequest build() => _build();

  _$ForgetPasswordPostRequest _build() {
    final _$result = _$v ??
        _$ForgetPasswordPostRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'ForgetPasswordPostRequest', 'email'),
          redirectTo: redirectTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
