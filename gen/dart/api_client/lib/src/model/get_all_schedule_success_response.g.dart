// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_schedule_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllScheduleSuccessResponseSuccessEnum
_$getAllScheduleSuccessResponseSuccessEnum_true_ =
    const GetAllScheduleSuccessResponseSuccessEnum._('true_');

GetAllScheduleSuccessResponseSuccessEnum
_$getAllScheduleSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllScheduleSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllScheduleSuccessResponseSuccessEnum>
_$getAllScheduleSuccessResponseSuccessEnumValues =
    BuiltSet<GetAllScheduleSuccessResponseSuccessEnum>(
      const <GetAllScheduleSuccessResponseSuccessEnum>[
        _$getAllScheduleSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetAllScheduleSuccessResponseSuccessEnum>
_$getAllScheduleSuccessResponseSuccessEnumSerializer =
    _$GetAllScheduleSuccessResponseSuccessEnumSerializer();

class _$GetAllScheduleSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllScheduleSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllScheduleSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetAllScheduleSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetAllScheduleSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetAllScheduleSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetAllScheduleSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetAllScheduleSuccessResponse extends GetAllScheduleSuccessResponse {
  @override
  final GetAllScheduleSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Schedule> data;

  factory _$GetAllScheduleSuccessResponse([
    void Function(GetAllScheduleSuccessResponseBuilder)? updates,
  ]) => (GetAllScheduleSuccessResponseBuilder()..update(updates))._build();

  _$GetAllScheduleSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetAllScheduleSuccessResponse rebuild(
    void Function(GetAllScheduleSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetAllScheduleSuccessResponseBuilder toBuilder() =>
      GetAllScheduleSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllScheduleSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllScheduleSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllScheduleSuccessResponseBuilder
    implements
        Builder<
          GetAllScheduleSuccessResponse,
          GetAllScheduleSuccessResponseBuilder
        > {
  _$GetAllScheduleSuccessResponse? _$v;

  GetAllScheduleSuccessResponseSuccessEnum? _success;
  GetAllScheduleSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllScheduleSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Schedule>? _data;
  ListBuilder<Schedule> get data => _$this._data ??= ListBuilder<Schedule>();
  set data(ListBuilder<Schedule>? data) => _$this._data = data;

  GetAllScheduleSuccessResponseBuilder() {
    GetAllScheduleSuccessResponse._defaults(this);
  }

  GetAllScheduleSuccessResponseBuilder get _$this {
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
  void replace(GetAllScheduleSuccessResponse other) {
    _$v = other as _$GetAllScheduleSuccessResponse;
  }

  @override
  void update(void Function(GetAllScheduleSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllScheduleSuccessResponse build() => _build();

  _$GetAllScheduleSuccessResponse _build() {
    _$GetAllScheduleSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetAllScheduleSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetAllScheduleSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetAllScheduleSuccessResponse',
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
          r'GetAllScheduleSuccessResponse',
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
