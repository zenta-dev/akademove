// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateOrderSuccessResponseSuccessEnum
_$createOrderSuccessResponseSuccessEnum_true_ =
    const CreateOrderSuccessResponseSuccessEnum._('true_');

CreateOrderSuccessResponseSuccessEnum
_$createOrderSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createOrderSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateOrderSuccessResponseSuccessEnum>
_$createOrderSuccessResponseSuccessEnumValues =
    BuiltSet<CreateOrderSuccessResponseSuccessEnum>(
      const <CreateOrderSuccessResponseSuccessEnum>[
        _$createOrderSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<CreateOrderSuccessResponseSuccessEnum>
_$createOrderSuccessResponseSuccessEnumSerializer =
    _$CreateOrderSuccessResponseSuccessEnumSerializer();

class _$CreateOrderSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateOrderSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateOrderSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'CreateOrderSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateOrderSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateOrderSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateOrderSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateOrderSuccessResponse extends CreateOrderSuccessResponse {
  @override
  final CreateOrderSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Order data;

  factory _$CreateOrderSuccessResponse([
    void Function(CreateOrderSuccessResponseBuilder)? updates,
  ]) => (CreateOrderSuccessResponseBuilder()..update(updates))._build();

  _$CreateOrderSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  CreateOrderSuccessResponse rebuild(
    void Function(CreateOrderSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateOrderSuccessResponseBuilder toBuilder() =>
      CreateOrderSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateOrderSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateOrderSuccessResponseBuilder
    implements
        Builder<CreateOrderSuccessResponse, CreateOrderSuccessResponseBuilder> {
  _$CreateOrderSuccessResponse? _$v;

  CreateOrderSuccessResponseSuccessEnum? _success;
  CreateOrderSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateOrderSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(OrderBuilder? data) => _$this._data = data;

  CreateOrderSuccessResponseBuilder() {
    CreateOrderSuccessResponse._defaults(this);
  }

  CreateOrderSuccessResponseBuilder get _$this {
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
  void replace(CreateOrderSuccessResponse other) {
    _$v = other as _$CreateOrderSuccessResponse;
  }

  @override
  void update(void Function(CreateOrderSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOrderSuccessResponse build() => _build();

  _$CreateOrderSuccessResponse _build() {
    _$CreateOrderSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateOrderSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'CreateOrderSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'CreateOrderSuccessResponse',
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
          r'CreateOrderSuccessResponse',
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
