// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in400_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialSignIn400Response extends SocialSignIn400Response {
  @override
  final String message;

  factory _$SocialSignIn400Response([
    void Function(SocialSignIn400ResponseBuilder)? updates,
  ]) => (SocialSignIn400ResponseBuilder()..update(updates))._build();

  _$SocialSignIn400Response._({required this.message}) : super._();
  @override
  SocialSignIn400Response rebuild(
    void Function(SocialSignIn400ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SocialSignIn400ResponseBuilder toBuilder() =>
      SocialSignIn400ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialSignIn400Response && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'SocialSignIn400Response',
    )..add('message', message)).toString();
  }
}

class SocialSignIn400ResponseBuilder
    implements
        Builder<SocialSignIn400Response, SocialSignIn400ResponseBuilder> {
  _$SocialSignIn400Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SocialSignIn400ResponseBuilder() {
    SocialSignIn400Response._defaults(this);
  }

  SocialSignIn400ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialSignIn400Response other) {
    _$v = other as _$SocialSignIn400Response;
  }

  @override
  void update(void Function(SocialSignIn400ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialSignIn400Response build() => _build();

  _$SocialSignIn400Response _build() {
    final _$result =
        _$v ??
        _$SocialSignIn400Response._(
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'SocialSignIn400Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
