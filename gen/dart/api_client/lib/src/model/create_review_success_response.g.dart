// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateReviewSuccessResponseSuccessEnum
_$createReviewSuccessResponseSuccessEnum_true_ =
    const CreateReviewSuccessResponseSuccessEnum._('true_');

CreateReviewSuccessResponseSuccessEnum
_$createReviewSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$createReviewSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateReviewSuccessResponseSuccessEnum>
_$createReviewSuccessResponseSuccessEnumValues =
    BuiltSet<CreateReviewSuccessResponseSuccessEnum>(
      const <CreateReviewSuccessResponseSuccessEnum>[
        _$createReviewSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<CreateReviewSuccessResponseSuccessEnum>
_$createReviewSuccessResponseSuccessEnumSerializer =
    _$CreateReviewSuccessResponseSuccessEnumSerializer();

class _$CreateReviewSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<CreateReviewSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    CreateReviewSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'CreateReviewSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    CreateReviewSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  CreateReviewSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => CreateReviewSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$CreateReviewSuccessResponse extends CreateReviewSuccessResponse {
  @override
  final CreateReviewSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Review data;

  factory _$CreateReviewSuccessResponse([
    void Function(CreateReviewSuccessResponseBuilder)? updates,
  ]) => (CreateReviewSuccessResponseBuilder()..update(updates))._build();

  _$CreateReviewSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  CreateReviewSuccessResponse rebuild(
    void Function(CreateReviewSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateReviewSuccessResponseBuilder toBuilder() =>
      CreateReviewSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateReviewSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'CreateReviewSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class CreateReviewSuccessResponseBuilder
    implements
        Builder<
          CreateReviewSuccessResponse,
          CreateReviewSuccessResponseBuilder
        > {
  _$CreateReviewSuccessResponse? _$v;

  CreateReviewSuccessResponseSuccessEnum? _success;
  CreateReviewSuccessResponseSuccessEnum? get success => _$this._success;
  set success(CreateReviewSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReviewBuilder? _data;
  ReviewBuilder get data => _$this._data ??= ReviewBuilder();
  set data(ReviewBuilder? data) => _$this._data = data;

  CreateReviewSuccessResponseBuilder() {
    CreateReviewSuccessResponse._defaults(this);
  }

  CreateReviewSuccessResponseBuilder get _$this {
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
  void replace(CreateReviewSuccessResponse other) {
    _$v = other as _$CreateReviewSuccessResponse;
  }

  @override
  void update(void Function(CreateReviewSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateReviewSuccessResponse build() => _build();

  _$CreateReviewSuccessResponse _build() {
    _$CreateReviewSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$CreateReviewSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'CreateReviewSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'CreateReviewSuccessResponse',
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
          r'CreateReviewSuccessResponse',
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
