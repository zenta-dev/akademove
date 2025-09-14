// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_promo_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetPromoByIdSuccessResponseSuccessEnum
_$getPromoByIdSuccessResponseSuccessEnum_true_ =
    const GetPromoByIdSuccessResponseSuccessEnum._('true_');

GetPromoByIdSuccessResponseSuccessEnum
_$getPromoByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getPromoByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetPromoByIdSuccessResponseSuccessEnum>
_$getPromoByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetPromoByIdSuccessResponseSuccessEnum>(
      const <GetPromoByIdSuccessResponseSuccessEnum>[
        _$getPromoByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetPromoByIdSuccessResponseSuccessEnum>
_$getPromoByIdSuccessResponseSuccessEnumSerializer =
    _$GetPromoByIdSuccessResponseSuccessEnumSerializer();

class _$GetPromoByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetPromoByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetPromoByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetPromoByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetPromoByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetPromoByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetPromoByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetPromoByIdSuccessResponse extends GetPromoByIdSuccessResponse {
  @override
  final GetPromoByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Promo data;

  factory _$GetPromoByIdSuccessResponse([
    void Function(GetPromoByIdSuccessResponseBuilder)? updates,
  ]) => (GetPromoByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetPromoByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetPromoByIdSuccessResponse rebuild(
    void Function(GetPromoByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetPromoByIdSuccessResponseBuilder toBuilder() =>
      GetPromoByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetPromoByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetPromoByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetPromoByIdSuccessResponseBuilder
    implements
        Builder<
          GetPromoByIdSuccessResponse,
          GetPromoByIdSuccessResponseBuilder
        > {
  _$GetPromoByIdSuccessResponse? _$v;

  GetPromoByIdSuccessResponseSuccessEnum? _success;
  GetPromoByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetPromoByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  PromoBuilder? _data;
  PromoBuilder get data => _$this._data ??= PromoBuilder();
  set data(PromoBuilder? data) => _$this._data = data;

  GetPromoByIdSuccessResponseBuilder() {
    GetPromoByIdSuccessResponse._defaults(this);
  }

  GetPromoByIdSuccessResponseBuilder get _$this {
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
  void replace(GetPromoByIdSuccessResponse other) {
    _$v = other as _$GetPromoByIdSuccessResponse;
  }

  @override
  void update(void Function(GetPromoByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetPromoByIdSuccessResponse build() => _build();

  _$GetPromoByIdSuccessResponse _build() {
    _$GetPromoByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetPromoByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetPromoByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetPromoByIdSuccessResponse',
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
          r'GetPromoByIdSuccessResponse',
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
