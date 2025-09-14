// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_accounts_get200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ListAccountsGet200ResponseInner
    extends ListAccountsGet200ResponseInner {
  @override
  final String id;
  @override
  final String providerId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String accountId;
  @override
  final BuiltList<String> scopes;

  factory _$ListAccountsGet200ResponseInner([
    void Function(ListAccountsGet200ResponseInnerBuilder)? updates,
  ]) => (ListAccountsGet200ResponseInnerBuilder()..update(updates))._build();

  _$ListAccountsGet200ResponseInner._({
    required this.id,
    required this.providerId,
    required this.createdAt,
    required this.updatedAt,
    required this.accountId,
    required this.scopes,
  }) : super._();
  @override
  ListAccountsGet200ResponseInner rebuild(
    void Function(ListAccountsGet200ResponseInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ListAccountsGet200ResponseInnerBuilder toBuilder() =>
      ListAccountsGet200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListAccountsGet200ResponseInner &&
        id == other.id &&
        providerId == other.providerId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        accountId == other.accountId &&
        scopes == other.scopes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, providerId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, scopes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListAccountsGet200ResponseInner')
          ..add('id', id)
          ..add('providerId', providerId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('accountId', accountId)
          ..add('scopes', scopes))
        .toString();
  }
}

class ListAccountsGet200ResponseInnerBuilder
    implements
        Builder<
          ListAccountsGet200ResponseInner,
          ListAccountsGet200ResponseInnerBuilder
        > {
  _$ListAccountsGet200ResponseInner? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _providerId;
  String? get providerId => _$this._providerId;
  set providerId(String? providerId) => _$this._providerId = providerId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  ListBuilder<String>? _scopes;
  ListBuilder<String> get scopes => _$this._scopes ??= ListBuilder<String>();
  set scopes(ListBuilder<String>? scopes) => _$this._scopes = scopes;

  ListAccountsGet200ResponseInnerBuilder() {
    ListAccountsGet200ResponseInner._defaults(this);
  }

  ListAccountsGet200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _providerId = $v.providerId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _accountId = $v.accountId;
      _scopes = $v.scopes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListAccountsGet200ResponseInner other) {
    _$v = other as _$ListAccountsGet200ResponseInner;
  }

  @override
  void update(void Function(ListAccountsGet200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListAccountsGet200ResponseInner build() => _build();

  _$ListAccountsGet200ResponseInner _build() {
    _$ListAccountsGet200ResponseInner _$result;
    try {
      _$result =
          _$v ??
          _$ListAccountsGet200ResponseInner._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'ListAccountsGet200ResponseInner',
              'id',
            ),
            providerId: BuiltValueNullFieldError.checkNotNull(
              providerId,
              r'ListAccountsGet200ResponseInner',
              'providerId',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'ListAccountsGet200ResponseInner',
              'createdAt',
            ),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt,
              r'ListAccountsGet200ResponseInner',
              'updatedAt',
            ),
            accountId: BuiltValueNullFieldError.checkNotNull(
              accountId,
              r'ListAccountsGet200ResponseInner',
              'accountId',
            ),
            scopes: scopes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'scopes';
        scopes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ListAccountsGet200ResponseInner',
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
