// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification_email_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SendVerificationEmailPostRequest
    extends SendVerificationEmailPostRequest {
  @override
  final String email;
  @override
  final String? callbackURL;

  factory _$SendVerificationEmailPostRequest([
    void Function(SendVerificationEmailPostRequestBuilder)? updates,
  ]) => (SendVerificationEmailPostRequestBuilder()..update(updates))._build();

  _$SendVerificationEmailPostRequest._({required this.email, this.callbackURL})
    : super._();
  @override
  SendVerificationEmailPostRequest rebuild(
    void Function(SendVerificationEmailPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SendVerificationEmailPostRequestBuilder toBuilder() =>
      SendVerificationEmailPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendVerificationEmailPostRequest &&
        email == other.email &&
        callbackURL == other.callbackURL;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SendVerificationEmailPostRequest')
          ..add('email', email)
          ..add('callbackURL', callbackURL))
        .toString();
  }
}

class SendVerificationEmailPostRequestBuilder
    implements
        Builder<
          SendVerificationEmailPostRequest,
          SendVerificationEmailPostRequestBuilder
        > {
  _$SendVerificationEmailPostRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  SendVerificationEmailPostRequestBuilder() {
    SendVerificationEmailPostRequest._defaults(this);
  }

  SendVerificationEmailPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _callbackURL = $v.callbackURL;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendVerificationEmailPostRequest other) {
    _$v = other as _$SendVerificationEmailPostRequest;
  }

  @override
  void update(void Function(SendVerificationEmailPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendVerificationEmailPostRequest build() => _build();

  _$SendVerificationEmailPostRequest _build() {
    final _$result =
        _$v ??
        _$SendVerificationEmailPostRequest._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'SendVerificationEmailPostRequest',
            'email',
          ),
          callbackURL: callbackURL,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
