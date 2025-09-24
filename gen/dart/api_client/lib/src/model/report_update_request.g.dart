// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReportUpdateRequestCategoryEnum
_$reportUpdateRequestCategoryEnum_behavior =
    const ReportUpdateRequestCategoryEnum._('behavior');
const ReportUpdateRequestCategoryEnum _$reportUpdateRequestCategoryEnum_safety =
    const ReportUpdateRequestCategoryEnum._('safety');
const ReportUpdateRequestCategoryEnum _$reportUpdateRequestCategoryEnum_fraud =
    const ReportUpdateRequestCategoryEnum._('fraud');
const ReportUpdateRequestCategoryEnum _$reportUpdateRequestCategoryEnum_other =
    const ReportUpdateRequestCategoryEnum._('other');

ReportUpdateRequestCategoryEnum _$reportUpdateRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'behavior':
      return _$reportUpdateRequestCategoryEnum_behavior;
    case 'safety':
      return _$reportUpdateRequestCategoryEnum_safety;
    case 'fraud':
      return _$reportUpdateRequestCategoryEnum_fraud;
    case 'other':
      return _$reportUpdateRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportUpdateRequestCategoryEnum>
_$reportUpdateRequestCategoryEnumValues =
    BuiltSet<ReportUpdateRequestCategoryEnum>(
      const <ReportUpdateRequestCategoryEnum>[
        _$reportUpdateRequestCategoryEnum_behavior,
        _$reportUpdateRequestCategoryEnum_safety,
        _$reportUpdateRequestCategoryEnum_fraud,
        _$reportUpdateRequestCategoryEnum_other,
      ],
    );

const ReportUpdateRequestStatusEnum _$reportUpdateRequestStatusEnum_pending =
    const ReportUpdateRequestStatusEnum._('pending');
const ReportUpdateRequestStatusEnum
_$reportUpdateRequestStatusEnum_investigating =
    const ReportUpdateRequestStatusEnum._('investigating');
const ReportUpdateRequestStatusEnum _$reportUpdateRequestStatusEnum_resolved =
    const ReportUpdateRequestStatusEnum._('resolved');
const ReportUpdateRequestStatusEnum _$reportUpdateRequestStatusEnum_dismissed =
    const ReportUpdateRequestStatusEnum._('dismissed');

ReportUpdateRequestStatusEnum _$reportUpdateRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'pending':
      return _$reportUpdateRequestStatusEnum_pending;
    case 'investigating':
      return _$reportUpdateRequestStatusEnum_investigating;
    case 'resolved':
      return _$reportUpdateRequestStatusEnum_resolved;
    case 'dismissed':
      return _$reportUpdateRequestStatusEnum_dismissed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportUpdateRequestStatusEnum>
_$reportUpdateRequestStatusEnumValues = BuiltSet<ReportUpdateRequestStatusEnum>(
  const <ReportUpdateRequestStatusEnum>[
    _$reportUpdateRequestStatusEnum_pending,
    _$reportUpdateRequestStatusEnum_investigating,
    _$reportUpdateRequestStatusEnum_resolved,
    _$reportUpdateRequestStatusEnum_dismissed,
  ],
);

Serializer<ReportUpdateRequestCategoryEnum>
_$reportUpdateRequestCategoryEnumSerializer =
    _$ReportUpdateRequestCategoryEnumSerializer();
Serializer<ReportUpdateRequestStatusEnum>
_$reportUpdateRequestStatusEnumSerializer =
    _$ReportUpdateRequestStatusEnumSerializer();

class _$ReportUpdateRequestCategoryEnumSerializer
    implements PrimitiveSerializer<ReportUpdateRequestCategoryEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'behavior': 'behavior',
    'safety': 'safety',
    'fraud': 'fraud',
    'other': 'other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'behavior': 'behavior',
    'safety': 'safety',
    'fraud': 'fraud',
    'other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[ReportUpdateRequestCategoryEnum];
  @override
  final String wireName = 'ReportUpdateRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReportUpdateRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReportUpdateRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReportUpdateRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReportUpdateRequestStatusEnumSerializer
    implements PrimitiveSerializer<ReportUpdateRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'investigating': 'investigating',
    'resolved': 'resolved',
    'dismissed': 'dismissed',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'investigating': 'investigating',
    'resolved': 'resolved',
    'dismissed': 'dismissed',
  };

  @override
  final Iterable<Type> types = const <Type>[ReportUpdateRequestStatusEnum];
  @override
  final String wireName = 'ReportUpdateRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReportUpdateRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReportUpdateRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReportUpdateRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReportUpdateRequest extends ReportUpdateRequest {
  @override
  final String? orderId;
  @override
  final String? reporterId;
  @override
  final String? targetUserId;
  @override
  final ReportUpdateRequestCategoryEnum? category;
  @override
  final String? description;
  @override
  final String? evidenceUrl;
  @override
  final ReportUpdateRequestStatusEnum? status;
  @override
  final String? handledById;
  @override
  final String? resolution;

  factory _$ReportUpdateRequest([
    void Function(ReportUpdateRequestBuilder)? updates,
  ]) => (ReportUpdateRequestBuilder()..update(updates))._build();

  _$ReportUpdateRequest._({
    this.orderId,
    this.reporterId,
    this.targetUserId,
    this.category,
    this.description,
    this.evidenceUrl,
    this.status,
    this.handledById,
    this.resolution,
  }) : super._();
  @override
  ReportUpdateRequest rebuild(
    void Function(ReportUpdateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReportUpdateRequestBuilder toBuilder() =>
      ReportUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportUpdateRequest &&
        orderId == other.orderId &&
        reporterId == other.reporterId &&
        targetUserId == other.targetUserId &&
        category == other.category &&
        description == other.description &&
        evidenceUrl == other.evidenceUrl &&
        status == other.status &&
        handledById == other.handledById &&
        resolution == other.resolution;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, reporterId.hashCode);
    _$hash = $jc(_$hash, targetUserId.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, evidenceUrl.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, handledById.hashCode);
    _$hash = $jc(_$hash, resolution.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReportUpdateRequest')
          ..add('orderId', orderId)
          ..add('reporterId', reporterId)
          ..add('targetUserId', targetUserId)
          ..add('category', category)
          ..add('description', description)
          ..add('evidenceUrl', evidenceUrl)
          ..add('status', status)
          ..add('handledById', handledById)
          ..add('resolution', resolution))
        .toString();
  }
}

class ReportUpdateRequestBuilder
    implements Builder<ReportUpdateRequest, ReportUpdateRequestBuilder> {
  _$ReportUpdateRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _reporterId;
  String? get reporterId => _$this._reporterId;
  set reporterId(String? reporterId) => _$this._reporterId = reporterId;

  String? _targetUserId;
  String? get targetUserId => _$this._targetUserId;
  set targetUserId(String? targetUserId) => _$this._targetUserId = targetUserId;

  ReportUpdateRequestCategoryEnum? _category;
  ReportUpdateRequestCategoryEnum? get category => _$this._category;
  set category(ReportUpdateRequestCategoryEnum? category) =>
      _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _evidenceUrl;
  String? get evidenceUrl => _$this._evidenceUrl;
  set evidenceUrl(String? evidenceUrl) => _$this._evidenceUrl = evidenceUrl;

  ReportUpdateRequestStatusEnum? _status;
  ReportUpdateRequestStatusEnum? get status => _$this._status;
  set status(ReportUpdateRequestStatusEnum? status) => _$this._status = status;

  String? _handledById;
  String? get handledById => _$this._handledById;
  set handledById(String? handledById) => _$this._handledById = handledById;

  String? _resolution;
  String? get resolution => _$this._resolution;
  set resolution(String? resolution) => _$this._resolution = resolution;

  ReportUpdateRequestBuilder() {
    ReportUpdateRequest._defaults(this);
  }

  ReportUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _reporterId = $v.reporterId;
      _targetUserId = $v.targetUserId;
      _category = $v.category;
      _description = $v.description;
      _evidenceUrl = $v.evidenceUrl;
      _status = $v.status;
      _handledById = $v.handledById;
      _resolution = $v.resolution;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReportUpdateRequest other) {
    _$v = other as _$ReportUpdateRequest;
  }

  @override
  void update(void Function(ReportUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportUpdateRequest build() => _build();

  _$ReportUpdateRequest _build() {
    final _$result =
        _$v ??
        _$ReportUpdateRequest._(
          orderId: orderId,
          reporterId: reporterId,
          targetUserId: targetUserId,
          category: category,
          description: description,
          evidenceUrl: evidenceUrl,
          status: status,
          handledById: handledById,
          resolution: resolution,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
