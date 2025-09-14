// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_review_success_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeleteReviewSuccessResponseSuccessEnum
    _$deleteReviewSuccessResponseSuccessEnum_true_ =
    const DeleteReviewSuccessResponseSuccessEnum._('true_');

DeleteReviewSuccessResponseSuccessEnum
    _$deleteReviewSuccessResponseSuccessEnumValueOf(String name) {
  switch (name) {
    case 'true_':
      return _$deleteReviewSuccessResponseSuccessEnum_true_;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DeleteReviewSuccessResponseSuccessEnum>
    _$deleteReviewSuccessResponseSuccessEnumValues = BuiltSet<
        DeleteReviewSuccessResponseSuccessEnum>(const <DeleteReviewSuccessResponseSuccessEnum>[
  _$deleteReviewSuccessResponseSuccessEnum_true_,
]);

Serializer<DeleteReviewSuccessResponseSuccessEnum>
    _$deleteReviewSuccessResponseSuccessEnumSerializer =
    _$DeleteReviewSuccessResponseSuccessEnumSerializer();

class _$DeleteReviewSuccessResponseSuccessEnumSerializer
    implements PrimitiveSerializer<DeleteReviewSuccessResponseSuccessEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'true_': 'true',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'true': 'true_',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DeleteReviewSuccessResponseSuccessEnum
  ];
  @override
  final String wireName = 'DeleteReviewSuccessResponseSuccessEnum';

  @override
  Object serialize(Serializers serializers,
          DeleteReviewSuccessResponseSuccessEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeleteReviewSuccessResponseSuccessEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeleteReviewSuccessResponseSuccessEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeleteReviewSuccessResponse extends DeleteReviewSuccessResponse {
  @override
  final DeleteReviewSuccessResponseSuccessEnum success;
  @override
  final String message;
  @override
  final JsonObject? data;

  factory _$DeleteReviewSuccessResponse(
          [void Function(DeleteReviewSuccessResponseBuilder)? updates]) =>
      (DeleteReviewSuccessResponseBuilder()..update(updates))._build();

  _$DeleteReviewSuccessResponse._(
      {required this.success, required this.message, this.data})
      : super._();
  @override
  DeleteReviewSuccessResponse rebuild(
          void Function(DeleteReviewSuccessResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteReviewSuccessResponseBuilder toBuilder() =>
      DeleteReviewSuccessResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteReviewSuccessResponse &&
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
    return (newBuiltValueToStringHelper(r'DeleteReviewSuccessResponse')
          ..add('success', success)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class DeleteReviewSuccessResponseBuilder
    implements
        Builder<DeleteReviewSuccessResponse,
            DeleteReviewSuccessResponseBuilder> {
  _$DeleteReviewSuccessResponse? _$v;

  DeleteReviewSuccessResponseSuccessEnum? _success;
  DeleteReviewSuccessResponseSuccessEnum? get success => _$this._success;
  set success(DeleteReviewSuccessResponseSuccessEnum? success) =>
      _$this._success = success;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  DeleteReviewSuccessResponseBuilder() {
    DeleteReviewSuccessResponse._defaults(this);
  }

  DeleteReviewSuccessResponseBuilder get _$this {
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
  void replace(DeleteReviewSuccessResponse other) {
    _$v = other as _$DeleteReviewSuccessResponse;
  }

  @override
  void update(void Function(DeleteReviewSuccessResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteReviewSuccessResponse build() => _build();

  _$DeleteReviewSuccessResponse _build() {
    final _$result = _$v ??
        _$DeleteReviewSuccessResponse._(
          success: BuiltValueNullFieldError.checkNotNull(
              success, r'DeleteReviewSuccessResponse', 'success'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'DeleteReviewSuccessResponse', 'message'),
          data: data,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
