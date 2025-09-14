// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_schedule_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateScheduleSuccessResponseSuccessEnum
_$updateScheduleSuccessResponseSuccessEnum_true_ =
    const UpdateScheduleSuccessResponseSuccessEnum._('true_');

UpdateScheduleSuccessResponseSuccessEnum
_$updateScheduleSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateScheduleSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateScheduleSuccessResponseSuccessEnum>
_$updateScheduleSuccessResponseSuccessEnumValues =
    BuiltSet<UpdateScheduleSuccessResponseSuccessEnum>(
      const <UpdateScheduleSuccessResponseSuccessEnum>[
        _$updateScheduleSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<UpdateScheduleSuccessResponseSuccessEnum>
_$updateScheduleSuccessResponseSuccessEnumSerializer =
    _$UpdateScheduleSuccessResponseSuccessEnumSerializer();

class _$UpdateScheduleSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateScheduleSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateScheduleSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'UpdateScheduleSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateScheduleSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateScheduleSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateScheduleSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateScheduleSuccessResponse extends UpdateScheduleSuccessResponse {
  @override
  final UpdateScheduleSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Schedule data;

  factory _$UpdateScheduleSuccessResponse([
    void Function(UpdateScheduleSuccessResponseBuilder)? updates,
  ]) => (UpdateScheduleSuccessResponseBuilder()..update(updates))._build();

  _$UpdateScheduleSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  UpdateScheduleSuccessResponse rebuild(
    void Function(UpdateScheduleSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateScheduleSuccessResponseBuilder toBuilder() =>
      UpdateScheduleSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateScheduleSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateScheduleSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateScheduleSuccessResponseBuilder
    implements
        Builder<
          UpdateScheduleSuccessResponse,
          UpdateScheduleSuccessResponseBuilder
        > {
  _$UpdateScheduleSuccessResponse? _$v;

  UpdateScheduleSuccessResponseSuccessEnum? _success;
  UpdateScheduleSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateScheduleSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ScheduleBuilder? _data;
  ScheduleBuilder get data => _$this._data ??= ScheduleBuilder();
  set data(ScheduleBuilder? data) => _$this._data = data;

  UpdateScheduleSuccessResponseBuilder() {
    UpdateScheduleSuccessResponse._defaults(this);
  }

  UpdateScheduleSuccessResponseBuilder get _$this {
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
  void replace(UpdateScheduleSuccessResponse other) {
    _$v = other as _$UpdateScheduleSuccessResponse;
  }

  @override
  void update(void Function(UpdateScheduleSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateScheduleSuccessResponse build() => _build();

  _$UpdateScheduleSuccessResponse _build() {
    _$UpdateScheduleSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateScheduleSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'UpdateScheduleSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UpdateScheduleSuccessResponse',
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
          r'UpdateScheduleSuccessResponse',
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
