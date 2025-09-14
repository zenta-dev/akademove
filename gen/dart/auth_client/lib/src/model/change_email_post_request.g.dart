// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangeEmailPostRequest extends ChangeEmailPostRequest {
  @override
  final String newEmail;
  @override
  final String? callbackURL;

  factory _$ChangeEmailPostRequest([
    void Function(ChangeEmailPostRequestBuilder)? updates,
  ]) => (ChangeEmailPostRequestBuilder()..update(updates))._build();

  _$ChangeEmailPostRequest._({required this.newEmail, this.callbackURL})
    : super._();
  @override
  ChangeEmailPostRequest rebuild(
    void Function(ChangeEmailPostRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangeEmailPostRequestBuilder toBuilder() =>
      ChangeEmailPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeEmailPostRequest &&
        newEmail == other.newEmail &&
        callbackURL == other.callbackURL;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newEmail.hashCode);
    _$hash = $jc(_$hash, callbackURL.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeEmailPostRequest')
          ..add('newEmail', newEmail)
          ..add('callbackURL', callbackURL))
        .toString();
  }
}

class ChangeEmailPostRequestBuilder
    implements Builder<ChangeEmailPostRequest, ChangeEmailPostRequestBuilder> {
  _$ChangeEmailPostRequest? _$v;

  String? _newEmail;
  String? get newEmail => _$this._newEmail;
  set newEmail(String? newEmail) => _$this._newEmail = newEmail;

  String? _callbackURL;
  String? get callbackURL => _$this._callbackURL;
  set callbackURL(String? callbackURL) => _$this._callbackURL = callbackURL;

  ChangeEmailPostRequestBuilder() {
    ChangeEmailPostRequest._defaults(this);
  }

  ChangeEmailPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newEmail = $v.newEmail;
      _callbackURL = $v.callbackURL;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeEmailPostRequest other) {
    _$v = other as _$ChangeEmailPostRequest;
  }

  @override
  void update(void Function(ChangeEmailPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeEmailPostRequest build() => _build();

  _$ChangeEmailPostRequest _build() {
    final _$result =
        _$v ??
        _$ChangeEmailPostRequest._(
          newEmail: BuiltValueNullFieldError.checkNotNull(
            newEmail,
            r'ChangeEmailPostRequest',
            'newEmail',
          ),
          callbackURL: callbackURL,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
