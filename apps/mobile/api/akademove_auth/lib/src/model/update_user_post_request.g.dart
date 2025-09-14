// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_post_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateUserPostRequest extends UpdateUserPostRequest {
  @override
  final String? name;
  @override
  final String? image;

  factory _$UpdateUserPostRequest(
          [void Function(UpdateUserPostRequestBuilder)? updates]) =>
      (UpdateUserPostRequestBuilder()..update(updates))._build();

  _$UpdateUserPostRequest._({this.name, this.image}) : super._();
  @override
  UpdateUserPostRequest rebuild(
          void Function(UpdateUserPostRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateUserPostRequestBuilder toBuilder() =>
      UpdateUserPostRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateUserPostRequest &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateUserPostRequest')
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class UpdateUserPostRequestBuilder
    implements Builder<UpdateUserPostRequest, UpdateUserPostRequestBuilder> {
  _$UpdateUserPostRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  UpdateUserPostRequestBuilder() {
    UpdateUserPostRequest._defaults(this);
  }

  UpdateUserPostRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _image = $v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateUserPostRequest other) {
    _$v = other as _$UpdateUserPostRequest;
  }

  @override
  void update(void Function(UpdateUserPostRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateUserPostRequest build() => _build();

  _$UpdateUserPostRequest _build() {
    final _$result = _$v ??
        _$UpdateUserPostRequest._(
          name: name,
          image: image,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
