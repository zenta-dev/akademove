// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_review_by_id_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GetReviewByIdSuccessResponseSuccessEnum
_$getReviewByIdSuccessResponseSuccessEnum_true_ =
    const GetReviewByIdSuccessResponseSuccessEnum._('true_');

GetReviewByIdSuccessResponseSuccessEnum
_$getReviewByIdSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$getReviewByIdSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GetReviewByIdSuccessResponseSuccessEnum>
_$getReviewByIdSuccessResponseSuccessEnumValues =
    BuiltSet<GetReviewByIdSuccessResponseSuccessEnum>(
      const <GetReviewByIdSuccessResponseSuccessEnum>[
        _$getReviewByIdSuccessResponseSuccessEnum_true_,
      ],
    );

Serializer<GetReviewByIdSuccessResponseSuccessEnum>
_$getReviewByIdSuccessResponseSuccessEnumSerializer =
    _$GetReviewByIdSuccessResponseSuccessEnumSerializer();

class _$GetReviewByIdSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<GetReviewByIdSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    GetReviewByIdSuccessResponseSuccessEnum,
  ];
  @override
  final String wireName = 'GetReviewByIdSuccessResponseSuccessEnum';

  @override
  Object serialize(
    Serializers serializers,
    GetReviewByIdSuccessResponseSuccessEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  GetReviewByIdSuccessResponseSuccessEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => GetReviewByIdSuccessResponseSuccessEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$GetReviewByIdSuccessResponse extends GetReviewByIdSuccessResponse {
  @override
  final GetReviewByIdSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final Review data;

  factory _$GetReviewByIdSuccessResponse([
    void Function(GetReviewByIdSuccessResponseBuilder)? updates,
  ]) => (GetReviewByIdSuccessResponseBuilder()..update(updates))._build();

  _$GetReviewByIdSuccessResponse._({
    required this.success,
    required this.message,
    required this.data,
  }) : super._();
  @override
  GetReviewByIdSuccessResponse rebuild(
    void Function(GetReviewByIdSuccessResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GetReviewByIdSuccessResponseBuilder toBuilder() =>
      GetReviewByIdSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetReviewByIdSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'GetReviewByIdSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class GetReviewByIdSuccessResponseBuilder
    implements
        Builder<
          GetReviewByIdSuccessResponse,
          GetReviewByIdSuccessResponseBuilder
        > {
  _$GetReviewByIdSuccessResponse? _$v;

  GetReviewByIdSuccessResponseSuccessEnum? _success;
  GetReviewByIdSuccessResponseSuccessEnum? get success => _$this._success;
  set success(GetReviewByIdSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ReviewBuilder? _data;
  ReviewBuilder get data => _$this._data ??= ReviewBuilder();
  set data(ReviewBuilder? data) => _$this._data = data;

  GetReviewByIdSuccessResponseBuilder() {
    GetReviewByIdSuccessResponse._defaults(this);
  }

  GetReviewByIdSuccessResponseBuilder get _$this {
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
  void replace(GetReviewByIdSuccessResponse other) {
    _$v = other as _$GetReviewByIdSuccessResponse;
  }

  @override
  void update(void Function(GetReviewByIdSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetReviewByIdSuccessResponse build() => _build();

  _$GetReviewByIdSuccessResponse _build() {
    _$GetReviewByIdSuccessResponse _$result;
    try {
      _$result =
          _$v ??
          _$GetReviewByIdSuccessResponse._(
            success: BuiltValueNullFieldError.checkNotNull(
              success,
              r'GetReviewByIdSuccessResponse',
              'success',
            ),
            message: BuiltValueNullFieldError.checkNotNull(
              message,
              r'GetReviewByIdSuccessResponse',
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
          r'GetReviewByIdSuccessResponse',
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
