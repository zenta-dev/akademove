// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_merchant_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetMerchantByIdSuccessResponseSuccessEnum
_$getMerchantByIdSuccessResponseSuccessEnum_true_ =
    const GetMerchantByIdSuccessResponseSuccessEnum._('true_');

GetMerchantByIdSuccessResponseSuccessEnum
_$getMerchantByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getMerchantByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetMerchantByIdSuccessResponseSuccessEnum>
_$getMerchantByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetMerchantByIdSuccessResponseSuccessEnum>(
      const <GetMerchantByIdSuccessResponseSuccessEnum>[
        _$getMerchantByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetMerchantByIdSuccessResponseSuccessEnum>
_$getMerchantByIdSuccessResponseSuccessEnumSerializer =
    _$GetMerchantByIdSuccessResponseSuccessEnumSerializer();

class _$GetMerchantByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetMerchantByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetMerchantByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetMerchantByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetMerchantByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetMerchantByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetMerchantByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetMerchantByIdSuccessResponse extends GetMerchantByIdSuccessResponse {
  @override
  final GetMerchantByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Merchant data;

  factory _$GetMerchantByIdSuccessResponse([
    void Function(GetMerchantByIdSuccessResponseBuilder)? updates,
  ]) => (GetMerchantByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetMerchantByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetMerchantByIdSuccessResponse rebuild(
    void Function(GetMerchantByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetMerchantByIdSuccessResponseBuilder toBuilder() =>
      GetMerchantByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetMerchantByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetMerchantByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetMerchantByIdSuccessResponseBuilder
    implements
        Builder<
          GetMerchantByIdSuccessResponse,
          GetMerchantByIdSuccessResponseBuilder
        > {
  _$GetMerchantByIdSuccessResponse? _$v;

  GetMerchantByIdSuccessResponseSuccessEnum? _success;
  GetMerchantByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetMerchantByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  MerchantBuilder? _data;
  MerchantBuilder get data => _$this._data ??= MerchantBuilder();
  set data(MerchantBuilder? data) => _$this._data = data;

  GetMerchantByIdSuccessResponseBuilder() {
    GetMerchantByIdSuccessResponse._defaults(this);
  }

  GetMerchantByIdSuccessResponseBuilder get _$this {
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
  void replace(GetMerchantByIdSuccessResponse other) {
    _$v = other as _$GetMerchantByIdSuccessResponse;
  }

  @override
  void update(void Function(GetMerchantByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetMerchantByIdSuccessResponse build() => _build();

  _$GetMerchantByIdSuccessResponse _build() {
    _$GetMerchantByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetMerchantByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetMerchantByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetMerchantByIdSuccessResponse',
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
          r'GetMerchantByIdSuccessResponse',
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
