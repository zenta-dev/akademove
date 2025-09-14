// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_merchant_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateMerchantSuccessResponseSuccessEnum
    _$updateMerchantSuccessResponseSuccessEnum_true_ =
    const UpdateMerchantSuccessResponseSuccessEnum._('true_');

UpdateMerchantSuccessResponseSuccessEnum
    _$updateMerchantSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateMerchantSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateMerchantSuccessResponseSuccessEnum>
    _$updateMerchantSuccessResponseSuccessEnumValues = BuiltSet<
        UpdateMerchantSuccessResponseSuccessEnum>(const <UpdateMerchantSuccessResponseSuccessEnum>[
  _$updateMerchantSuccessResponseSuccessEnum_true_,
]);

Serializer<UpdateMerchantSuccessResponseSuccessEnum>
    _$updateMerchantSuccessResponseSuccessEnumSerializer =
    _$UpdateMerchantSuccessResponseSuccessEnumSerializer();

class _$UpdateMerchantSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateMerchantSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateMerchantSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'UpdateMerchantSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          UpdateMerchantSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateMerchantSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateMerchantSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateMerchantSuccessResponse extends UpdateMerchantSuccessResponse {
  @override
  final UpdateMerchantSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Merchant data;

  factory _$UpdateMerchantSuccessResponse(
          [void Function(UpdateMerchantSuccessResponseBuilder)? updates]) =>
      (UpdateMerchantSuccessResponseBuilder()..update(updates))._build();

  _$UpdateMerchantSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  UpdateMerchantSuccessResponse rebuild(
          void Function(UpdateMerchantSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateMerchantSuccessResponseBuilder toBuilder() =>
      UpdateMerchantSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateMerchantSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateMerchantSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateMerchantSuccessResponseBuilder
    implements
        Builder<UpdateMerchantSuccessResponse,
            UpdateMerchantSuccessResponseBuilder> {
  _$UpdateMerchantSuccessResponse? _$v;

  UpdateMerchantSuccessResponseSuccessEnum? _success;
  UpdateMerchantSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateMerchantSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MerchantBuilder? _data;
  MerchantBuilder get data => _$this._data ??= MerchantBuilder();
  set data(MerchantBuilder? data) => _$this._data = data;

  UpdateMerchantSuccessResponseBuilder() {
    UpdateMerchantSuccessResponse._defaults(this);
  }

  UpdateMerchantSuccessResponseBuilder get _$this {
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
  void replace(UpdateMerchantSuccessResponse other) {
    _$v = other as _$UpdateMerchantSuccessResponse;
  }

  @override
  void update(void Function(UpdateMerchantSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateMerchantSuccessResponse build() => _build();

  _$UpdateMerchantSuccessResponse _build() {
    _$UpdateMerchantSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$UpdateMerchantSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'UpdateMerchantSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'UpdateMerchantSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateMerchantSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
