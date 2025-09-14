// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_promo_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllPromoSuccessResponseSuccessEnum
_$getAllPromoSuccessResponseSuccessEnum_true_ =
    const GetAllPromoSuccessResponseSuccessEnum._('true_');

GetAllPromoSuccessResponseSuccessEnum
_$getAllPromoSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllPromoSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllPromoSuccessResponseSuccessEnum>
_$getAllPromoSuccessResponseSuccessEnumValues =
    BuiltSet<GetAllPromoSuccessResponseSuccessEnum>(
      const <GetAllPromoSuccessResponseSuccessEnum>[
        _$getAllPromoSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetAllPromoSuccessResponseSuccessEnum>
_$getAllPromoSuccessResponseSuccessEnumSerializer =
    _$GetAllPromoSuccessResponseSuccessEnumSerializer();

class _$GetAllPromoSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllPromoSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllPromoSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetAllPromoSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetAllPromoSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetAllPromoSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetAllPromoSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetAllPromoSuccessResponse extends GetAllPromoSuccessResponse {
  @override
  final GetAllPromoSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Promo> data;

  factory _$GetAllPromoSuccessResponse([
    void Function(GetAllPromoSuccessResponseBuilder)? updates,
  ]) => (GetAllPromoSuccessResponseBuilder()..update(updates))._build();

  _$GetAllPromoSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetAllPromoSuccessResponse rebuild(
    void Function(GetAllPromoSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetAllPromoSuccessResponseBuilder toBuilder() =>
      GetAllPromoSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllPromoSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllPromoSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllPromoSuccessResponseBuilder
    implements
        Builder<GetAllPromoSuccessResponse, GetAllPromoSuccessResponseBuilder> {
  _$GetAllPromoSuccessResponse? _$v;

  GetAllPromoSuccessResponseSuccessEnum? _success;
  GetAllPromoSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllPromoSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Promo>? _data;
  ListBuilder<Promo> get data => _$this._data ??= ListBuilder<Promo>();
  set data(ListBuilder<Promo>? data) => _$this._data = data;

  GetAllPromoSuccessResponseBuilder() {
    GetAllPromoSuccessResponse._defaults(this);
  }

  GetAllPromoSuccessResponseBuilder get _$this {
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
  void replace(GetAllPromoSuccessResponse other) {
    _$v = other as _$GetAllPromoSuccessResponse;
  }

  @override
  void update(void Function(GetAllPromoSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllPromoSuccessResponse build() => _build();

  _$GetAllPromoSuccessResponse _build() {
    _$GetAllPromoSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetAllPromoSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetAllPromoSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetAllPromoSuccessResponse',
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
          r'GetAllPromoSuccessResponse',
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
