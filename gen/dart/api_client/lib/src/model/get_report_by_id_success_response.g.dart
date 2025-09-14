// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_report_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetReportByIdSuccessResponseSuccessEnum
_$getReportByIdSuccessResponseSuccessEnum_true_ =
    const GetReportByIdSuccessResponseSuccessEnum._('true_');

GetReportByIdSuccessResponseSuccessEnum
_$getReportByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getReportByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetReportByIdSuccessResponseSuccessEnum>
_$getReportByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetReportByIdSuccessResponseSuccessEnum>(
      const <GetReportByIdSuccessResponseSuccessEnum>[
        _$getReportByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetReportByIdSuccessResponseSuccessEnum>
_$getReportByIdSuccessResponseSuccessEnumSerializer =
    _$GetReportByIdSuccessResponseSuccessEnumSerializer();

class _$GetReportByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetReportByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetReportByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetReportByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetReportByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetReportByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetReportByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetReportByIdSuccessResponse extends GetReportByIdSuccessResponse {
  @override
  final GetReportByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Report data;

  factory _$GetReportByIdSuccessResponse([
    void Function(GetReportByIdSuccessResponseBuilder)? updates,
  ]) => (GetReportByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetReportByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetReportByIdSuccessResponse rebuild(
    void Function(GetReportByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetReportByIdSuccessResponseBuilder toBuilder() =>
      GetReportByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetReportByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetReportByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetReportByIdSuccessResponseBuilder
    implements
        Builder<
          GetReportByIdSuccessResponse,
          GetReportByIdSuccessResponseBuilder
        > {
  _$GetReportByIdSuccessResponse? _$v;

  GetReportByIdSuccessResponseSuccessEnum? _success;
  GetReportByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetReportByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReportBuilder? _data;
  ReportBuilder get data => _$this._data ??= ReportBuilder();
  set data(ReportBuilder? data) => _$this._data = data;

  GetReportByIdSuccessResponseBuilder() {
    GetReportByIdSuccessResponse._defaults(this);
  }

  GetReportByIdSuccessResponseBuilder get _$this {
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
  void replace(GetReportByIdSuccessResponse other) {
    _$v = other as _$GetReportByIdSuccessResponse;
  }

  @override
  void update(void Function(GetReportByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetReportByIdSuccessResponse build() => _build();

  _$GetReportByIdSuccessResponse _build() {
    _$GetReportByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetReportByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetReportByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetReportByIdSuccessResponse',
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
          r'GetReportByIdSuccessResponse',
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
