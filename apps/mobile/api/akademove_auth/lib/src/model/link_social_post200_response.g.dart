// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_social_post200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LinkSocialPost200Response extends LinkSocialPost200Response {
  @override
  final bool redirect;
  @override
  final String? url;
  @override
  final bool? status;

  factory _$LinkSocialPost200Response(
          [void Function(LinkSocialPost200ResponseBuilder)? updates]) =>
      (LinkSocialPost200ResponseBuilder()..update(updates))._build();

  _$LinkSocialPost200Response._({required this.redirect, this.url, this.status})
      : super._();
  @override
  LinkSocialPost200Response rebuild(
          void Function(LinkSocialPost200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkSocialPost200ResponseBuilder toBuilder() =>
      LinkSocialPost200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkSocialPost200Response &&
        redirect == other.redirect &&
        url == other.url &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, redirect.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LinkSocialPost200Response')
          ..add('redirect', redirect)
          ..add('url', url)
          ..add('status', status))
        .toString();
  }
}

class LinkSocialPost200ResponseBuilder
    implements
        Builder<LinkSocialPost200Response, LinkSocialPost200ResponseBuilder> {
  _$LinkSocialPost200Response? _$v;

  bool? _redirect;
  bool? get redirect => _$this._redirect;
  set redirect(bool? redirect) => _$this._redirect = redirect;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  LinkSocialPost200ResponseBuilder() {
    LinkSocialPost200Response._defaults(this);
  }

  LinkSocialPost200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _redirect = $v.redirect;
      _url = $v.url;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkSocialPost200Response other) {
    _$v = other as _$LinkSocialPost200Response;
  }

  @override
  void update(void Function(LinkSocialPost200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LinkSocialPost200Response build() => _build();

  _$LinkSocialPost200Response _build() {
    final _$result = _$v ??
        _$LinkSocialPost200Response._(
          redirect: BuiltValueNullFieldError.checkNotNull(
              redirect, r'LinkSocialPost200Response', 'redirect'),
          url: url,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
