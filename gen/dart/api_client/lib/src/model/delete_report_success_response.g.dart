// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_report_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteReportSuccessResponseSuccessEnum
_$deleteReportSuccessResponseSuccessEnum_true_ =
    const DeleteReportSuccessResponseSuccessEnum._('true_');

DeleteReportSuccessResponseSuccessEnum
_$deleteReportSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteReportSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteReportSuccessResponseSuccessEnum>
_$deleteReportSuccessResponseSuccessEnumValues =
    BuiltSet<DeleteReportSuccessResponseSuccessEnum>(
      const <DeleteReportSuccessResponseSuccessEnum>[
        _$deleteReportSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<DeleteReportSuccessResponseSuccessEnum>
_$deleteReportSuccessResponseSuccessEnumSerializer =
    _$DeleteReportSuccessResponseSuccessEnumSerializer();

class _$DeleteReportSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteReportSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteReportSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'DeleteReportSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    DeleteReportSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  DeleteReportSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => DeleteReportSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$DeleteReportSuccessResponse extends DeleteReportSuccessResponse {
  @override
  final DeleteReportSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteReportSuccessResponse([
    void Function(DeleteReportSuccessResponseBuilder)? updates,
  ]) => (DeleteReportSuccessResponseBuilder()..update(updates))._build();

  _$DeleteReportSuccessResponse._({
    required this.success,
    required this.message,
    this.data,
  }) : super._();
  @override
  DeleteReportSuccessResponse rebuild(
    void Function(DeleteReportSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  DeleteReportSuccessResponseBuilder toBuilder() =>
      DeleteReportSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteReportSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeleteReportSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteReportSuccessResponseBuilder
    implements
        Builder<
          DeleteReportSuccessResponse,
          DeleteReportSuccessResponseBuilder
        > {
  _$DeleteReportSuccessResponse? _$v;

  DeleteReportSuccessResponseSuccessEnum? _success;
  DeleteReportSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteReportSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteReportSuccessResponseBuilder() {
    DeleteReportSuccessResponse._defaults(this);
  }

  DeleteReportSuccessResponseBuilder get _$this {
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
  void replace(DeleteReportSuccessResponse other) {
    _$v = other as _$DeleteReportSuccessResponse;
  }

  @override
  void update(void Function(DeleteReportSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteReportSuccessResponse build() => _build();

  _$DeleteReportSuccessResponse _build() {
    final _$result =
        _$v ??
        _$DeleteReportSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
            success,
            r'DeleteReportSuccessResponse',
            'success',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'DeleteReportSuccessResponse',
            'message',
          ),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
