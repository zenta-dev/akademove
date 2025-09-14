// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_promo_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreatePromoSuccessResponseSuccessEnum
_$createPromoSuccessResponseSuccessEnum_true_ =
    const CreatePromoSuccessResponseSuccessEnum._('true_');

CreatePromoSuccessResponseSuccessEnum
_$createPromoSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createPromoSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreatePromoSuccessResponseSuccessEnum>
_$createPromoSuccessResponseSuccessEnumValues =
    BuiltSet<CreatePromoSuccessResponseSuccessEnum>(
      const <CreatePromoSuccessResponseSuccessEnum>[
        _$createPromoSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<CreatePromoSuccessResponseSuccessEnum>
_$createPromoSuccessResponseSuccessEnumSerializer =
    _$CreatePromoSuccessResponseSuccessEnumSerializer();

class _$CreatePromoSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreatePromoSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreatePromoSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'CreatePromoSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreatePromoSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreatePromoSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreatePromoSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreatePromoSuccessResponse extends CreatePromoSuccessResponse {
  @override
  final CreatePromoSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Promo data;

  factory _$CreatePromoSuccessResponse([
    void Function(CreatePromoSuccessResponseBuilder)? updates,
  ]) => (CreatePromoSuccessResponseBuilder()..update(updates))._build();

  _$CreatePromoSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  CreatePromoSuccessResponse rebuild(
    void Function(CreatePromoSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreatePromoSuccessResponseBuilder toBuilder() =>
      CreatePromoSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreatePromoSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreatePromoSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreatePromoSuccessResponseBuilder
    implements
        Builder<CreatePromoSuccessResponse, CreatePromoSuccessResponseBuilder> {
  _$CreatePromoSuccessResponse? _$v;

  CreatePromoSuccessResponseSuccessEnum? _success;
  CreatePromoSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreatePromoSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  PromoBuilder? _data;
  PromoBuilder get data => _$this._data ??= PromoBuilder();
  set data(PromoBuilder? data) => _$this._data = data;

  CreatePromoSuccessResponseBuilder() {
    CreatePromoSuccessResponse._defaults(this);
  }

  CreatePromoSuccessResponseBuilder get _$this {
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
  void replace(CreatePromoSuccessResponse other) {
    _$v = other as _$CreatePromoSuccessResponse;
  }

  @override
  void update(void Function(CreatePromoSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreatePromoSuccessResponse build() => _build();

  _$CreatePromoSuccessResponse _build() {
    _$CreatePromoSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreatePromoSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'CreatePromoSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'CreatePromoSuccessResponse',
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
          r'CreatePromoSuccessResponse',
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
