// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserRoleEnum _$userRoleEnum_admin = const UserRoleEnum._('admin');
const UserRoleEnum _$userRoleEnum_operator_ = const UserRoleEnum._('operator_');
const UserRoleEnum _$userRoleEnum_merchant = const UserRoleEnum._('merchant');
const UserRoleEnum _$userRoleEnum_driver = const UserRoleEnum._('driver');
const UserRoleEnum _$userRoleEnum_user = const UserRoleEnum._('user');

UserRoleEnum _$userRoleEnumValueOf(String name) {
  switch (name) {
    case 'admin':
      return _$userRoleEnum_admin;
    case 'operator_':
      return _$userRoleEnum_operator_;
    case 'merchant':
      return _$userRoleEnum_merchant;
    case 'driver':
      return _$userRoleEnum_driver;
    case 'user':
      return _$userRoleEnum_user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserRoleEnum> _$userRoleEnumValues =
    BuiltSet<UserRoleEnum>(const <UserRoleEnum>[
      _$userRoleEnum_admin,
      _$userRoleEnum_operator_,
      _$userRoleEnum_merchant,
      _$userRoleEnum_driver,
      _$userRoleEnum_user,
    ]);

Serializer<UserRoleEnum> _$userRoleEnumSerializer = _$UserRoleEnumSerializer();

class _$UserRoleEnumSerializer implements PrimitiveSerializer<UserRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'admin': 'admin',
    'operator_': 'operator',
    'merchant': 'merchant',
    'driver': 'driver',
    'user': 'user',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'admin': 'admin',
    'operator': 'operator_',
    'merchant': 'merchant',
    'driver': 'driver',
    'user': 'user',
  };

  @override
  final Iterable<Type> types = const <Type>[UserRoleEnum];
  @override
  final String wireName = 'UserRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$User extends User {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final bool emailVerified;
  @override
  final String? image;
  @override
  final UserRoleEnum role;
  @override
  final bool banned;
  @override
  final String? banReason;
  @override
  final num? banExpires;
  @override
  final num createdAt;
  @override
  final num updatedAt;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (UserBuilder()..update(updates))._build();

  _$User._({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    this.image,
    required this.role,
    required this.banned,
    this.banReason,
    this.banExpires,
    required this.createdAt,
    required this.updatedAt,
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
        role == other.role &&
        banned == other.banned &&
        banReason == other.banReason &&
        banExpires == other.banExpires &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, banned.hashCode);
    _$hash = $jc(_$hash, banReason.hashCode);
    _$hash = $jc(_$hash, banExpires.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
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
          ..add('role', role)
          ..add('banned', banned)
          ..add('banReason', banReason)
          ..add('banExpires', banExpires)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
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

  UserRoleEnum? _role;
  UserRoleEnum? get role => _$this._role;
  set role(UserRoleEnum? role) => _$this._role = role;

  bool? _banned;
  bool? get banned => _$this._banned;
  set banned(bool? banned) => _$this._banned = banned;

  String? _banReason;
  String? get banReason => _$this._banReason;
  set banReason(String? banReason) => _$this._banReason = banReason;

  num? _banExpires;
  num? get banExpires => _$this._banExpires;
  set banExpires(num? banExpires) => _$this._banExpires = banExpires;

  num? _createdAt;
  num? get createdAt => _$this._createdAt;
  set createdAt(num? createdAt) => _$this._createdAt = createdAt;

  num? _updatedAt;
  num? get updatedAt => _$this._updatedAt;
  set updatedAt(num? updatedAt) => _$this._updatedAt = updatedAt;

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
      _role = $v.role;
      _banned = $v.banned;
      _banReason = $v.banReason;
      _banExpires = $v.banExpires;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
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
          id: BuiltValueNullFieldError.checkNotNull(id, r'User', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'User', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
          emailVerified: BuiltValueNullFieldError.checkNotNull(
            emailVerified,
            r'User',
            'emailVerified',
          ),
          image: image,
          role: BuiltValueNullFieldError.checkNotNull(role, r'User', 'role'),
          banned: BuiltValueNullFieldError.checkNotNull(
            banned,
            r'User',
            'banned',
          ),
          banReason: banReason,
          banExpires: banExpires,
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
