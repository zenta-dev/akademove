// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_order_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllOrderSuccessResponseSuccessEnum
    _$getAllOrderSuccessResponseSuccessEnum_true_ =
    const GetAllOrderSuccessResponseSuccessEnum._('true_');

GetAllOrderSuccessResponseSuccessEnum
    _$getAllOrderSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllOrderSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllOrderSuccessResponseSuccessEnum>
    _$getAllOrderSuccessResponseSuccessEnumValues = BuiltSet<
        GetAllOrderSuccessResponseSuccessEnum>(const <GetAllOrderSuccessResponseSuccessEnum>[
  _$getAllOrderSuccessResponseSuccessEnum_true_,
]);

Serializer<GetAllOrderSuccessResponseSuccessEnum>
    _$getAllOrderSuccessResponseSuccessEnumSerializer =
    _$GetAllOrderSuccessResponseSuccessEnumSerializer();

class _$GetAllOrderSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllOrderSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllOrderSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'GetAllOrderSuccessResponseSuccessEnum';

  @override
  Object serialize(
          Serializers serializers, GetAllOrderSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GetAllOrderSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GetAllOrderSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GetAllOrderSuccessResponse extends GetAllOrderSuccessResponse {
  @override
  final GetAllOrderSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Order> data;

  factory _$GetAllOrderSuccessResponse(
          [void Function(GetAllOrderSuccessResponseBuilder)? updates]) =>
      (GetAllOrderSuccessResponseBuilder()..update(updates))._build();

  _$GetAllOrderSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  GetAllOrderSuccessResponse rebuild(
          void Function(GetAllOrderSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAllOrderSuccessResponseBuilder toBuilder() =>
      GetAllOrderSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllOrderSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllOrderSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllOrderSuccessResponseBuilder
    implements
        Builder<GetAllOrderSuccessResponse, GetAllOrderSuccessResponseBuilder> {
  _$GetAllOrderSuccessResponse? _$v;

  GetAllOrderSuccessResponseSuccessEnum? _success;
  GetAllOrderSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllOrderSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Order>? _data;
  ListBuilder<Order> get data => _$this._data ??= ListBuilder<Order>();
  set data(ListBuilder<Order>? data) => _$this._data = data;

  GetAllOrderSuccessResponseBuilder() {
    GetAllOrderSuccessResponse._defaults(this);
  }

  GetAllOrderSuccessResponseBuilder get _$this {
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
  void replace(GetAllOrderSuccessResponse other) {
    _$v = other as _$GetAllOrderSuccessResponse;
  }

  @override
  void update(void Function(GetAllOrderSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllOrderSuccessResponse build() => _build();

  _$GetAllOrderSuccessResponse _build() {
    _$GetAllOrderSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$GetAllOrderSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'GetAllOrderSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'GetAllOrderSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetAllOrderSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
