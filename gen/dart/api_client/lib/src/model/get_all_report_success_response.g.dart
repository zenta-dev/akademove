// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_report_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetAllReportSuccessResponseSuccessEnum
_$getAllReportSuccessResponseSuccessEnum_true_ =
    const GetAllReportSuccessResponseSuccessEnum._('true_');

GetAllReportSuccessResponseSuccessEnum
_$getAllReportSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getAllReportSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetAllReportSuccessResponseSuccessEnum>
_$getAllReportSuccessResponseSuccessEnumValues =
    BuiltSet<GetAllReportSuccessResponseSuccessEnum>(
      const <GetAllReportSuccessResponseSuccessEnum>[
        _$getAllReportSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetAllReportSuccessResponseSuccessEnum>
_$getAllReportSuccessResponseSuccessEnumSerializer =
    _$GetAllReportSuccessResponseSuccessEnumSerializer();

class _$GetAllReportSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetAllReportSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetAllReportSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetAllReportSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetAllReportSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetAllReportSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetAllReportSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetAllReportSuccessResponse extends GetAllReportSuccessResponse {
  @override
  final GetAllReportSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<Report> data;

  factory _$GetAllReportSuccessResponse([
    void Function(GetAllReportSuccessResponseBuilder)? updates,
  ]) => (GetAllReportSuccessResponseBuilder()..update(updates))._build();

  _$GetAllReportSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetAllReportSuccessResponse rebuild(
    void Function(GetAllReportSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetAllReportSuccessResponseBuilder toBuilder() =>
      GetAllReportSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAllReportSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetAllReportSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetAllReportSuccessResponseBuilder
    implements
        Builder<
          GetAllReportSuccessResponse,
          GetAllReportSuccessResponseBuilder
        > {
  _$GetAllReportSuccessResponse? _$v;

  GetAllReportSuccessResponseSuccessEnum? _success;
  GetAllReportSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetAllReportSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<Report>? _data;
  ListBuilder<Report> get data => _$this._data ??= ListBuilder<Report>();
  set data(ListBuilder<Report>? data) => _$this._data = data;

  GetAllReportSuccessResponseBuilder() {
    GetAllReportSuccessResponse._defaults(this);
  }

  GetAllReportSuccessResponseBuilder get _$this {
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
  void replace(GetAllReportSuccessResponse other) {
    _$v = other as _$GetAllReportSuccessResponse;
  }

  @override
  void update(void Function(GetAllReportSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAllReportSuccessResponse build() => _build();

  _$GetAllReportSuccessResponse _build() {
    _$GetAllReportSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetAllReportSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetAllReportSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetAllReportSuccessResponse',
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
          r'GetAllReportSuccessResponse',
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
