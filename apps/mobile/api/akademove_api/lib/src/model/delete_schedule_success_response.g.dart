// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_schedule_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteScheduleSuccessResponseSuccessEnum
    _$deleteScheduleSuccessResponseSuccessEnum_true_ =
    const DeleteScheduleSuccessResponseSuccessEnum._('true_');

DeleteScheduleSuccessResponseSuccessEnum
    _$deleteScheduleSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteScheduleSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteScheduleSuccessResponseSuccessEnum>
    _$deleteScheduleSuccessResponseSuccessEnumValues = BuiltSet<
        DeleteScheduleSuccessResponseSuccessEnum>(const <DeleteScheduleSuccessResponseSuccessEnum>[
  _$deleteScheduleSuccessResponseSuccessEnum_true_,
]);

Serializer<DeleteScheduleSuccessResponseSuccessEnum>
    _$deleteScheduleSuccessResponseSuccessEnumSerializer =
    _$DeleteScheduleSuccessResponseSuccessEnumSerializer();

class _$DeleteScheduleSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteScheduleSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteScheduleSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'DeleteScheduleSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          DeleteScheduleSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeleteScheduleSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeleteScheduleSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeleteScheduleSuccessResponse extends DeleteScheduleSuccessResponse {
  @override
  final DeleteScheduleSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteScheduleSuccessResponse(
          [void Function(DeleteScheduleSuccessResponseBuilder)? updates]) =>
      (DeleteScheduleSuccessResponseBuilder()..update(updates))._build();

  _$DeleteScheduleSuccessResponse._(
      {required this.success, required this.message, this.data})
      : super._();
  @override
  DeleteScheduleSuccessResponse rebuild(
          void Function(DeleteScheduleSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteScheduleSuccessResponseBuilder toBuilder() =>
      DeleteScheduleSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteScheduleSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeleteScheduleSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteScheduleSuccessResponseBuilder
    implements
        Builder<DeleteScheduleSuccessResponse,
            DeleteScheduleSuccessResponseBuilder> {
  _$DeleteScheduleSuccessResponse? _$v;

  DeleteScheduleSuccessResponseSuccessEnum? _success;
  DeleteScheduleSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteScheduleSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteScheduleSuccessResponseBuilder() {
    DeleteScheduleSuccessResponse._defaults(this);
  }

  DeleteScheduleSuccessResponseBuilder get _$this {
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
  void replace(DeleteScheduleSuccessResponse other) {
    _$v = other as _$DeleteScheduleSuccessResponse;
  }

  @override
  void update(void Function(DeleteScheduleSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteScheduleSuccessResponse build() => _build();

  _$DeleteScheduleSuccessResponse _build() {
    final _$result = _$v ??
        _$DeleteScheduleSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'DeleteScheduleSuccessResponse', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'DeleteScheduleSuccessResponse', 'message'),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
