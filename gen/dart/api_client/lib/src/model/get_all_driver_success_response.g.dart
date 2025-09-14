// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_driver_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllDriverSuccessResponseSuccessEnum
_$getAllDriverSuccessResponseSuccessEnum_true_ =
    const GetAllDriverSuccessResponseSuccessEnum._('true_');

GetAllDriverSuccessResponseSuccessEnum
_$getAllDriverSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllDriverSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllDriverSuccessResponseSuccessEnum>
_$getAllDriverSuccessResponseSuccessEnumValues =
    BuiltSet<GetAllDriverSuccessResponseSuccessEnum>(
      const <GetAllDriverSuccessResponseSuccessEnum>[
        _$getAllDriverSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetAllDriverSuccessResponseSuccessEnum>
_$getAllDriverSuccessResponseSuccessEnumSerializer =
    _$GetAllDriverSuccessResponseSuccessEnumSerializer();

class _$GetAllDriverSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllDriverSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllDriverSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetAllDriverSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetAllDriverSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetAllDriverSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetAllDriverSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetAllDriverSuccessResponse extends GetAllDriverSuccessResponse {
  @override
  final GetAllDriverSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Driver> data;

  factory _$GetAllDriverSuccessResponse([
    void Function(GetAllDriverSuccessResponseBuilder)? updates,
  ]) => (GetAllDriverSuccessResponseBuilder()..update(updates))._build();

  _$GetAllDriverSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetAllDriverSuccessResponse rebuild(
    void Function(GetAllDriverSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetAllDriverSuccessResponseBuilder toBuilder() =>
      GetAllDriverSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllDriverSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllDriverSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllDriverSuccessResponseBuilder
    implements
        Builder<
          GetAllDriverSuccessResponse,
          GetAllDriverSuccessResponseBuilder
        > {
  _$GetAllDriverSuccessResponse? _$v;

  GetAllDriverSuccessResponseSuccessEnum? _success;
  GetAllDriverSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllDriverSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Driver>? _data;
  ListBuilder<Driver> get data => _$this._data ??= ListBuilder<Driver>();
  set data(ListBuilder<Driver>? data) => _$this._data = data;

  GetAllDriverSuccessResponseBuilder() {
    GetAllDriverSuccessResponse._defaults(this);
  }

  GetAllDriverSuccessResponseBuilder get _$this {
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
  void replace(GetAllDriverSuccessResponse other) {
    _$v = other as _$GetAllDriverSuccessResponse;
  }

  @override
  void update(void Function(GetAllDriverSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllDriverSuccessResponse build() => _build();

  _$GetAllDriverSuccessResponse _build() {
    _$GetAllDriverSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetAllDriverSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetAllDriverSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetAllDriverSuccessResponse',
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
          r'GetAllDriverSuccessResponse',
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
