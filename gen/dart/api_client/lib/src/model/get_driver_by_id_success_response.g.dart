// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_driver_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetDriverByIdSuccessResponseSuccessEnum
_$getDriverByIdSuccessResponseSuccessEnum_true_ =
    const GetDriverByIdSuccessResponseSuccessEnum._('true_');

GetDriverByIdSuccessResponseSuccessEnum
_$getDriverByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getDriverByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetDriverByIdSuccessResponseSuccessEnum>
_$getDriverByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetDriverByIdSuccessResponseSuccessEnum>(
      const <GetDriverByIdSuccessResponseSuccessEnum>[
        _$getDriverByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetDriverByIdSuccessResponseSuccessEnum>
_$getDriverByIdSuccessResponseSuccessEnumSerializer =
    _$GetDriverByIdSuccessResponseSuccessEnumSerializer();

class _$GetDriverByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetDriverByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetDriverByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetDriverByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetDriverByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetDriverByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetDriverByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetDriverByIdSuccessResponse extends GetDriverByIdSuccessResponse {
  @override
  final GetDriverByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Driver data;

  factory _$GetDriverByIdSuccessResponse([
    void Function(GetDriverByIdSuccessResponseBuilder)? updates,
  ]) => (GetDriverByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetDriverByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetDriverByIdSuccessResponse rebuild(
    void Function(GetDriverByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetDriverByIdSuccessResponseBuilder toBuilder() =>
      GetDriverByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetDriverByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetDriverByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetDriverByIdSuccessResponseBuilder
    implements
        Builder<
          GetDriverByIdSuccessResponse,
          GetDriverByIdSuccessResponseBuilder
        > {
  _$GetDriverByIdSuccessResponse? _$v;

  GetDriverByIdSuccessResponseSuccessEnum? _success;
  GetDriverByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetDriverByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DriverBuilder? _data;
  DriverBuilder get data => _$this._data ??= DriverBuilder();
  set data(DriverBuilder? data) => _$this._data = data;

  GetDriverByIdSuccessResponseBuilder() {
    GetDriverByIdSuccessResponse._defaults(this);
  }

  GetDriverByIdSuccessResponseBuilder get _$this {
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
  void replace(GetDriverByIdSuccessResponse other) {
    _$v = other as _$GetDriverByIdSuccessResponse;
  }

  @override
  void update(void Function(GetDriverByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetDriverByIdSuccessResponse build() => _build();

  _$GetDriverByIdSuccessResponse _build() {
    _$GetDriverByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetDriverByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetDriverByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetDriverByIdSuccessResponse',
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
          r'GetDriverByIdSuccessResponse',
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
