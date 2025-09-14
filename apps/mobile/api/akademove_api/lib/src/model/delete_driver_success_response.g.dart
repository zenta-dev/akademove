// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_driver_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteDriverSuccessResponseSuccessEnum
    _$deleteDriverSuccessResponseSuccessEnum_true_ =
    const DeleteDriverSuccessResponseSuccessEnum._('true_');

DeleteDriverSuccessResponseSuccessEnum
    _$deleteDriverSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteDriverSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteDriverSuccessResponseSuccessEnum>
    _$deleteDriverSuccessResponseSuccessEnumValues = BuiltSet<
        DeleteDriverSuccessResponseSuccessEnum>(const <DeleteDriverSuccessResponseSuccessEnum>[
  _$deleteDriverSuccessResponseSuccessEnum_true_,
]);

Serializer<DeleteDriverSuccessResponseSuccessEnum>
    _$deleteDriverSuccessResponseSuccessEnumSerializer =
    _$DeleteDriverSuccessResponseSuccessEnumSerializer();

class _$DeleteDriverSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteDriverSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteDriverSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'DeleteDriverSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          DeleteDriverSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeleteDriverSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeleteDriverSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeleteDriverSuccessResponse extends DeleteDriverSuccessResponse {
  @override
  final DeleteDriverSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteDriverSuccessResponse(
          [void Function(DeleteDriverSuccessResponseBuilder)? updates]) =>
      (DeleteDriverSuccessResponseBuilder()..update(updates))._build();

  _$DeleteDriverSuccessResponse._(
      {required this.success, required this.message, this.data})
      : super._();
  @override
  DeleteDriverSuccessResponse rebuild(
          void Function(DeleteDriverSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteDriverSuccessResponseBuilder toBuilder() =>
      DeleteDriverSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteDriverSuccessResponse &&
        success == other.success &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteDriverSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteDriverSuccessResponseBuilder
    implements
        Builder<DeleteDriverSuccessResponse,
            DeleteDriverSuccessResponseBuilder> {
  _$DeleteDriverSuccessResponse? _$v;

  DeleteDriverSuccessResponseSuccessEnum? _success;
  DeleteDriverSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteDriverSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteDriverSuccessResponseBuilder() {
    DeleteDriverSuccessResponse._defaults(this);
  }

  DeleteDriverSuccessResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteDriverSuccessResponse other) {
    _$v = other as _$DeleteDriverSuccessResponse;
  }

  @override
  void update(void Function(DeleteDriverSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteDriverSuccessResponse build() => _build();

  _$DeleteDriverSuccessResponse _build() {
    final _$result = _$v ??
        _$DeleteDriverSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'DeleteDriverSuccessResponse', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'DeleteDriverSuccessResponse', 'message'),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
