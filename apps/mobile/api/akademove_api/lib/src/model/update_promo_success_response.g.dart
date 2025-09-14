// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_promo_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdatePromoSuccessResponseSuccessEnum
    _$updatePromoSuccessResponseSuccessEnum_true_ =
    const UpdatePromoSuccessResponseSuccessEnum._('true_');

UpdatePromoSuccessResponseSuccessEnum
    _$updatePromoSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updatePromoSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdatePromoSuccessResponseSuccessEnum>
    _$updatePromoSuccessResponseSuccessEnumValues = BuiltSet<
        UpdatePromoSuccessResponseSuccessEnum>(const <UpdatePromoSuccessResponseSuccessEnum>[
  _$updatePromoSuccessResponseSuccessEnum_true_,
]);

Serializer<UpdatePromoSuccessResponseSuccessEnum>
    _$updatePromoSuccessResponseSuccessEnumSerializer =
    _$UpdatePromoSuccessResponseSuccessEnumSerializer();

class _$UpdatePromoSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdatePromoSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdatePromoSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'UpdatePromoSuccessResponseSuccessEnum';

  @override
  Object serialize(
          Serializers serializers, UpdatePromoSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdatePromoSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdatePromoSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdatePromoSuccessResponse extends UpdatePromoSuccessResponse {
  @override
  final UpdatePromoSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Promo data;

  factory _$UpdatePromoSuccessResponse(
          [void Function(UpdatePromoSuccessResponseBuilder)? updates]) =>
      (UpdatePromoSuccessResponseBuilder()..update(updates))._build();

  _$UpdatePromoSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  UpdatePromoSuccessResponse rebuild(
          void Function(UpdatePromoSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdatePromoSuccessResponseBuilder toBuilder() =>
      UpdatePromoSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdatePromoSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdatePromoSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdatePromoSuccessResponseBuilder
    implements
        Builder<UpdatePromoSuccessResponse, UpdatePromoSuccessResponseBuilder> {
  _$UpdatePromoSuccessResponse? _$v;

  UpdatePromoSuccessResponseSuccessEnum? _success;
  UpdatePromoSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdatePromoSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  PromoBuilder? _data;
  PromoBuilder get data => _$this._data ??= PromoBuilder();
  set data(PromoBuilder? data) => _$this._data = data;

  UpdatePromoSuccessResponseBuilder() {
    UpdatePromoSuccessResponse._defaults(this);
  }

  UpdatePromoSuccessResponseBuilder get _$this {
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
  void replace(UpdatePromoSuccessResponse other) {
    _$v = other as _$UpdatePromoSuccessResponse;
  }

  @override
  void update(void Function(UpdatePromoSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdatePromoSuccessResponse build() => _build();

  _$UpdatePromoSuccessResponse _build() {
    _$UpdatePromoSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$UpdatePromoSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'UpdatePromoSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'UpdatePromoSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdatePromoSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
