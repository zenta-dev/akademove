// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_merchant_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteMerchantSuccessResponseSuccessEnum
_$deleteMerchantSuccessResponseSuccessEnum_true_ =
    const DeleteMerchantSuccessResponseSuccessEnum._('true_');

DeleteMerchantSuccessResponseSuccessEnum
_$deleteMerchantSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteMerchantSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteMerchantSuccessResponseSuccessEnum>
_$deleteMerchantSuccessResponseSuccessEnumValues =
    BuiltSet<DeleteMerchantSuccessResponseSuccessEnum>(
      const <DeleteMerchantSuccessResponseSuccessEnum>[
        _$deleteMerchantSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<DeleteMerchantSuccessResponseSuccessEnum>
_$deleteMerchantSuccessResponseSuccessEnumSerializer =
    _$DeleteMerchantSuccessResponseSuccessEnumSerializer();

class _$DeleteMerchantSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteMerchantSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteMerchantSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'DeleteMerchantSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeleteMerchantSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeleteMerchantSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeleteMerchantSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeleteMerchantSuccessResponse extends DeleteMerchantSuccessResponse {
  @override
  final DeleteMerchantSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteMerchantSuccessResponse([
    void Function(DeleteMerchantSuccessResponseBuilder)? updates,
  ]) => (DeleteMerchantSuccessResponseBuilder()..update(updates))._build();

  _$DeleteMerchantSuccessResponse._({
    required this.success,
    required this.message,
    this.data,
  }) : super._();
  @override
  DeleteMerchantSuccessResponse rebuild(
    void Function(DeleteMerchantSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeleteMerchantSuccessResponseBuilder toBuilder() =>
      DeleteMerchantSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteMerchantSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeleteMerchantSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteMerchantSuccessResponseBuilder
    implements
        Builder<
          DeleteMerchantSuccessResponse,
          DeleteMerchantSuccessResponseBuilder
        > {
  _$DeleteMerchantSuccessResponse? _$v;

  DeleteMerchantSuccessResponseSuccessEnum? _success;
  DeleteMerchantSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteMerchantSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteMerchantSuccessResponseBuilder() {
    DeleteMerchantSuccessResponse._defaults(this);
  }

  DeleteMerchantSuccessResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteMerchantSuccessResponse other) {
    _$v = other as _$DeleteMerchantSuccessResponse;
  }

  @override
  void update(void Function(DeleteMerchantSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteMerchantSuccessResponse build() => _build();

  _$DeleteMerchantSuccessResponse _build() {
    final _$result =
        _$v ??
        _$DeleteMerchantSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'DeleteMerchantSuccessResponse',
            'success',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DeleteMerchantSuccessResponse',
            'message',
          ),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
