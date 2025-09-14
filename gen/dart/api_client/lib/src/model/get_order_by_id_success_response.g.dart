// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetOrderByIdSuccessResponseSuccessEnum
_$getOrderByIdSuccessResponseSuccessEnum_true_ =
    const GetOrderByIdSuccessResponseSuccessEnum._('true_');

GetOrderByIdSuccessResponseSuccessEnum
_$getOrderByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getOrderByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetOrderByIdSuccessResponseSuccessEnum>
_$getOrderByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetOrderByIdSuccessResponseSuccessEnum>(
      const <GetOrderByIdSuccessResponseSuccessEnum>[
        _$getOrderByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetOrderByIdSuccessResponseSuccessEnum>
_$getOrderByIdSuccessResponseSuccessEnumSerializer =
    _$GetOrderByIdSuccessResponseSuccessEnumSerializer();

class _$GetOrderByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetOrderByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetOrderByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetOrderByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetOrderByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetOrderByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetOrderByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetOrderByIdSuccessResponse extends GetOrderByIdSuccessResponse {
  @override
  final GetOrderByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Order data;

  factory _$GetOrderByIdSuccessResponse([
    void Function(GetOrderByIdSuccessResponseBuilder)? updates,
  ]) => (GetOrderByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetOrderByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetOrderByIdSuccessResponse rebuild(
    void Function(GetOrderByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetOrderByIdSuccessResponseBuilder toBuilder() =>
      GetOrderByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetOrderByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetOrderByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetOrderByIdSuccessResponseBuilder
    implements
        Builder<
          GetOrderByIdSuccessResponse,
          GetOrderByIdSuccessResponseBuilder
        > {
  _$GetOrderByIdSuccessResponse? _$v;

  GetOrderByIdSuccessResponseSuccessEnum? _success;
  GetOrderByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetOrderByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  OrderBuilder? _data;
  OrderBuilder get data => _$this._data ??= OrderBuilder();
  set data(OrderBuilder? data) => _$this._data = data;

  GetOrderByIdSuccessResponseBuilder() {
    GetOrderByIdSuccessResponse._defaults(this);
  }

  GetOrderByIdSuccessResponseBuilder get _$this {
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
  void replace(GetOrderByIdSuccessResponse other) {
    _$v = other as _$GetOrderByIdSuccessResponse;
  }

  @override
  void update(void Function(GetOrderByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetOrderByIdSuccessResponse build() => _build();

  _$GetOrderByIdSuccessResponse _build() {
    _$GetOrderByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetOrderByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetOrderByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetOrderByIdSuccessResponse',
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
          r'GetOrderByIdSuccessResponse',
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
