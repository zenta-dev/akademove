// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_social_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkSocialPostRequest extends LinkSocialPostRequest {
  @override
  final String? callbackURL;
  @override
  final String provider;
  @override
  final LinkSocialPostRequestIdToken? idToken;
  @override
  final bool? requestSignUp;
  @override
  final BuiltList<JsonObject?>? scopes;
  @override
  final String? errorCallbackURL;
  @override
  final bool? disableRedirect;

  factory _$LinkSocialPostRequest([
    void Function(LinkSocialPostRequestBuilder)? updates,
  ]) => (LinkSocialPostRequestBuilder()..update(updates))._build();

  _$LinkSocialPostRequest._({
    this.callbackURL,
    required this.provider,
    this.idToken,
    this.requestSignUp,
    this.scopes,
    this.errorCallbackURL,
    this.disableRedirect,
  }) : super._();
  @override
  LinkSocialPostRequest rebuild(
    void Function(LinkSocialPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  LinkSocialPostRequestBuilder toBuilder() =>
      LinkSocialPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkSocialPostRequest &&
        callbackURL == other.callbackURL &&
        provider == other.provider &&
        idToken == other.idToken &&
        requestSignUp == other.requestSignUp &&
        scopes == other.scopes &&
        errorCallbackURL == other.errorCallbackURL &&
        disableRedirect == other.disableRedirect;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, requestSignUp.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jc(_$hash, errorCallbackURL.hashCode);
    _$hash = $jc(_$hash, disableRedirect.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkSocialPostRequest')
          ..add('callbackURL', callbackURL)
          ..add('provider', provider)
          ..add('idToken', idToken)
          ..add('requestSignUp', requestSignUp)
          ..add('scopes', scopes)
          ..add('errorCallbackURL', errorCallbackURL)
          ..add('disableRedirect', disableRedirect))
        .toString();
  }
}

class LinkSocialPostRequestBuilder
    implements Builder<LinkSocialPostRequest, LinkSocialPostRequestBuilder> {
  _$LinkSocialPostRequest? _$v;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  String? _provider;
  String? get provider => _$this._provider;
  set provider(String? provider) => _$this._provider = provider;

  LinkSocialPostRequestIdTokenBuilder? _idToken;
  LinkSocialPostRequestIdTokenBuilder get idToken =>
      _$this._idToken ??= LinkSocialPostRequestIdTokenBuilder();
  set idToken(LinkSocialPostRequestIdTokenBuilder? idToken) =>
      _$this._idToken = idToken;

  bool? _requestSignUp;
  bool? get requestSignUp => _$this._requestSignUp;
  set requestSignUp(bool? requestSignUp) =>
      _$this._requestSignUp = requestSignUp;

  ListBuilder<JsonObject?>? _scopes;
  ListBuilder<JsonObject?> get scopes =>
      _$this._scopes ??= ListBuilder<JsonObject?>();
  set scopes(ListBuilder<JsonObject?>? scopes) => _$this._scopes = scopes;

  String? _errorCallbackURL;
  String? get errorCallbackURL => _$this._errorCallbackURL;
  set errorCallbackURL(String? errorCallbackURL) =>
      _$this._errorCallbackURL = errorCallbackURL;

  bool? _disableRedirect;
  bool? get disableRedirect => _$this._disableRedirect;
  set disableRedirect(bool? disableRedirect) =>
      _$this._disableRedirect = disableRedirect;

  LinkSocialPostRequestBuilder() {
    LinkSocialPostRequest._defaults(this);
  }

  LinkSocialPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _callbackURL = $v.callbackURL;
      _provider = $v.provider;
      _idToken = $v.idToken?.toBuilder();
      _requestSignUp = $v.requestSignUp;
      _scopes = $v.scopes?.toBuilder();
      _errorCallbackURL = $v.errorCallbackURL;
      _disableRedirect = $v.disableRedirect;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkSocialPostRequest other) {
    _$v = other as _$LinkSocialPostRequest;
  }

  @override
  void update(void Function(LinkSocialPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkSocialPostRequest build() => _build();

  _$LinkSocialPostRequest _build() {
    _$LinkSocialPostRequest _$result;
    try {
      _$result =
          _$v ??
          _$LinkSocialPostRequest._(
            callbackURL: callbackURL,
            provider: BuiltValueNullFieldError.checkNotNull(
              provider,
              r'LinkSocialPostRequest',
              'provider',
            ),
            idToken: _idToken?.build(),
            requestSignUp: requestSignUp,
            scopes: _scopes?.build(),
            errorCallbackURL: errorCallbackURL,
            disableRedirect: disableRedirect,
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
          r'LinkSocialPostRequest',
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
