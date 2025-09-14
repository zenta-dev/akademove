// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialSignInRequest extends SocialSignInRequest {
  @override
  final String? callbackURL;
  @override
  final String? newUserCallbackURL;
  @override
  final String? errorCallbackURL;
  @override
  final String provider;
  @override
  final bool? disableRedirect;
  @override
  final SocialSignInRequestIdToken? idToken;
  @override
  final BuiltList<JsonObject?>? scopes;
  @override
  final bool? requestSignUp;
  @override
  final String? loginHint;

  factory _$SocialSignInRequest([
    void Function(SocialSignInRequestBuilder)? updates,
  ]) => (SocialSignInRequestBuilder()..update(updates))._build();

  _$SocialSignInRequest._({
    this.callbackURL,
    this.newUserCallbackURL,
    this.errorCallbackURL,
    required this.provider,
    this.disableRedirect,
    this.idToken,
    this.scopes,
    this.requestSignUp,
    this.loginHint,
  }) : super._();
  @override
  SocialSignInRequest rebuild(
    void Function(SocialSignInRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SocialSignInRequestBuilder toBuilder() =>
      SocialSignInRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialSignInRequest &&
        callbackURL == other.callbackURL &&
        newUserCallbackURL == other.newUserCallbackURL &&
        errorCallbackURL == other.errorCallbackURL &&
        provider == other.provider &&
        disableRedirect == other.disableRedirect &&
        idToken == other.idToken &&
        scopes == other.scopes &&
        requestSignUp == other.requestSignUp &&
        loginHint == other.loginHint;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jc(_$hash, newUserCallbackURL.hashCode);
    _$hash = $jc(_$hash, errorCallbackURL.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, disableRedirect.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jc(_$hash, requestSignUp.hashCode);
    _$hash = $jc(_$hash, loginHint.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialSignInRequest')
          ..add('callbackURL', callbackURL)
          ..add('newUserCallbackURL', newUserCallbackURL)
          ..add('errorCallbackURL', errorCallbackURL)
          ..add('provider', provider)
          ..add('disableRedirect', disableRedirect)
          ..add('idToken', idToken)
          ..add('scopes', scopes)
          ..add('requestSignUp', requestSignUp)
          ..add('loginHint', loginHint))
        .toString();
  }
}

class SocialSignInRequestBuilder
    implements Builder<SocialSignInRequest, SocialSignInRequestBuilder> {
  _$SocialSignInRequest? _$v;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  String? _newUserCallbackURL;
  String? get newUserCallbackURL => _$this._newUserCallbackURL;
  set newUserCallbackURL(String? newUserCallbackURL) =>
      _$this._newUserCallbackURL = newUserCallbackURL;

  String? _errorCallbackURL;
  String? get errorCallbackURL => _$this._errorCallbackURL;
  set errorCallbackURL(String? errorCallbackURL) =>
      _$this._errorCallbackURL = errorCallbackURL;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  bool? _disableRedirect;
  bool? get disableRedirect => _$this._disableRedirect;
  set disableRedirect(bool? disableRedirect) =>
      _$this._disableRedirect = disableRedirect;

  SocialSignInRequestIdTokenBuilder? _idToken;
  SocialSignInRequestIdTokenBuilder get idToken =>
      _$this._idToken ??= SocialSignInRequestIdTokenBuilder();
  set idToken(SocialSignInRequestIdTokenBuilder? idToken) =>
      _$this._idToken = idToken;

  ListBuilder<JsonObject?>? _scopes;
  ListBuilder<JsonObject?> get scopes =>
      _$this._scopes ??= ListBuilder<JsonObject?>();
  set scopes(ListBuilder<JsonObject?>? scopes) => _$this._scopes = scopes;

  bool? _requestSignUp;
  bool? get requestSignUp => _$this._requestSignUp;
  set requestSignUp(bool? requestSignUp) =>
      _$this._requestSignUp = requestSignUp;

  String? _loginHint;
  String? get loginHint => _$this._loginHint;
  set loginHint(String? loginHint) => _$this._loginHint = loginHint;

  SocialSignInRequestBuilder() {
    SocialSignInRequest._defaults(this);
  }

  SocialSignInRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callbackURL = $v.callbackURL;
      _newUserCallbackURL = $v.newUserCallbackURL;
      _errorCallbackURL = $v.errorCallbackURL;
      _provider = $v.provider;
      _disableRedirect = $v.disableRedirect;
      _idToken = $v.idToken?.toBuilder();
      _scopes = $v.scopes?.toBuilder();
      _requestSignUp = $v.requestSignUp;
      _loginHint = $v.loginHint;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialSignInRequest other) {
    _$v = other as _$SocialSignInRequest;
  }

  @override
  void update(void Function(SocialSignInRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialSignInRequest build() => _build();

  _$SocialSignInRequest _build() {
    _$SocialSignInRequest _$result;
    try {
      _$result =
          _$v ??
          _$SocialSignInRequest._(
            callbackURL: callbackURL,
            newUserCallbackURL: newUserCallbackURL,
            errorCallbackURL: errorCallbackURL,
            provider: BuiltValueNullFieldError.checkNotNull(
              provider,
              r'SocialSignInRequest',
              'provider',
            ),
            disableRedirect: disableRedirect,
            idToken: _idToken?.build(),
            scopes: _scopes?.build(),
            requestSignUp: requestSignUp,
            loginHint: loginHint,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'idToken';
        _idToken?.build();
        _$failedField = 'scopes';
        _scopes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SocialSignInRequest',
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
