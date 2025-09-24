// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String? id;
  @override
  final String name;
  @override
  final String email;
  @override
  final bool emailVerified;
  @override
  final String? image;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String? role;
  @override
  final bool? banned;
  @override
  final String? banReason;
  @override
  final String? banExpires;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (UserBuilder()..update(updates))._build();

  _$User._({
    this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.role,
    this.banned,
    this.banReason,
    this.banExpires,
  }) : super._();
  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        emailVerified == other.emailVerified &&
        image == other.image &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        role == other.role &&
        banned == other.banned &&
        banReason == other.banReason &&
        banExpires == other.banExpires;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, banned.hashCode);
    _$hash = $jc(_$hash, banReason.hashCode);
    _$hash = $jc(_$hash, banExpires.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('emailVerified', emailVerified)
          ..add('image', image)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('role', role)
          ..add('banned', banned)
          ..add('banReason', banReason)
          ..add('banExpires', banExpires))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  bool? _banned;
  bool? get banned => _$this._banned;
  set banned(bool? banned) => _$this._banned = banned;

  String? _banReason;
  String? get banReason => _$this._banReason;
  set banReason(String? banReason) => _$this._banReason = banReason;

  String? _banExpires;
  String? get banExpires => _$this._banExpires;
  set banExpires(String? banExpires) => _$this._banExpires = banExpires;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _emailVerified = $v.emailVerified;
      _image = $v.image;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _role = $v.role;
      _banned = $v.banned;
      _banReason = $v.banReason;
      _banExpires = $v.banExpires;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result =
        _$v ??
        _$User._(
          id: id,
          name: BuiltValueNullFieldError.checkNotNull(name, r'User', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
          emailVerified: BuiltValueNullFieldError.checkNotNull(
            emailVerified,
            r'User',
            'emailVerified',
          ),
          image: image,
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'User',
            'createdAt',
          ),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
            updatedAt,
            r'User',
            'updatedAt',
          ),
          role: role,
          banned: banned,
          banReason: banReason,
          banExpires: banExpires,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
