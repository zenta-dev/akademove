// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_email_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SignInEmailPost200ResponseRedirectEnum
_$signInEmailPost200ResponseRedirectEnum_false_ =
    const SignInEmailPost200ResponseRedirectEnum._('false_');

SignInEmailPost200ResponseRedirectEnum
_$signInEmailPost200ResponseRedirectEnumValueOf(String name) {
  switch (name) {
    case 'false_':
      return _$signInEmailPost200ResponseRedirectEnum_false_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SignInEmailPost200ResponseRedirectEnum>
_$signInEmailPost200ResponseRedirectEnumValues =
    BuiltSet<SignInEmailPost200ResponseRedirectEnum>(
      const <SignInEmailPost200ResponseRedirectEnum>[
        _$signInEmailPost200ResponseRedirectEnum_false_,
      ],
    );

Serializer<SignInEmailPost200ResponseRedirectEnum>
_$signInEmailPost200ResponseRedirectEnumSerializer =
    _$SignInEmailPost200ResponseRedirectEnumSerializer();

class _$SignInEmailPost200ResponseRedirectEnumSerializer
    implements PrimitiveSerializer<SignInEmailPost200ResponseRedirectEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'false_': 'false',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'false': 'false_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    SignInEmailPost200ResponseRedirectEnum,
  ];
  @override
  final String wireName = 'SignInEmailPost200ResponseRedirectEnum';

  @override
  Object serialize(
    Serializers serializers,
    SignInEmailPost200ResponseRedirectEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  SignInEmailPost200ResponseRedirectEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => SignInEmailPost200ResponseRedirectEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$SignInEmailPost200Response extends SignInEmailPost200Response {
  @override
  final SignInEmailPost200ResponseRedirectEnum redirect;
  @override
  final String token;
  @override
  final JsonObject? url;
  @override
  final SignInEmailPost200ResponseUser user;

  factory _$SignInEmailPost200Response([
    void Function(SignInEmailPost200ResponseBuilder)? updates,
  ]) => (SignInEmailPost200ResponseBuilder()..update(updates))._build();

  _$SignInEmailPost200Response._({
    required this.redirect,
    required this.token,
    this.url,
    required this.user,
  }) : super._();
  @override
  SignInEmailPost200Response rebuild(
    void Function(SignInEmailPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignInEmailPost200ResponseBuilder toBuilder() =>
      SignInEmailPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInEmailPost200Response &&
        redirect == other.redirect &&
        token == other.token &&
        url == other.url &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, redirect.hashCode);
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInEmailPost200Response')
          ..add('redirect', redirect)
          ..add('token', token)
          ..add('url', url)
          ..add('user', user))
        .toString();
  }
}

class SignInEmailPost200ResponseBuilder
    implements
        Builder<SignInEmailPost200Response, SignInEmailPost200ResponseBuilder> {
  _$SignInEmailPost200Response? _$v;

  SignInEmailPost200ResponseRedirectEnum? _redirect;
  SignInEmailPost200ResponseRedirectEnum? get redirect => _$this._redirect;
  set redirect(SignInEmailPost200ResponseRedirectEnum? redirect) =>
      _$this._redirect = redirect;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  JsonObject? _url;
  JsonObject? get url => _$this._url;
  set url(JsonObject? url) => _$this._url = url;

  SignInEmailPost200ResponseUserBuilder? _user;
  SignInEmailPost200ResponseUserBuilder get user =>
      _$this._user ??= SignInEmailPost200ResponseUserBuilder();
  set user(SignInEmailPost200ResponseUserBuilder? user) => _$this._user = user;

  SignInEmailPost200ResponseBuilder() {
    SignInEmailPost200Response._defaults(this);
  }

  SignInEmailPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _redirect = $v.redirect;
      _token = $v.token;
      _url = $v.url;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInEmailPost200Response other) {
    _$v = other as _$SignInEmailPost200Response;
  }

  @override
  void update(void Function(SignInEmailPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInEmailPost200Response build() => _build();

  _$SignInEmailPost200Response _build() {
    _$SignInEmailPost200Response _$result;
    try {
      _$result =
          _$v ??
          _$SignInEmailPost200Response._(
            redirect: BuiltValueNullFieldError.checkNotNull(
              redirect,
              r'SignInEmailPost200Response',
              'redirect',
            ),
            token: BuiltValueNullFieldError.checkNotNull(
              token,
              r'SignInEmailPost200Response',
              'token',
            ),
            url: url,
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SignInEmailPost200Response',
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
