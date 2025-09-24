// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_role_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnum_admin =
    const UpdateUserRoleRequestRoleEnum._('admin');
const UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnum_operator_ =
    const UpdateUserRoleRequestRoleEnum._('operator_');
const UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnum_merchant =
    const UpdateUserRoleRequestRoleEnum._('merchant');
const UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnum_driver =
    const UpdateUserRoleRequestRoleEnum._('driver');
const UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnum_user =
    const UpdateUserRoleRequestRoleEnum._('user');

UpdateUserRoleRequestRoleEnum _$updateUserRoleRequestRoleEnumValueOf(
  String name,
) {
  switch (name) {
    case 'admin':
      return _$updateUserRoleRequestRoleEnum_admin;
    case 'operator_':
      return _$updateUserRoleRequestRoleEnum_operator_;
    case 'merchant':
      return _$updateUserRoleRequestRoleEnum_merchant;
    case 'driver':
      return _$updateUserRoleRequestRoleEnum_driver;
    case 'user':
      return _$updateUserRoleRequestRoleEnum_user;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateUserRoleRequestRoleEnum>
_$updateUserRoleRequestRoleEnumValues = BuiltSet<UpdateUserRoleRequestRoleEnum>(
  const <UpdateUserRoleRequestRoleEnum>[
    _$updateUserRoleRequestRoleEnum_admin,
    _$updateUserRoleRequestRoleEnum_operator_,
    _$updateUserRoleRequestRoleEnum_merchant,
    _$updateUserRoleRequestRoleEnum_driver,
    _$updateUserRoleRequestRoleEnum_user,
  ],
);

Serializer<UpdateUserRoleRequestRoleEnum>
_$updateUserRoleRequestRoleEnumSerializer =
    _$UpdateUserRoleRequestRoleEnumSerializer();

class _$UpdateUserRoleRequestRoleEnumSerializer
    implements PrimitiveSerializer<UpdateUserRoleRequestRoleEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateUserRoleRequestRoleEnum];
  @override
  final String wireName = 'UpdateUserRoleRequestRoleEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateUserRoleRequestRoleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateUserRoleRequestRoleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateUserRoleRequestRoleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateUserRoleRequest extends UpdateUserRoleRequest {
  @override
  final UpdateUserRoleRequestRoleEnum role;

  factory _$UpdateUserRoleRequest([
    void Function(UpdateUserRoleRequestBuilder)? updates,
  ]) => (UpdateUserRoleRequestBuilder()..update(updates))._build();

  _$UpdateUserRoleRequest._({required this.role}) : super._();
  @override
  UpdateUserRoleRequest rebuild(
    void Function(UpdateUserRoleRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateUserRoleRequestBuilder toBuilder() =>
      UpdateUserRoleRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserRoleRequest && role == other.role;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'UpdateUserRoleRequest',
    )..add('role', role)).toString();
  }
}

class UpdateUserRoleRequestBuilder
    implements Builder<UpdateUserRoleRequest, UpdateUserRoleRequestBuilder> {
  _$UpdateUserRoleRequest? _$v;

  UpdateUserRoleRequestRoleEnum? _role;
  UpdateUserRoleRequestRoleEnum? get role => _$this._role;
  set role(UpdateUserRoleRequestRoleEnum? role) => _$this._role = role;

  UpdateUserRoleRequestBuilder() {
    UpdateUserRoleRequest._defaults(this);
  }

  UpdateUserRoleRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserRoleRequest other) {
    _$v = other as _$UpdateUserRoleRequest;
  }

  @override
  void update(void Function(UpdateUserRoleRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserRoleRequest build() => _build();

  _$UpdateUserRoleRequest _build() {
    final _$result =
        _$v ??
        _$UpdateUserRoleRequest._(
          role: BuiltValueNullFieldError.checkNotNull(
            role,
            r'UpdateUserRoleRequest',
            'role',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
