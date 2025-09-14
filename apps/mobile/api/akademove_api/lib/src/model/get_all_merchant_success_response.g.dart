// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_merchant_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllMerchantSuccessResponseSuccessEnum
    _$getAllMerchantSuccessResponseSuccessEnum_true_ =
    const GetAllMerchantSuccessResponseSuccessEnum._('true_');

GetAllMerchantSuccessResponseSuccessEnum
    _$getAllMerchantSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllMerchantSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllMerchantSuccessResponseSuccessEnum>
    _$getAllMerchantSuccessResponseSuccessEnumValues = BuiltSet<
        GetAllMerchantSuccessResponseSuccessEnum>(const <GetAllMerchantSuccessResponseSuccessEnum>[
  _$getAllMerchantSuccessResponseSuccessEnum_true_,
]);

Serializer<GetAllMerchantSuccessResponseSuccessEnum>
    _$getAllMerchantSuccessResponseSuccessEnumSerializer =
    _$GetAllMerchantSuccessResponseSuccessEnumSerializer();

class _$GetAllMerchantSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllMerchantSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllMerchantSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'GetAllMerchantSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          GetAllMerchantSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GetAllMerchantSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GetAllMerchantSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$GetAllMerchantSuccessResponse extends GetAllMerchantSuccessResponse {
  @override
  final GetAllMerchantSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Merchant> data;

  factory _$GetAllMerchantSuccessResponse(
          [void Function(GetAllMerchantSuccessResponseBuilder)? updates]) =>
      (GetAllMerchantSuccessResponseBuilder()..update(updates))._build();

  _$GetAllMerchantSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  GetAllMerchantSuccessResponse rebuild(
          void Function(GetAllMerchantSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAllMerchantSuccessResponseBuilder toBuilder() =>
      GetAllMerchantSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllMerchantSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllMerchantSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllMerchantSuccessResponseBuilder
    implements
        Builder<GetAllMerchantSuccessResponse,
            GetAllMerchantSuccessResponseBuilder> {
  _$GetAllMerchantSuccessResponse? _$v;

  GetAllMerchantSuccessResponseSuccessEnum? _success;
  GetAllMerchantSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllMerchantSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Merchant>? _data;
  ListBuilder<Merchant> get data => _$this._data ??= ListBuilder<Merchant>();
  set data(ListBuilder<Merchant>? data) => _$this._data = data;

  GetAllMerchantSuccessResponseBuilder() {
    GetAllMerchantSuccessResponse._defaults(this);
  }

  GetAllMerchantSuccessResponseBuilder get _$this {
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
  void replace(GetAllMerchantSuccessResponse other) {
    _$v = other as _$GetAllMerchantSuccessResponse;
  }

  @override
  void update(void Function(GetAllMerchantSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllMerchantSuccessResponse build() => _build();

  _$GetAllMerchantSuccessResponse _build() {
    _$GetAllMerchantSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$GetAllMerchantSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'GetAllMerchantSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'GetAllMerchantSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GetAllMerchantSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
