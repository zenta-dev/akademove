// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failed_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FailedResponseSuccessEnum _$failedResponseSuccessEnum_false_ =
    const FailedResponseSuccessEnum._('false_');

FailedResponseSuccessEnum _$failedResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'false_':
      return _$failedResponseSuccessEnum_false_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FailedResponseSuccessEnum> _$failedResponseSuccessEnumValues =
    BuiltSet<FailedResponseSuccessEnum>(const <FailedResponseSuccessEnum>[
      _$failedResponseSuccessEnum_false_,
    ]);

Serializer<FailedResponseSuccessEnum> _$failedResponseSuccessEnumSerializer =
    _$FailedResponseSuccessEnumSerializer();

class _$FailedResponseSuccessEnumSerializer
    implements PrimitiveSerializer<FailedResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'false_': 'false',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'false': 'false_',
  };

  @override
  final Iterable<Type> types = const <Type>[FailedResponseSuccessEnum];
  @override
  final String wireName = 'FailedResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    FailedResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FailedResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FailedResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FailedResponse extends FailedResponse {
  @override
  final FailedResponseSuccessEnum success;
  @override
  final String message;
  @override
  final BuiltList<String> errors;

  factory _$FailedResponse([void Function(FailedResponseBuilder)? updates]) =>
      (FailedResponseBuilder()..update(updates))._build();

  _$FailedResponse._({
    required this.success,
    required this.message,
    required this.errors,
  }) : super._();
  @override
  FailedResponse rebuild(void Function(FailedResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FailedResponseBuilder toBuilder() => FailedResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FailedResponse &&
        success == other.success &&
        message == other.message &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, success.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FailedResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('errors', errors))
        .toString();
  }
}

class FailedResponseBuilder
    implements Builder<FailedResponse, FailedResponseBuilder> {
  _$FailedResponse? _$v;

  FailedResponseSuccessEnum? _success;
  FailedResponseSuccessEnum? get success => _$this._success;
  set success(FailedResponseSuccessEnum? success) => _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ListBuilder<String>? _errors;
  ListBuilder<String> get errors => _$this._errors ??= ListBuilder<String>();
  set errors(ListBuilder<String>? errors) => _$this._errors = errors;

  FailedResponseBuilder() {
    FailedResponse._defaults(this);
  }

  FailedResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _success = $v.success;
      _message = $v.message;
      _errors = $v.errors.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FailedResponse other) {
    _$v = other as _$FailedResponse;
  }

  @override
  void update(void Function(FailedResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FailedResponse build() => _build();

  _$FailedResponse _build() {
    _$FailedResponse _$result;
    try {
      _$result =
          _$v ??
          _$FailedResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'FailedResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'FailedResponse',
              'message',
            ),
            errors: errors.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'errors';
        errors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FailedResponse',
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
