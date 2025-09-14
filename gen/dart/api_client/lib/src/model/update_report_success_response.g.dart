// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_report_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateReportSuccessResponseSuccessEnum
_$updateReportSuccessResponseSuccessEnum_true_ =
    const UpdateReportSuccessResponseSuccessEnum._('true_');

UpdateReportSuccessResponseSuccessEnum
_$updateReportSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateReportSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateReportSuccessResponseSuccessEnum>
_$updateReportSuccessResponseSuccessEnumValues =
    BuiltSet<UpdateReportSuccessResponseSuccessEnum>(
      const <UpdateReportSuccessResponseSuccessEnum>[
        _$updateReportSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<UpdateReportSuccessResponseSuccessEnum>
_$updateReportSuccessResponseSuccessEnumSerializer =
    _$UpdateReportSuccessResponseSuccessEnumSerializer();

class _$UpdateReportSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateReportSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateReportSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'UpdateReportSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateReportSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateReportSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateReportSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateReportSuccessResponse extends UpdateReportSuccessResponse {
  @override
  final UpdateReportSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Report data;

  factory _$UpdateReportSuccessResponse([
    void Function(UpdateReportSuccessResponseBuilder)? updates,
  ]) => (UpdateReportSuccessResponseBuilder()..update(updates))._build();

  _$UpdateReportSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  UpdateReportSuccessResponse rebuild(
    void Function(UpdateReportSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateReportSuccessResponseBuilder toBuilder() =>
      UpdateReportSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateReportSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateReportSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateReportSuccessResponseBuilder
    implements
        Builder<
          UpdateReportSuccessResponse,
          UpdateReportSuccessResponseBuilder
        > {
  _$UpdateReportSuccessResponse? _$v;

  UpdateReportSuccessResponseSuccessEnum? _success;
  UpdateReportSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateReportSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReportBuilder? _data;
  ReportBuilder get data => _$this._data ??= ReportBuilder();
  set data(ReportBuilder? data) => _$this._data = data;

  UpdateReportSuccessResponseBuilder() {
    UpdateReportSuccessResponse._defaults(this);
  }

  UpdateReportSuccessResponseBuilder get _$this {
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
  void replace(UpdateReportSuccessResponse other) {
    _$v = other as _$UpdateReportSuccessResponse;
  }

  @override
  void update(void Function(UpdateReportSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateReportSuccessResponse build() => _build();

  _$UpdateReportSuccessResponse _build() {
    _$UpdateReportSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateReportSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'UpdateReportSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UpdateReportSuccessResponse',
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
          r'UpdateReportSuccessResponse',
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
