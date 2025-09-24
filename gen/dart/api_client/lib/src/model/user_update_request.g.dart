// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnum_admin =
    const UserUpdateRequestRoleEnum._('admin');
const UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnum_operator_ =
    const UserUpdateRequestRoleEnum._('operator_');
const UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnum_merchant =
    const UserUpdateRequestRoleEnum._('merchant');
const UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnum_driver =
    const UserUpdateRequestRoleEnum._('driver');
const UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnum_user =
    const UserUpdateRequestRoleEnum._('user');

UserUpdateRequestRoleEnum _$userUpdateRequestRoleEnumValueOf(String name) {
  switch (name) {
    case 'admin':
      return _$userUpdateRequestRoleEnum_admin;
    case 'operator_':
      return _$userUpdateRequestRoleEnum_operator_;
    case 'merchant':
      return _$userUpdateRequestRoleEnum_merchant;
    case 'driver':
      return _$userUpdateRequestRoleEnum_driver;
    case 'user':
      return _$userUpdateRequestRoleEnum_user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserUpdateRequestRoleEnum> _$userUpdateRequestRoleEnumValues =
    BuiltSet<UserUpdateRequestRoleEnum>(const <UserUpdateRequestRoleEnum>[
      _$userUpdateRequestRoleEnum_admin,
      _$userUpdateRequestRoleEnum_operator_,
      _$userUpdateRequestRoleEnum_merchant,
      _$userUpdateRequestRoleEnum_driver,
      _$userUpdateRequestRoleEnum_user,
    ]);

Serializer<UserUpdateRequestRoleEnum> _$userUpdateRequestRoleEnumSerializer =
    _$UserUpdateRequestRoleEnumSerializer();

class _$UserUpdateRequestRoleEnumSerializer
    implements PrimitiveSerializer<UserUpdateRequestRoleEnum> {
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
  final Iterable<Type> types = const <Type>[UserUpdateRequestRoleEnum];
  @override
  final String wireName = 'UserUpdateRequestRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    UserUpdateRequestRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UserUpdateRequestRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UserUpdateRequestRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UserUpdateRequest extends UserUpdateRequest {
  @override
  final AnyOf anyOf;

  factory _$UserUpdateRequest([
    void Function(UserUpdateRequestBuilder)? updates,
  ]) => (UserUpdateRequestBuilder()..update(updates))._build();

  _$UserUpdateRequest._({required this.anyOf}) : super._();
  @override
  UserUpdateRequest rebuild(void Function(UserUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserUpdateRequestBuilder toBuilder() =>
      UserUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserUpdateRequest && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UserUpdateRequest',
    )..add('anyOf', anyOf)).toString();
  }
}

class UserUpdateRequestBuilder
    implements Builder<UserUpdateRequest, UserUpdateRequestBuilder> {
  _$UserUpdateRequest? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  UserUpdateRequestBuilder() {
    UserUpdateRequest._defaults(this);
  }

  UserUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserUpdateRequest other) {
    _$v = other as _$UserUpdateRequest;
  }

  @override
  void update(void Function(UserUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserUpdateRequest build() => _build();

  _$UserUpdateRequest _build() {
    final _$result =
        _$v ??
        _$UserUpdateRequest._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'UserUpdateRequest',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
