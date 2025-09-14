// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_callback_get200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteUserCallbackGet200ResponseMessageEnum
    _$deleteUserCallbackGet200ResponseMessageEnum_userDeleted =
    const DeleteUserCallbackGet200ResponseMessageEnum._('userDeleted');

DeleteUserCallbackGet200ResponseMessageEnum
    _$deleteUserCallbackGet200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'userDeleted':
      return _$deleteUserCallbackGet200ResponseMessageEnum_userDeleted;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteUserCallbackGet200ResponseMessageEnum>
    _$deleteUserCallbackGet200ResponseMessageEnumValues = BuiltSet<
        DeleteUserCallbackGet200ResponseMessageEnum>(const <DeleteUserCallbackGet200ResponseMessageEnum>[
  _$deleteUserCallbackGet200ResponseMessageEnum_userDeleted,
]);

Serializer<DeleteUserCallbackGet200ResponseMessageEnum>
    _$deleteUserCallbackGet200ResponseMessageEnumSerializer =
    _$DeleteUserCallbackGet200ResponseMessageEnumSerializer();

class _$DeleteUserCallbackGet200ResponseMessageEnumSerializer
    implements
        PrimitiveSerializer<DeleteUserCallbackGet200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userDeleted': 'User deleted',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'User deleted': 'userDeleted',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteUserCallbackGet200ResponseMessageEnum
  ];
  @override
  final String wireName = 'DeleteUserCallbackGet200ResponseMessageEnum';

  @override
  Object serialize(Serializers serializers,
          DeleteUserCallbackGet200ResponseMessageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeleteUserCallbackGet200ResponseMessageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeleteUserCallbackGet200ResponseMessageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeleteUserCallbackGet200Response
    extends DeleteUserCallbackGet200Response {
  @override
  final bool success;
  @override
  final DeleteUserCallbackGet200ResponseMessageEnum message;

  factory _$DeleteUserCallbackGet200Response(
          [void Function(DeleteUserCallbackGet200ResponseBuilder)? updates]) =>
      (DeleteUserCallbackGet200ResponseBuilder()..update(updates))._build();

  _$DeleteUserCallbackGet200Response._(
      {required this.success, required this.message})
      : super._();
  @override
  DeleteUserCallbackGet200Response rebuild(
          void Function(DeleteUserCallbackGet200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteUserCallbackGet200ResponseBuilder toBuilder() =>
      DeleteUserCallbackGet200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteUserCallbackGet200Response &&
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
    return (newBuiltValueToStringHelper(r'DeleteUserCallbackGet200Response')
          ..add('success', success)
          ..add('message', message))
        .toString();
  }
}

class DeleteUserCallbackGet200ResponseBuilder
    implements
        Builder<DeleteUserCallbackGet200Response,
            DeleteUserCallbackGet200ResponseBuilder> {
  _$DeleteUserCallbackGet200Response? _$v;

  bool? _success;
  bool? get success => _$this._success;
  set success(bool? success) => _$this._success = success;

  DeleteUserCallbackGet200ResponseMessageEnum? _message;
  DeleteUserCallbackGet200ResponseMessageEnum? get message => _$this._message;
  set message(DeleteUserCallbackGet200ResponseMessageEnum? message) =>
      _$this._message = message;

  DeleteUserCallbackGet200ResponseBuilder() {
    DeleteUserCallbackGet200Response._defaults(this);
  }

  DeleteUserCallbackGet200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteUserCallbackGet200Response other) {
    _$v = other as _$DeleteUserCallbackGet200Response;
  }

  @override
  void update(void Function(DeleteUserCallbackGet200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteUserCallbackGet200Response build() => _build();

  _$DeleteUserCallbackGet200Response _build() {
    final _$result = _$v ??
        _$DeleteUserCallbackGet200Response._(
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'DeleteUserCallbackGet200Response', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'DeleteUserCallbackGet200Response', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
