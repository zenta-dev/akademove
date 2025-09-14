// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateOrderSuccessResponseSuccessEnum
_$updateOrderSuccessResponseSuccessEnum_true_ =
    const UpdateOrderSuccessResponseSuccessEnum._('true_');

UpdateOrderSuccessResponseSuccessEnum
_$updateOrderSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateOrderSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateOrderSuccessResponseSuccessEnum>
_$updateOrderSuccessResponseSuccessEnumValues =
    BuiltSet<UpdateOrderSuccessResponseSuccessEnum>(
      const <UpdateOrderSuccessResponseSuccessEnum>[
        _$updateOrderSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<UpdateOrderSuccessResponseSuccessEnum>
_$updateOrderSuccessResponseSuccessEnumSerializer =
    _$UpdateOrderSuccessResponseSuccessEnumSerializer();

class _$UpdateOrderSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateOrderSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateOrderSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'UpdateOrderSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateOrderSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateOrderSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateOrderSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateOrderSuccessResponse extends UpdateOrderSuccessResponse {
  @override
  final UpdateOrderSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Order data;

  factory _$UpdateOrderSuccessResponse([
    void Function(UpdateOrderSuccessResponseBuilder)? updates,
  ]) => (UpdateOrderSuccessResponseBuilder()..update(updates))._build();

  _$UpdateOrderSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  UpdateOrderSuccessResponse rebuild(
    void Function(UpdateOrderSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateOrderSuccessResponseBuilder toBuilder() =>
      UpdateOrderSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateOrderSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateOrderSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateOrderSuccessResponseBuilder
    implements
        Builder<UpdateOrderSuccessResponse, UpdateOrderSuccessResponseBuilder> {
  _$UpdateOrderSuccessResponse? _$v;

  UpdateOrderSuccessResponseSuccessEnum? _success;
  UpdateOrderSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateOrderSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(OrderBuilder? data) => _$this._data = data;

  UpdateOrderSuccessResponseBuilder() {
    UpdateOrderSuccessResponse._defaults(this);
  }

  UpdateOrderSuccessResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateOrderSuccessResponse other) {
    _$v = other as _$UpdateOrderSuccessResponse;
  }

  @override
  void update(void Function(UpdateOrderSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateOrderSuccessResponse build() => _build();

  _$UpdateOrderSuccessResponse _build() {
    _$UpdateOrderSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateOrderSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'UpdateOrderSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UpdateOrderSuccessResponse',
              'message',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateOrderSuccessResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
