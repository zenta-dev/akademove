// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChangePasswordPostRequest extends ChangePasswordPostRequest {
  @override
  final String newPassword;
  @override
  final String currentPassword;
  @override
  final bool? revokeOtherSessions;

  factory _$ChangePasswordPostRequest(
          [void Function(ChangePasswordPostRequestBuilder)? updates]) =>
      (ChangePasswordPostRequestBuilder()..update(updates))._build();

  _$ChangePasswordPostRequest._(
      {required this.newPassword,
      required this.currentPassword,
      this.revokeOtherSessions})
      : super._();
  @override
  ChangePasswordPostRequest rebuild(
          void Function(ChangePasswordPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangePasswordPostRequestBuilder toBuilder() =>
      ChangePasswordPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangePasswordPostRequest &&
        newPassword == other.newPassword &&
        currentPassword == other.currentPassword &&
        revokeOtherSessions == other.revokeOtherSessions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, revokeOtherSessions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangePasswordPostRequest')
          ..add('newPassword', newPassword)
          ..add('currentPassword', currentPassword)
          ..add('revokeOtherSessions', revokeOtherSessions))
        .toString();
  }
}

class ChangePasswordPostRequestBuilder
    implements
        Builder<ChangePasswordPostRequest, ChangePasswordPostRequestBuilder> {
  _$ChangePasswordPostRequest? _$v;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  bool? _revokeOtherSessions;
  bool? get revokeOtherSessions => _$this._revokeOtherSessions;
  set revokeOtherSessions(bool? revokeOtherSessions) =>
      _$this._revokeOtherSessions = revokeOtherSessions;

  ChangePasswordPostRequestBuilder() {
    ChangePasswordPostRequest._defaults(this);
  }

  ChangePasswordPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPassword = $v.newPassword;
      _currentPassword = $v.currentPassword;
      _revokeOtherSessions = $v.revokeOtherSessions;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangePasswordPostRequest other) {
    _$v = other as _$ChangePasswordPostRequest;
  }

  @override
  void update(void Function(ChangePasswordPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangePasswordPostRequest build() => _build();

  _$ChangePasswordPostRequest _build() {
    final _$result = _$v ??
        _$ChangePasswordPostRequest._(
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'ChangePasswordPostRequest', 'newPassword'),
          currentPassword: BuiltValueNullFieldError.checkNotNull(
              currentPassword, r'ChangePasswordPostRequest', 'currentPassword'),
          revokeOtherSessions: revokeOtherSessions,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
