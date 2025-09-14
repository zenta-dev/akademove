// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteUserPost200ResponseMessageEnum
_$deleteUserPost200ResponseMessageEnum_userDeleted =
    const DeleteUserPost200ResponseMessageEnum._('userDeleted');
const DeleteUserPost200ResponseMessageEnum
_$deleteUserPost200ResponseMessageEnum_verificationEmailSent =
    const DeleteUserPost200ResponseMessageEnum._('verificationEmailSent');

DeleteUserPost200ResponseMessageEnum
_$deleteUserPost200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'userDeleted':
      return _$deleteUserPost200ResponseMessageEnum_userDeleted;
    case 'verificationEmailSent':
      return _$deleteUserPost200ResponseMessageEnum_verificationEmailSent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteUserPost200ResponseMessageEnum>
_$deleteUserPost200ResponseMessageEnumValues =
    BuiltSet<DeleteUserPost200ResponseMessageEnum>(
      const <DeleteUserPost200ResponseMessageEnum>[
        _$deleteUserPost200ResponseMessageEnum_userDeleted,
        _$deleteUserPost200ResponseMessageEnum_verificationEmailSent,
      ],
    );

Serializer<DeleteUserPost200ResponseMessageEnum>
_$deleteUserPost200ResponseMessageEnumSerializer =
    _$DeleteUserPost200ResponseMessageEnumSerializer();

class _$DeleteUserPost200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<DeleteUserPost200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userDeleted': 'User deleted',
    'verificationEmailSent': 'Verification email sent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'User deleted': 'userDeleted',
    'Verification email sent': 'verificationEmailSent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteUserPost200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'DeleteUserPost200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeleteUserPost200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeleteUserPost200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeleteUserPost200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeleteUserPost200Response extends DeleteUserPost200Response {
  @override
  final bool success;
  @override
  final DeleteUserPost200ResponseMessageEnum message;

  factory _$DeleteUserPost200Response([
    void Function(DeleteUserPost200ResponseBuilder)? updates,
  ]) => (DeleteUserPost200ResponseBuilder()..update(updates))._build();

  _$DeleteUserPost200Response._({required this.success, required this.message})
    : super._();
  @override
  DeleteUserPost200Response rebuild(
    void Function(DeleteUserPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeleteUserPost200ResponseBuilder toBuilder() =>
      DeleteUserPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUserPost200Response &&
        success == other.success &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteUserPost200Response')
          ..add('success', success)
          ..add('message', message))
        .toString();
  }
}

class DeleteUserPost200ResponseBuilder
    implements
        Builder<DeleteUserPost200Response, DeleteUserPost200ResponseBuilder> {
  _$DeleteUserPost200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  DeleteUserPost200ResponseMessageEnum? _message;
  DeleteUserPost200ResponseMessageEnum? get message => _$this._message;
  set message(DeleteUserPost200ResponseMessageEnum? message) =>
      _$this._message = message;

  DeleteUserPost200ResponseBuilder() {
    DeleteUserPost200Response._defaults(this);
  }

  DeleteUserPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteUserPost200Response other) {
    _$v = other as _$DeleteUserPost200Response;
  }

  @override
  void update(void Function(DeleteUserPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUserPost200Response build() => _build();

  _$DeleteUserPost200Response _build() {
    final _$result =
        _$v ??
        _$DeleteUserPost200Response._(
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'DeleteUserPost200Response',
            'success',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DeleteUserPost200Response',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
