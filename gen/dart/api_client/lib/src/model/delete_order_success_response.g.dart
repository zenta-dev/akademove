// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_order_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteOrderSuccessResponseSuccessEnum
_$deleteOrderSuccessResponseSuccessEnum_true_ =
    const DeleteOrderSuccessResponseSuccessEnum._('true_');

DeleteOrderSuccessResponseSuccessEnum
_$deleteOrderSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteOrderSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteOrderSuccessResponseSuccessEnum>
_$deleteOrderSuccessResponseSuccessEnumValues =
    BuiltSet<DeleteOrderSuccessResponseSuccessEnum>(
      const <DeleteOrderSuccessResponseSuccessEnum>[
        _$deleteOrderSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<DeleteOrderSuccessResponseSuccessEnum>
_$deleteOrderSuccessResponseSuccessEnumSerializer =
    _$DeleteOrderSuccessResponseSuccessEnumSerializer();

class _$DeleteOrderSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteOrderSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteOrderSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'DeleteOrderSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeleteOrderSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeleteOrderSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeleteOrderSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeleteOrderSuccessResponse extends DeleteOrderSuccessResponse {
  @override
  final DeleteOrderSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteOrderSuccessResponse([
    void Function(DeleteOrderSuccessResponseBuilder)? updates,
  ]) => (DeleteOrderSuccessResponseBuilder()..update(updates))._build();

  _$DeleteOrderSuccessResponse._({
    required this.success,
    required this.message,
    this.data,
  }) : super._();
  @override
  DeleteOrderSuccessResponse rebuild(
    void Function(DeleteOrderSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeleteOrderSuccessResponseBuilder toBuilder() =>
      DeleteOrderSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteOrderSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeleteOrderSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteOrderSuccessResponseBuilder
    implements
        Builder<DeleteOrderSuccessResponse, DeleteOrderSuccessResponseBuilder> {
  _$DeleteOrderSuccessResponse? _$v;

  DeleteOrderSuccessResponseSuccessEnum? _success;
  DeleteOrderSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteOrderSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteOrderSuccessResponseBuilder() {
    DeleteOrderSuccessResponse._defaults(this);
  }

  DeleteOrderSuccessResponseBuilder get _$this {
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
  void replace(DeleteOrderSuccessResponse other) {
    _$v = other as _$DeleteOrderSuccessResponse;
  }

  @override
  void update(void Function(DeleteOrderSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteOrderSuccessResponse build() => _build();

  _$DeleteOrderSuccessResponse _build() {
    final _$result =
        _$v ??
        _$DeleteOrderSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'DeleteOrderSuccessResponse',
            'success',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DeleteOrderSuccessResponse',
            'message',
          ),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
