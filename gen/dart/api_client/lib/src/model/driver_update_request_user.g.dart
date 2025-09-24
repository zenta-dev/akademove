// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_update_request_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DriverUpdateRequestUserRoleEnum _$driverUpdateRequestUserRoleEnum_admin =
    const DriverUpdateRequestUserRoleEnum._('admin');
const DriverUpdateRequestUserRoleEnum
_$driverUpdateRequestUserRoleEnum_operator_ =
    const DriverUpdateRequestUserRoleEnum._('operator_');
const DriverUpdateRequestUserRoleEnum
_$driverUpdateRequestUserRoleEnum_merchant =
    const DriverUpdateRequestUserRoleEnum._('merchant');
const DriverUpdateRequestUserRoleEnum _$driverUpdateRequestUserRoleEnum_driver =
    const DriverUpdateRequestUserRoleEnum._('driver');
const DriverUpdateRequestUserRoleEnum _$driverUpdateRequestUserRoleEnum_user =
    const DriverUpdateRequestUserRoleEnum._('user');

DriverUpdateRequestUserRoleEnum _$driverUpdateRequestUserRoleEnumValueOf(
  String name,
) {
  switch (name) {
    case 'admin':
      return _$driverUpdateRequestUserRoleEnum_admin;
    case 'operator_':
      return _$driverUpdateRequestUserRoleEnum_operator_;
    case 'merchant':
      return _$driverUpdateRequestUserRoleEnum_merchant;
    case 'driver':
      return _$driverUpdateRequestUserRoleEnum_driver;
    case 'user':
      return _$driverUpdateRequestUserRoleEnum_user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DriverUpdateRequestUserRoleEnum>
_$driverUpdateRequestUserRoleEnumValues =
    BuiltSet<DriverUpdateRequestUserRoleEnum>(
      const <DriverUpdateRequestUserRoleEnum>[
        _$driverUpdateRequestUserRoleEnum_admin,
        _$driverUpdateRequestUserRoleEnum_operator_,
        _$driverUpdateRequestUserRoleEnum_merchant,
        _$driverUpdateRequestUserRoleEnum_driver,
        _$driverUpdateRequestUserRoleEnum_user,
      ],
    );

Serializer<DriverUpdateRequestUserRoleEnum>
_$driverUpdateRequestUserRoleEnumSerializer =
    _$DriverUpdateRequestUserRoleEnumSerializer();

class _$DriverUpdateRequestUserRoleEnumSerializer
    implements PrimitiveSerializer<DriverUpdateRequestUserRoleEnum> {
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
  final Iterable<Type> types = const <Type>[DriverUpdateRequestUserRoleEnum];
  @override
  final String wireName = 'DriverUpdateRequestUserRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    DriverUpdateRequestUserRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DriverUpdateRequestUserRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DriverUpdateRequestUserRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DriverUpdateRequestUser extends DriverUpdateRequestUser {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final bool? emailVerified;
  @override
  final String? image;
  @override
  final DriverUpdateRequestUserRoleEnum? role;
  @override
  final bool? banned;
  @override
  final String? banReason;
  @override
  final num? banExpires;
  @override
  final num? createdAt;
  @override
  final num? updatedAt;

  factory _$DriverUpdateRequestUser([
    void Function(DriverUpdateRequestUserBuilder)? updates,
  ]) => (DriverUpdateRequestUserBuilder()..update(updates))._build();

  _$DriverUpdateRequestUser._({
    this.id,
    this.name,
    this.email,
    this.emailVerified,
    this.image,
    this.role,
    this.banned,
    this.banReason,
    this.banExpires,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  DriverUpdateRequestUser rebuild(
    void Function(DriverUpdateRequestUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DriverUpdateRequestUserBuilder toBuilder() =>
      DriverUpdateRequestUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DriverUpdateRequestUser &&
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
    return (newBuiltValueToStringHelper(r'DriverUpdateRequestUser')
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

class DriverUpdateRequestUserBuilder
    implements
        Builder<DriverUpdateRequestUser, DriverUpdateRequestUserBuilder> {
  _$DriverUpdateRequestUser? _$v;

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

  DriverUpdateRequestUserRoleEnum? _role;
  DriverUpdateRequestUserRoleEnum? get role => _$this._role;
  set role(DriverUpdateRequestUserRoleEnum? role) => _$this._role = role;

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

  DriverUpdateRequestUserBuilder() {
    DriverUpdateRequestUser._defaults(this);
  }

  DriverUpdateRequestUserBuilder get _$this {
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
  void replace(DriverUpdateRequestUser other) {
    _$v = other as _$DriverUpdateRequestUser;
  }

  @override
  void update(void Function(DriverUpdateRequestUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DriverUpdateRequestUser build() => _build();

  _$DriverUpdateRequestUser _build() {
    final _$result =
        _$v ??
        _$DriverUpdateRequestUser._(
          id: id,
          name: name,
          email: email,
          emailVerified: emailVerified,
          image: image,
          role: role,
          banned: banned,
          banReason: banReason,
          banExpires: banExpires,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
