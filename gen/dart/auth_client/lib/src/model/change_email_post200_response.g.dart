// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChangeEmailPost200ResponseMessageEnum
_$changeEmailPost200ResponseMessageEnum_emailUpdated =
    const ChangeEmailPost200ResponseMessageEnum._('emailUpdated');
const ChangeEmailPost200ResponseMessageEnum
_$changeEmailPost200ResponseMessageEnum_verificationEmailSent =
    const ChangeEmailPost200ResponseMessageEnum._('verificationEmailSent');

ChangeEmailPost200ResponseMessageEnum
_$changeEmailPost200ResponseMessageEnumValueOf(String name) {
  switch (name) {
    case 'emailUpdated':
      return _$changeEmailPost200ResponseMessageEnum_emailUpdated;
    case 'verificationEmailSent':
      return _$changeEmailPost200ResponseMessageEnum_verificationEmailSent;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ChangeEmailPost200ResponseMessageEnum>
_$changeEmailPost200ResponseMessageEnumValues =
    BuiltSet<ChangeEmailPost200ResponseMessageEnum>(
      const <ChangeEmailPost200ResponseMessageEnum>[
        _$changeEmailPost200ResponseMessageEnum_emailUpdated,
        _$changeEmailPost200ResponseMessageEnum_verificationEmailSent,
      ],
    );

Serializer<ChangeEmailPost200ResponseMessageEnum>
_$changeEmailPost200ResponseMessageEnumSerializer =
    _$ChangeEmailPost200ResponseMessageEnumSerializer();

class _$ChangeEmailPost200ResponseMessageEnumSerializer
    implements PrimitiveSerializer<ChangeEmailPost200ResponseMessageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'emailUpdated': 'Email updated',
    'verificationEmailSent': 'Verification email sent',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Email updated': 'emailUpdated',
    'Verification email sent': 'verificationEmailSent',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ChangeEmailPost200ResponseMessageEnum,
  ];
  @override
  final String wireName = 'ChangeEmailPost200ResponseMessageEnum';

  @override
  Object serialize(
    Serializers serializers,
    ChangeEmailPost200ResponseMessageEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ChangeEmailPost200ResponseMessageEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ChangeEmailPost200ResponseMessageEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ChangeEmailPost200Response extends ChangeEmailPost200Response {
  @override
  final bool status;
  @override
  final ChangeEmailPost200ResponseMessageEnum? message;

  factory _$ChangeEmailPost200Response([
    void Function(ChangeEmailPost200ResponseBuilder)? updates,
  ]) => (ChangeEmailPost200ResponseBuilder()..update(updates))._build();

  _$ChangeEmailPost200Response._({required this.status, this.message})
    : super._();
  @override
  ChangeEmailPost200Response rebuild(
    void Function(ChangeEmailPost200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ChangeEmailPost200ResponseBuilder toBuilder() =>
      ChangeEmailPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeEmailPost200Response &&
        status == other.status &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChangeEmailPost200Response')
          ..add('status', status)
          ..add('message', message))
        .toString();
  }
}

class ChangeEmailPost200ResponseBuilder
    implements
        Builder<ChangeEmailPost200Response, ChangeEmailPost200ResponseBuilder> {
  _$ChangeEmailPost200Response? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  ChangeEmailPost200ResponseMessageEnum? _message;
  ChangeEmailPost200ResponseMessageEnum? get message => _$this._message;
  set message(ChangeEmailPost200ResponseMessageEnum? message) =>
      _$this._message = message;

  ChangeEmailPost200ResponseBuilder() {
    ChangeEmailPost200Response._defaults(this);
  }

  ChangeEmailPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeEmailPost200Response other) {
    _$v = other as _$ChangeEmailPost200Response;
  }

  @override
  void update(void Function(ChangeEmailPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeEmailPost200Response build() => _build();

  _$ChangeEmailPost200Response _build() {
    final _$result =
        _$v ??
        _$ChangeEmailPost200Response._(
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'ChangeEmailPost200Response',
            'status',
          ),
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
