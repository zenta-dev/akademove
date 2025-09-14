// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request_note.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateOrderRequestNote extends CreateOrderRequestNote {
  @override
  final String? pickup;
  @override
  final String? dropoff;

  factory _$CreateOrderRequestNote(
          [void Function(CreateOrderRequestNoteBuilder)? updates]) =>
      (CreateOrderRequestNoteBuilder()..update(updates))._build();

  _$CreateOrderRequestNote._({this.pickup, this.dropoff}) : super._();
  @override
  CreateOrderRequestNote rebuild(
          void Function(CreateOrderRequestNoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateOrderRequestNoteBuilder toBuilder() =>
      CreateOrderRequestNoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateOrderRequestNote &&
        pickup == other.pickup &&
        dropoff == other.dropoff;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pickup.hashCode);
    _$hash = $jc(_$hash, dropoff.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateOrderRequestNote')
          ..add('pickup', pickup)
          ..add('dropoff', dropoff))
        .toString();
  }
}

class CreateOrderRequestNoteBuilder
    implements Builder<CreateOrderRequestNote, CreateOrderRequestNoteBuilder> {
  _$CreateOrderRequestNote? _$v;

  String? _pickup;
  String? get pickup => _$this._pickup;
  set pickup(String? pickup) => _$this._pickup = pickup;

  String? _dropoff;
  String? get dropoff => _$this._dropoff;
  set dropoff(String? dropoff) => _$this._dropoff = dropoff;

  CreateOrderRequestNoteBuilder() {
    CreateOrderRequestNote._defaults(this);
  }

  CreateOrderRequestNoteBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pickup = $v.pickup;
      _dropoff = $v.dropoff;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateOrderRequestNote other) {
    _$v = other as _$CreateOrderRequestNote;
  }

  @override
  void update(void Function(CreateOrderRequestNoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateOrderRequestNote build() => _build();

  _$CreateOrderRequestNote _build() {
    final _$result = _$v ??
        _$CreateOrderRequestNote._(
          pickup: pickup,
          dropoff: dropoff,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
