// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_promo_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeletePromoSuccessResponseSuccessEnum
_$deletePromoSuccessResponseSuccessEnum_true_ =
    const DeletePromoSuccessResponseSuccessEnum._('true_');

DeletePromoSuccessResponseSuccessEnum
_$deletePromoSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deletePromoSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeletePromoSuccessResponseSuccessEnum>
_$deletePromoSuccessResponseSuccessEnumValues =
    BuiltSet<DeletePromoSuccessResponseSuccessEnum>(
      const <DeletePromoSuccessResponseSuccessEnum>[
        _$deletePromoSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<DeletePromoSuccessResponseSuccessEnum>
_$deletePromoSuccessResponseSuccessEnumSerializer =
    _$DeletePromoSuccessResponseSuccessEnumSerializer();

class _$DeletePromoSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeletePromoSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeletePromoSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'DeletePromoSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeletePromoSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeletePromoSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeletePromoSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeletePromoSuccessResponse extends DeletePromoSuccessResponse {
  @override
  final DeletePromoSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeletePromoSuccessResponse([
    void Function(DeletePromoSuccessResponseBuilder)? updates,
  ]) => (DeletePromoSuccessResponseBuilder()..update(updates))._build();

  _$DeletePromoSuccessResponse._({
    required this.success,
    required this.message,
    this.data,
  }) : super._();
  @override
  DeletePromoSuccessResponse rebuild(
    void Function(DeletePromoSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeletePromoSuccessResponseBuilder toBuilder() =>
      DeletePromoSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeletePromoSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeletePromoSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeletePromoSuccessResponseBuilder
    implements
        Builder<DeletePromoSuccessResponse, DeletePromoSuccessResponseBuilder> {
  _$DeletePromoSuccessResponse? _$v;

  DeletePromoSuccessResponseSuccessEnum? _success;
  DeletePromoSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeletePromoSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeletePromoSuccessResponseBuilder() {
    DeletePromoSuccessResponse._defaults(this);
  }

  DeletePromoSuccessResponseBuilder get _$this {
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
  void replace(DeletePromoSuccessResponse other) {
    _$v = other as _$DeletePromoSuccessResponse;
  }

  @override
  void update(void Function(DeletePromoSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeletePromoSuccessResponse build() => _build();

  _$DeletePromoSuccessResponse _build() {
    final _$result =
        _$v ??
        _$DeletePromoSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'DeletePromoSuccessResponse',
            'success',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DeletePromoSuccessResponse',
            'message',
          ),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
