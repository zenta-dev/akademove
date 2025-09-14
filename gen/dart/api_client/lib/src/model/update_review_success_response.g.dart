// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_review_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateReviewSuccessResponseSuccessEnum
_$updateReviewSuccessResponseSuccessEnum_true_ =
    const UpdateReviewSuccessResponseSuccessEnum._('true_');

UpdateReviewSuccessResponseSuccessEnum
_$updateReviewSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$updateReviewSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateReviewSuccessResponseSuccessEnum>
_$updateReviewSuccessResponseSuccessEnumValues =
    BuiltSet<UpdateReviewSuccessResponseSuccessEnum>(
      const <UpdateReviewSuccessResponseSuccessEnum>[
        _$updateReviewSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<UpdateReviewSuccessResponseSuccessEnum>
_$updateReviewSuccessResponseSuccessEnumSerializer =
    _$UpdateReviewSuccessResponseSuccessEnumSerializer();

class _$UpdateReviewSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<UpdateReviewSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    UpdateReviewSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'UpdateReviewSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    UpdateReviewSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  UpdateReviewSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => UpdateReviewSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$UpdateReviewSuccessResponse extends UpdateReviewSuccessResponse {
  @override
  final UpdateReviewSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Review data;

  factory _$UpdateReviewSuccessResponse([
    void Function(UpdateReviewSuccessResponseBuilder)? updates,
  ]) => (UpdateReviewSuccessResponseBuilder()..update(updates))._build();

  _$UpdateReviewSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  UpdateReviewSuccessResponse rebuild(
    void Function(UpdateReviewSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateReviewSuccessResponseBuilder toBuilder() =>
      UpdateReviewSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateReviewSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'UpdateReviewSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class UpdateReviewSuccessResponseBuilder
    implements
        Builder<
          UpdateReviewSuccessResponse,
          UpdateReviewSuccessResponseBuilder
        > {
  _$UpdateReviewSuccessResponse? _$v;

  UpdateReviewSuccessResponseSuccessEnum? _success;
  UpdateReviewSuccessResponseSuccessEnum? get success => _$this._success;
  set success(UpdateReviewSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReviewBuilder? _data;
  ReviewBuilder get data => _$this._data ??= ReviewBuilder();
  set data(ReviewBuilder? data) => _$this._data = data;

  UpdateReviewSuccessResponseBuilder() {
    UpdateReviewSuccessResponse._defaults(this);
  }

  UpdateReviewSuccessResponseBuilder get _$this {
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
  void replace(UpdateReviewSuccessResponse other) {
    _$v = other as _$UpdateReviewSuccessResponse;
  }

  @override
  void update(void Function(UpdateReviewSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateReviewSuccessResponse build() => _build();

  _$UpdateReviewSuccessResponse _build() {
    _$UpdateReviewSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$UpdateReviewSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'UpdateReviewSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'UpdateReviewSuccessResponse',
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
          r'UpdateReviewSuccessResponse',
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
