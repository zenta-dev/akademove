// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_sign_in200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SocialSignIn200ResponseRedirectEnum
    _$socialSignIn200ResponseRedirectEnum_false_ =
    const SocialSignIn200ResponseRedirectEnum._('false_');

SocialSignIn200ResponseRedirectEnum
    _$socialSignIn200ResponseRedirectEnumValueOf(String name) {
  switch (name) {
    case 'false_':
      return _$socialSignIn200ResponseRedirectEnum_false_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SocialSignIn200ResponseRedirectEnum>
    _$socialSignIn200ResponseRedirectEnumValues = BuiltSet<
        SocialSignIn200ResponseRedirectEnum>(const <SocialSignIn200ResponseRedirectEnum>[
  _$socialSignIn200ResponseRedirectEnum_false_,
]);

Serializer<SocialSignIn200ResponseRedirectEnum>
    _$socialSignIn200ResponseRedirectEnumSerializer =
    _$SocialSignIn200ResponseRedirectEnumSerializer();

class _$SocialSignIn200ResponseRedirectEnumSerializer
    implements PrimitiveSerializer<SocialSignIn200ResponseRedirectEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'false_': 'false',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'false': 'false_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    SocialSignIn200ResponseRedirectEnum
  ];
  @override
  final String wireName = 'SocialSignIn200ResponseRedirectEnum';

  @override
  Object serialize(
          Serializers serializers, SocialSignIn200ResponseRedirectEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SocialSignIn200ResponseRedirectEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SocialSignIn200ResponseRedirectEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$SocialSignIn200Response extends SocialSignIn200Response {
  @override
  final SocialSignIn200ResponseRedirectEnum redirect;
  @override
  final String token;

  factory _$SocialSignIn200Response(
          [void Function(SocialSignIn200ResponseBuilder)? updates]) =>
      (SocialSignIn200ResponseBuilder()..update(updates))._build();

  _$SocialSignIn200Response._({required this.redirect, required this.token})
      : super._();
  @override
  SocialSignIn200Response rebuild(
          void Function(SocialSignIn200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SocialSignIn200ResponseBuilder toBuilder() =>
      SocialSignIn200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialSignIn200Response &&
        redirect == other.redirect &&
        token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, redirect.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialSignIn200Response')
          ..add('redirect', redirect)
          ..add('token', token))
        .toString();
  }
}

class SocialSignIn200ResponseBuilder
    implements
        Builder<SocialSignIn200Response, SocialSignIn200ResponseBuilder> {
  _$SocialSignIn200Response? _$v;

  SocialSignIn200ResponseRedirectEnum? _redirect;
  SocialSignIn200ResponseRedirectEnum? get redirect => _$this._redirect;
  set redirect(SocialSignIn200ResponseRedirectEnum? redirect) =>
      _$this._redirect = redirect;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  SocialSignIn200ResponseBuilder() {
    SocialSignIn200Response._defaults(this);
  }

  SocialSignIn200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _redirect = $v.redirect;
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialSignIn200Response other) {
    _$v = other as _$SocialSignIn200Response;
  }

  @override
  void update(void Function(SocialSignIn200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialSignIn200Response build() => _build();

  _$SocialSignIn200Response _build() {
    final _$result = _$v ??
        _$SocialSignIn200Response._(
          redirect: BuiltValueNullFieldError.checkNotNull(
              redirect, r'SocialSignIn200Response', 'redirect'),
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'SocialSignIn200Response', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
