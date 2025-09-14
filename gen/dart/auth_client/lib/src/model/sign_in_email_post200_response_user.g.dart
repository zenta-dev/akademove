// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_email_post200_response_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignInEmailPost200ResponseUser extends SignInEmailPost200ResponseUser {
  @override
  final String id;
  @override
  final String email;
  @override
  final String? name;
  @override
  final String? image;
  @override
  final bool emailVerified;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$SignInEmailPost200ResponseUser([
    void Function(SignInEmailPost200ResponseUserBuilder)? updates,
  ]) => (SignInEmailPost200ResponseUserBuilder()..update(updates))._build();

  _$SignInEmailPost200ResponseUser._({
    required this.id,
    required this.email,
    this.name,
    this.image,
    required this.emailVerified,
    required this.createdAt,
    required this.updatedAt,
  }) : super._();
  @override
  SignInEmailPost200ResponseUser rebuild(
    void Function(SignInEmailPost200ResponseUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SignInEmailPost200ResponseUserBuilder toBuilder() =>
      SignInEmailPost200ResponseUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInEmailPost200ResponseUser &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        image == other.image &&
        emailVerified == other.emailVerified &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignInEmailPost200ResponseUser')
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('image', image)
          ..add('emailVerified', emailVerified)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SignInEmailPost200ResponseUserBuilder
    implements
        Builder<
          SignInEmailPost200ResponseUser,
          SignInEmailPost200ResponseUserBuilder
        > {
  _$SignInEmailPost200ResponseUser? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SignInEmailPost200ResponseUserBuilder() {
    SignInEmailPost200ResponseUser._defaults(this);
  }

  SignInEmailPost200ResponseUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _image = $v.image;
      _emailVerified = $v.emailVerified;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInEmailPost200ResponseUser other) {
    _$v = other as _$SignInEmailPost200ResponseUser;
  }

  @override
  void update(void Function(SignInEmailPost200ResponseUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignInEmailPost200ResponseUser build() => _build();

  _$SignInEmailPost200ResponseUser _build() {
    final _$result =
        _$v ??
        _$SignInEmailPost200ResponseUser._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'SignInEmailPost200ResponseUser',
            'id',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'SignInEmailPost200ResponseUser',
            'email',
          ),
          name: name,
          image: image,
          emailVerified: BuiltValueNullFieldError.checkNotNull(
            emailVerified,
            r'SignInEmailPost200ResponseUser',
            'emailVerified',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'SignInEmailPost200ResponseUser',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'SignInEmailPost200ResponseUser',
            'updatedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
