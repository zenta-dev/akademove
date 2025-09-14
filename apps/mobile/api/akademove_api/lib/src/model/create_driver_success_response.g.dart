// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_driver_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateDriverSuccessResponseSuccessEnum
    _$createDriverSuccessResponseSuccessEnum_true_ =
    const CreateDriverSuccessResponseSuccessEnum._('true_');

CreateDriverSuccessResponseSuccessEnum
    _$createDriverSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createDriverSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateDriverSuccessResponseSuccessEnum>
    _$createDriverSuccessResponseSuccessEnumValues = BuiltSet<
        CreateDriverSuccessResponseSuccessEnum>(const <CreateDriverSuccessResponseSuccessEnum>[
  _$createDriverSuccessResponseSuccessEnum_true_,
]);

Serializer<CreateDriverSuccessResponseSuccessEnum>
    _$createDriverSuccessResponseSuccessEnumSerializer =
    _$CreateDriverSuccessResponseSuccessEnumSerializer();

class _$CreateDriverSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateDriverSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateDriverSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'CreateDriverSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          CreateDriverSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateDriverSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateDriverSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateDriverSuccessResponse extends CreateDriverSuccessResponse {
  @override
  final CreateDriverSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Driver data;

  factory _$CreateDriverSuccessResponse(
          [void Function(CreateDriverSuccessResponseBuilder)? updates]) =>
      (CreateDriverSuccessResponseBuilder()..update(updates))._build();

  _$CreateDriverSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  CreateDriverSuccessResponse rebuild(
          void Function(CreateDriverSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateDriverSuccessResponseBuilder toBuilder() =>
      CreateDriverSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateDriverSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateDriverSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateDriverSuccessResponseBuilder
    implements
        Builder<CreateDriverSuccessResponse,
            CreateDriverSuccessResponseBuilder> {
  _$CreateDriverSuccessResponse? _$v;

  CreateDriverSuccessResponseSuccessEnum? _success;
  CreateDriverSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateDriverSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DriverBuilder? _data;
  DriverBuilder get data => _$this._data ??= DriverBuilder();
  set data(DriverBuilder? data) => _$this._data = data;

  CreateDriverSuccessResponseBuilder() {
    CreateDriverSuccessResponse._defaults(this);
  }

  CreateDriverSuccessResponseBuilder get _$this {
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
  void replace(CreateDriverSuccessResponse other) {
    _$v = other as _$CreateDriverSuccessResponse;
  }

  @override
  void update(void Function(CreateDriverSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateDriverSuccessResponse build() => _build();

  _$CreateDriverSuccessResponse _build() {
    _$CreateDriverSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$CreateDriverSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'CreateDriverSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'CreateDriverSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateDriverSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
