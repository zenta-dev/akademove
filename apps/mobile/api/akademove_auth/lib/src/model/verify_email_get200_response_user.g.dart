// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_get200_response_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyEmailGet200ResponseUser extends VerifyEmailGet200ResponseUser {
  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String image;
  @override
  final bool emailVerified;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  factory _$VerifyEmailGet200ResponseUser(
          [void Function(VerifyEmailGet200ResponseUserBuilder)? updates]) =>
      (VerifyEmailGet200ResponseUserBuilder()..update(updates))._build();

  _$VerifyEmailGet200ResponseUser._(
      {required this.id,
      required this.email,
      required this.name,
      required this.image,
      required this.emailVerified,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  VerifyEmailGet200ResponseUser rebuild(
          void Function(VerifyEmailGet200ResponseUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyEmailGet200ResponseUserBuilder toBuilder() =>
      VerifyEmailGet200ResponseUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyEmailGet200ResponseUser &&
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
    return (newBuiltValueToStringHelper(r'VerifyEmailGet200ResponseUser')
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

class VerifyEmailGet200ResponseUserBuilder
    implements
        Builder<VerifyEmailGet200ResponseUser,
            VerifyEmailGet200ResponseUserBuilder> {
  _$VerifyEmailGet200ResponseUser? _$v;

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

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  VerifyEmailGet200ResponseUserBuilder() {
    VerifyEmailGet200ResponseUser._defaults(this);
  }

  VerifyEmailGet200ResponseUserBuilder get _$this {
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
  void replace(VerifyEmailGet200ResponseUser other) {
    _$v = other as _$VerifyEmailGet200ResponseUser;
  }

  @override
  void update(void Function(VerifyEmailGet200ResponseUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyEmailGet200ResponseUser build() => _build();

  _$VerifyEmailGet200ResponseUser _build() {
    final _$result = _$v ??
        _$VerifyEmailGet200ResponseUser._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'VerifyEmailGet200ResponseUser', 'id'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'VerifyEmailGet200ResponseUser', 'email'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'VerifyEmailGet200ResponseUser', 'name'),
          image: BuiltValueNullFieldError.checkNotNull(
              image, r'VerifyEmailGet200ResponseUser', 'image'),
          emailVerified: BuiltValueNullFieldError.checkNotNull(
              emailVerified, r'VerifyEmailGet200ResponseUser', 'emailVerified'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'VerifyEmailGet200ResponseUser', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'VerifyEmailGet200ResponseUser', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
