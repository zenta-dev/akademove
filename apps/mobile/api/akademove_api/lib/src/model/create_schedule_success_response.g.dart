// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_schedule_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateScheduleSuccessResponseSuccessEnum
    _$createScheduleSuccessResponseSuccessEnum_true_ =
    const CreateScheduleSuccessResponseSuccessEnum._('true_');

CreateScheduleSuccessResponseSuccessEnum
    _$createScheduleSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createScheduleSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateScheduleSuccessResponseSuccessEnum>
    _$createScheduleSuccessResponseSuccessEnumValues = BuiltSet<
        CreateScheduleSuccessResponseSuccessEnum>(const <CreateScheduleSuccessResponseSuccessEnum>[
  _$createScheduleSuccessResponseSuccessEnum_true_,
]);

Serializer<CreateScheduleSuccessResponseSuccessEnum>
    _$createScheduleSuccessResponseSuccessEnumSerializer =
    _$CreateScheduleSuccessResponseSuccessEnumSerializer();

class _$CreateScheduleSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateScheduleSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateScheduleSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'CreateScheduleSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          CreateScheduleSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateScheduleSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateScheduleSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateScheduleSuccessResponse extends CreateScheduleSuccessResponse {
  @override
  final CreateScheduleSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Schedule data;

  factory _$CreateScheduleSuccessResponse(
          [void Function(CreateScheduleSuccessResponseBuilder)? updates]) =>
      (CreateScheduleSuccessResponseBuilder()..update(updates))._build();

  _$CreateScheduleSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  CreateScheduleSuccessResponse rebuild(
          void Function(CreateScheduleSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateScheduleSuccessResponseBuilder toBuilder() =>
      CreateScheduleSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateScheduleSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateScheduleSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateScheduleSuccessResponseBuilder
    implements
        Builder<CreateScheduleSuccessResponse,
            CreateScheduleSuccessResponseBuilder> {
  _$CreateScheduleSuccessResponse? _$v;

  CreateScheduleSuccessResponseSuccessEnum? _success;
  CreateScheduleSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateScheduleSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ScheduleBuilder? _data;
  ScheduleBuilder get data => _$this._data ??= ScheduleBuilder();
  set data(ScheduleBuilder? data) => _$this._data = data;

  CreateScheduleSuccessResponseBuilder() {
    CreateScheduleSuccessResponse._defaults(this);
  }

  CreateScheduleSuccessResponseBuilder get _$this {
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
  void replace(CreateScheduleSuccessResponse other) {
    _$v = other as _$CreateScheduleSuccessResponse;
  }

  @override
  void update(void Function(CreateScheduleSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateScheduleSuccessResponse build() => _build();

  _$CreateScheduleSuccessResponse _build() {
    _$CreateScheduleSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$CreateScheduleSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'CreateScheduleSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'CreateScheduleSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateScheduleSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
