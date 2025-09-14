// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_report_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateReportSuccessResponseSuccessEnum
    _$createReportSuccessResponseSuccessEnum_true_ =
    const CreateReportSuccessResponseSuccessEnum._('true_');

CreateReportSuccessResponseSuccessEnum
    _$createReportSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createReportSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReportSuccessResponseSuccessEnum>
    _$createReportSuccessResponseSuccessEnumValues = BuiltSet<
        CreateReportSuccessResponseSuccessEnum>(const <CreateReportSuccessResponseSuccessEnum>[
  _$createReportSuccessResponseSuccessEnum_true_,
]);

Serializer<CreateReportSuccessResponseSuccessEnum>
    _$createReportSuccessResponseSuccessEnumSerializer =
    _$CreateReportSuccessResponseSuccessEnumSerializer();

class _$CreateReportSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateReportSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateReportSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'CreateReportSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          CreateReportSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateReportSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateReportSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateReportSuccessResponse extends CreateReportSuccessResponse {
  @override
  final CreateReportSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Report data;

  factory _$CreateReportSuccessResponse(
          [void Function(CreateReportSuccessResponseBuilder)? updates]) =>
      (CreateReportSuccessResponseBuilder()..update(updates))._build();

  _$CreateReportSuccessResponse._(
      {required this.success, required this.message, required this.data})
      : super._();
  @override
  CreateReportSuccessResponse rebuild(
          void Function(CreateReportSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateReportSuccessResponseBuilder toBuilder() =>
      CreateReportSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReportSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateReportSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateReportSuccessResponseBuilder
    implements
        Builder<CreateReportSuccessResponse,
            CreateReportSuccessResponseBuilder> {
  _$CreateReportSuccessResponse? _$v;

  CreateReportSuccessResponseSuccessEnum? _success;
  CreateReportSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateReportSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReportBuilder? _data;
  ReportBuilder get data => _$this._data ??= ReportBuilder();
  set data(ReportBuilder? data) => _$this._data = data;

  CreateReportSuccessResponseBuilder() {
    CreateReportSuccessResponse._defaults(this);
  }

  CreateReportSuccessResponseBuilder get _$this {
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
  void replace(CreateReportSuccessResponse other) {
    _$v = other as _$CreateReportSuccessResponse;
  }

  @override
  void update(void Function(CreateReportSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReportSuccessResponse build() => _build();

  _$CreateReportSuccessResponse _build() {
    _$CreateReportSuccessResponse _$result;
    try {
      _$result = _$v ??
          _$CreateReportSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
                success, r'CreateReportSuccessResponse', 'success'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'CreateReportSuccessResponse', 'message'),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateReportSuccessResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
