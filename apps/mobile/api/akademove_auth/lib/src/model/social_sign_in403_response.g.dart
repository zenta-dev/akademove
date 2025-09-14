// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in403_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialSignIn403Response extends SocialSignIn403Response {
  @override
  final String? message;

  factory _$SocialSignIn403Response(
          [void Function(SocialSignIn403ResponseBuilder)? updates]) =>
      (SocialSignIn403ResponseBuilder()..update(updates))._build();

  _$SocialSignIn403Response._({this.message}) : super._();
  @override
  SocialSignIn403Response rebuild(
          void Function(SocialSignIn403ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialSignIn403ResponseBuilder toBuilder() =>
      SocialSignIn403ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialSignIn403Response && message == other.message;
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
    return (newBuiltValueToStringHelper(r'SocialSignIn403Response')
          ..add('message', message))
        .toString();
  }
}

class SocialSignIn403ResponseBuilder
    implements
        Builder<SocialSignIn403Response, SocialSignIn403ResponseBuilder> {
  _$SocialSignIn403Response? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SocialSignIn403ResponseBuilder() {
    SocialSignIn403Response._defaults(this);
  }

  SocialSignIn403ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialSignIn403Response other) {
    _$v = other as _$SocialSignIn403Response;
  }

  @override
  void update(void Function(SocialSignIn403ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialSignIn403Response build() => _build();

  _$SocialSignIn403Response _build() {
    final _$result = _$v ??
        _$SocialSignIn403Response._(
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
