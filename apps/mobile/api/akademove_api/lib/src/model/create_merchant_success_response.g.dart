// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_merchant_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateMerchantSuccessResponseSuccessEnum
    _$createMerchantSuccessResponseSuccessEnum_true_ =
    const CreateMerchantSuccessResponseSuccessEnum._('true_');

CreateMerchantSuccessResponseSuccessEnum
    _$createMerchantSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createMerchantSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateMerchantSuccessResponseSuccessEnum>
    _$createMerchantSuccessResponseSuccessEnumValues = BuiltSet<
        CreateMerchantSuccessResponseSuccessEnum>(const <CreateMerchantSuccessResponseSuccessEnum>[
  _$createMerchantSuccessResponseSuccessEnum_true_,
]);

Serializer<CreateMerchantSuccessResponseSuccessEnum>
    _$createMerchantSuccessResponseSuccessEnumSerializer =
    _$CreateMerchantSuccessResponseSuccessEnumSerializer();

class _$CreateMerchantSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateMerchantSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateMerchantSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'CreateMerchantSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          CreateMerchantSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateMerchantSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateMerchantSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateMerchantSuccessResponse extends CreateMerchantSuccessResponse {
  @override
  final CreateMerchantSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Merchant data;

  factory _$CreateMerchantSuccessResponse(
          [void Function(CreateMerchantSuccessResponseBuilder)? updates]) =>
      (CreateMerchantSuccessResponseBuilder()..update(updates))._build();

  _$CreateMerchantSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  CreateMerchantSuccessResponse rebuild(
          void Function(CreateMerchantSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateMerchantSuccessResponseBuilder toBuilder() =>
      CreateMerchantSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMerchantSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateMerchantSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateMerchantSuccessResponseBuilder
    implements
        Builder<CreateMerchantSuccessResponse,
            CreateMerchantSuccessResponseBuilder> {
  _$CreateMerchantSuccessResponse? _$v;

  CreateMerchantSuccessResponseSuccessEnum? _success;
  CreateMerchantSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateMerchantSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MerchantBuilder? _data;
  MerchantBuilder get data => _$this._data ??= MerchantBuilder();
  set data(MerchantBuilder? data) => _$this._data = data;

  CreateMerchantSuccessResponseBuilder() {
    CreateMerchantSuccessResponse._defaults(this);
  }

  CreateMerchantSuccessResponseBuilder get _$this {
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
  void replace(CreateMerchantSuccessResponse other) {
    _$v = other as _$CreateMerchantSuccessResponse;
  }

  @override
  void update(void Function(CreateMerchantSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMerchantSuccessResponse build() => _build();

  _$CreateMerchantSuccessResponse _build() {
    _$CreateMerchantSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$CreateMerchantSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'CreateMerchantSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'CreateMerchantSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateMerchantSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
