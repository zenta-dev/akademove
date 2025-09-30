// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserCreateRequestRoleEnum _$userCreateRequestRoleEnum_admin =
    const UserCreateRequestRoleEnum._('admin');
const UserCreateRequestRoleEnum _$userCreateRequestRoleEnum_operator_ =
    const UserCreateRequestRoleEnum._('operator_');
const UserCreateRequestRoleEnum _$userCreateRequestRoleEnum_merchant =
    const UserCreateRequestRoleEnum._('merchant');
const UserCreateRequestRoleEnum _$userCreateRequestRoleEnum_driver =
    const UserCreateRequestRoleEnum._('driver');
const UserCreateRequestRoleEnum _$userCreateRequestRoleEnum_user =
    const UserCreateRequestRoleEnum._('user');

UserCreateRequestRoleEnum _$userCreateRequestRoleEnumValueOf(String name) {
  switch (name) {
    case 'admin':
      return _$userCreateRequestRoleEnum_admin;
    case 'operator_':
      return _$userCreateRequestRoleEnum_operator_;
    case 'merchant':
      return _$userCreateRequestRoleEnum_merchant;
    case 'driver':
      return _$userCreateRequestRoleEnum_driver;
    case 'user':
      return _$userCreateRequestRoleEnum_user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserCreateRequestRoleEnum> _$userCreateRequestRoleEnumValues =
    BuiltSet<UserCreateRequestRoleEnum>(const <UserCreateRequestRoleEnum>[
      _$userCreateRequestRoleEnum_admin,
      _$userCreateRequestRoleEnum_operator_,
      _$userCreateRequestRoleEnum_merchant,
      _$userCreateRequestRoleEnum_driver,
      _$userCreateRequestRoleEnum_user,
    ]);

Serializer<UserCreateRequestRoleEnum> _$userCreateRequestRoleEnumSerializer =
    _$UserCreateRequestRoleEnumSerializer();

class _$UserCreateRequestRoleEnumSerializer
    implements PrimitiveSerializer<UserCreateRequestRoleEnum> {
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
  final Iterable<Type> types = const <Type>[UserCreateRequestRoleEnum];
  @override
  final String wireName = 'UserCreateRequestRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserCreateRequestRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserCreateRequestRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserCreateRequestRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UserCreateRequest extends UserCreateRequest {
  @override
  final String name;
  @override
  final String email;
  @override
  final UserCreateRequestRoleEnum? role;
  @override
  final String password;
  @override
  final String confirmPassword;

  factory _$UserCreateRequest([
    void Function(UserCreateRequestBuilder)? updates,
  ]) => (UserCreateRequestBuilder()..update(updates))._build();

  _$UserCreateRequest._({
    required this.name,
    required this.email,
    this.role,
    required this.password,
    required this.confirmPassword,
  }) : super._();
  @override
  UserCreateRequest rebuild(void Function(UserCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserCreateRequestBuilder toBuilder() =>
      UserCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserCreateRequest &&
        name == other.name &&
        email == other.email &&
        role == other.role &&
        password == other.password &&
        confirmPassword == other.confirmPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, confirmPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserCreateRequest')
          ..add('name', name)
          ..add('email', email)
          ..add('role', role)
          ..add('password', password)
          ..add('confirmPassword', confirmPassword))
        .toString();
  }
}

class UserCreateRequestBuilder
    implements Builder<UserCreateRequest, UserCreateRequestBuilder> {
  _$UserCreateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  UserCreateRequestRoleEnum? _role;
  UserCreateRequestRoleEnum? get role => _$this._role;
  set role(UserCreateRequestRoleEnum? role) => _$this._role = role;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _confirmPassword;
  String? get confirmPassword => _$this._confirmPassword;
  set confirmPassword(String? confirmPassword) =>
      _$this._confirmPassword = confirmPassword;

  UserCreateRequestBuilder() {
    UserCreateRequest._defaults(this);
  }

  UserCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _email = $v.email;
      _role = $v.role;
      _password = $v.password;
      _confirmPassword = $v.confirmPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserCreateRequest other) {
    _$v = other as _$UserCreateRequest;
  }

  @override
  void update(void Function(UserCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserCreateRequest build() => _build();

  _$UserCreateRequest _build() {
    final _$result =
        _$v ??
        _$UserCreateRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'UserCreateRequest',
            'name',
          ),
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'UserCreateRequest',
            'email',
          ),
          role: role,
          password: BuiltValueNullFieldError.checkNotNull(
            password,
            r'UserCreateRequest',
            'password',
          ),
          confirmPassword: BuiltValueNullFieldError.checkNotNull(
            confirmPassword,
            r'UserCreateRequest',
            'confirmPassword',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
