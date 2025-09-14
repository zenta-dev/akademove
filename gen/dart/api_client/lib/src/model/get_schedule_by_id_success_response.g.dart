// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_schedule_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetScheduleByIdSuccessResponseSuccessEnum
_$getScheduleByIdSuccessResponseSuccessEnum_true_ =
    const GetScheduleByIdSuccessResponseSuccessEnum._('true_');

GetScheduleByIdSuccessResponseSuccessEnum
_$getScheduleByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getScheduleByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetScheduleByIdSuccessResponseSuccessEnum>
_$getScheduleByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetScheduleByIdSuccessResponseSuccessEnum>(
      const <GetScheduleByIdSuccessResponseSuccessEnum>[
        _$getScheduleByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetScheduleByIdSuccessResponseSuccessEnum>
_$getScheduleByIdSuccessResponseSuccessEnumSerializer =
    _$GetScheduleByIdSuccessResponseSuccessEnumSerializer();

class _$GetScheduleByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetScheduleByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetScheduleByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetScheduleByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetScheduleByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetScheduleByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetScheduleByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetScheduleByIdSuccessResponse extends GetScheduleByIdSuccessResponse {
  @override
  final GetScheduleByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Schedule data;

  factory _$GetScheduleByIdSuccessResponse([
    void Function(GetScheduleByIdSuccessResponseBuilder)? updates,
  ]) => (GetScheduleByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetScheduleByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetScheduleByIdSuccessResponse rebuild(
    void Function(GetScheduleByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetScheduleByIdSuccessResponseBuilder toBuilder() =>
      GetScheduleByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetScheduleByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetScheduleByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetScheduleByIdSuccessResponseBuilder
    implements
        Builder<
          GetScheduleByIdSuccessResponse,
          GetScheduleByIdSuccessResponseBuilder
        > {
  _$GetScheduleByIdSuccessResponse? _$v;

  GetScheduleByIdSuccessResponseSuccessEnum? _success;
  GetScheduleByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetScheduleByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ScheduleBuilder? _data;
  ScheduleBuilder get data => _$this._data ??= ScheduleBuilder();
  set data(ScheduleBuilder? data) => _$this._data = data;

  GetScheduleByIdSuccessResponseBuilder() {
    GetScheduleByIdSuccessResponse._defaults(this);
  }

  GetScheduleByIdSuccessResponseBuilder get _$this {
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
  void replace(GetScheduleByIdSuccessResponse other) {
    _$v = other as _$GetScheduleByIdSuccessResponse;
  }

  @override
  void update(void Function(GetScheduleByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetScheduleByIdSuccessResponse build() => _build();

  _$GetScheduleByIdSuccessResponse _build() {
    _$GetScheduleByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetScheduleByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetScheduleByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetScheduleByIdSuccessResponse',
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
          r'GetScheduleByIdSuccessResponse',
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
