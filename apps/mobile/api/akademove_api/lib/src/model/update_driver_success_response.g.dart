// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_driver_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateDriverSuccessResponseSuccessEnum
    _$updateDriverSuccessResponseSuccessEnum_true_ =
    const UpdateDriverSuccessResponseSuccessEnum._('true_');

UpdateDriverSuccessResponseSuccessEnum
    _$updateDriverSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateDriverSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateDriverSuccessResponseSuccessEnum>
    _$updateDriverSuccessResponseSuccessEnumValues = BuiltSet<
        UpdateDriverSuccessResponseSuccessEnum>(const <UpdateDriverSuccessResponseSuccessEnum>[
  _$updateDriverSuccessResponseSuccessEnum_true_,
]);

Serializer<UpdateDriverSuccessResponseSuccessEnum>
    _$updateDriverSuccessResponseSuccessEnumSerializer =
    _$UpdateDriverSuccessResponseSuccessEnumSerializer();

class _$UpdateDriverSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateDriverSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateDriverSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'UpdateDriverSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          UpdateDriverSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateDriverSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateDriverSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateDriverSuccessResponse extends UpdateDriverSuccessResponse {
  @override
  final UpdateDriverSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Driver data;

  factory _$UpdateDriverSuccessResponse(
          [void Function(UpdateDriverSuccessResponseBuilder)? updates]) =>
      (UpdateDriverSuccessResponseBuilder()..update(updates))._build();

  _$UpdateDriverSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  UpdateDriverSuccessResponse rebuild(
          void Function(UpdateDriverSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateDriverSuccessResponseBuilder toBuilder() =>
      UpdateDriverSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateDriverSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateDriverSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateDriverSuccessResponseBuilder
    implements
        Builder<UpdateDriverSuccessResponse,
            UpdateDriverSuccessResponseBuilder> {
  _$UpdateDriverSuccessResponse? _$v;

  UpdateDriverSuccessResponseSuccessEnum? _success;
  UpdateDriverSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateDriverSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DriverBuilder? _data;
  DriverBuilder get data => _$this._data ??= DriverBuilder();
  set data(DriverBuilder? data) => _$this._data = data;

  UpdateDriverSuccessResponseBuilder() {
    UpdateDriverSuccessResponse._defaults(this);
  }

  UpdateDriverSuccessResponseBuilder get _$this {
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
  void replace(UpdateDriverSuccessResponse other) {
    _$v = other as _$UpdateDriverSuccessResponse;
  }

  @override
  void update(void Function(UpdateDriverSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateDriverSuccessResponse build() => _build();

  _$UpdateDriverSuccessResponse _build() {
    _$UpdateDriverSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$UpdateDriverSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'UpdateDriverSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'UpdateDriverSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateDriverSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
