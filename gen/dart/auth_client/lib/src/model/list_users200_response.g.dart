// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_users200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListUsers200Response extends ListUsers200Response {
  @override
  final BuiltList<User> users;
  @override
  final num total;
  @override
  final num? limit;
  @override
  final num? offset;

  factory _$ListUsers200Response([
    void Function(ListUsers200ResponseBuilder)? updates,
  ]) => (ListUsers200ResponseBuilder()..update(updates))._build();

  _$ListUsers200Response._({
    required this.users,
    required this.total,
    this.limit,
    this.offset,
  }) : super._();
  @override
  ListUsers200Response rebuild(
    void Function(ListUsers200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListUsers200ResponseBuilder toBuilder() =>
      ListUsers200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListUsers200Response &&
        users == other.users &&
        total == other.total &&
        limit == other.limit &&
        offset == other.offset;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, users.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, offset.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListUsers200Response')
          ..add('users', users)
          ..add('total', total)
          ..add('limit', limit)
          ..add('offset', offset))
        .toString();
  }
}

class ListUsers200ResponseBuilder
    implements Builder<ListUsers200Response, ListUsers200ResponseBuilder> {
  _$ListUsers200Response? _$v;

  ListBuilder<User>? _users;
  ListBuilder<User> get users => _$this._users ??= ListBuilder<User>();
  set users(ListBuilder<User>? users) => _$this._users = users;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  num? _limit;
  num? get limit => _$this._limit;
  set limit(num? limit) => _$this._limit = limit;

  num? _offset;
  num? get offset => _$this._offset;
  set offset(num? offset) => _$this._offset = offset;

  ListUsers200ResponseBuilder() {
    ListUsers200Response._defaults(this);
  }

  ListUsers200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _users = $v.users.toBuilder();
      _total = $v.total;
      _limit = $v.limit;
      _offset = $v.offset;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListUsers200Response other) {
    _$v = other as _$ListUsers200Response;
  }

  @override
  void update(void Function(ListUsers200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListUsers200Response build() => _build();

  _$ListUsers200Response _build() {
    _$ListUsers200Response _$result;
    try {
      _$result =
          _$v ??
          _$ListUsers200Response._(
            users: users.build(),
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'ListUsers200Response',
              'total',
            ),
            limit: limit,
            offset: offset,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'users';
        users.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ListUsers200Response',
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
