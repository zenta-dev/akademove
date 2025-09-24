// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ReportCreateRequestCategoryEnum
_$reportCreateRequestCategoryEnum_behavior =
    const ReportCreateRequestCategoryEnum._('behavior');
const ReportCreateRequestCategoryEnum _$reportCreateRequestCategoryEnum_safety =
    const ReportCreateRequestCategoryEnum._('safety');
const ReportCreateRequestCategoryEnum _$reportCreateRequestCategoryEnum_fraud =
    const ReportCreateRequestCategoryEnum._('fraud');
const ReportCreateRequestCategoryEnum _$reportCreateRequestCategoryEnum_other =
    const ReportCreateRequestCategoryEnum._('other');

ReportCreateRequestCategoryEnum _$reportCreateRequestCategoryEnumValueOf(
  String name,
) {
  switch (name) {
    case 'behavior':
      return _$reportCreateRequestCategoryEnum_behavior;
    case 'safety':
      return _$reportCreateRequestCategoryEnum_safety;
    case 'fraud':
      return _$reportCreateRequestCategoryEnum_fraud;
    case 'other':
      return _$reportCreateRequestCategoryEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportCreateRequestCategoryEnum>
_$reportCreateRequestCategoryEnumValues =
    BuiltSet<ReportCreateRequestCategoryEnum>(
      const <ReportCreateRequestCategoryEnum>[
        _$reportCreateRequestCategoryEnum_behavior,
        _$reportCreateRequestCategoryEnum_safety,
        _$reportCreateRequestCategoryEnum_fraud,
        _$reportCreateRequestCategoryEnum_other,
      ],
    );

const ReportCreateRequestStatusEnum _$reportCreateRequestStatusEnum_pending =
    const ReportCreateRequestStatusEnum._('pending');
const ReportCreateRequestStatusEnum
_$reportCreateRequestStatusEnum_investigating =
    const ReportCreateRequestStatusEnum._('investigating');
const ReportCreateRequestStatusEnum _$reportCreateRequestStatusEnum_resolved =
    const ReportCreateRequestStatusEnum._('resolved');
const ReportCreateRequestStatusEnum _$reportCreateRequestStatusEnum_dismissed =
    const ReportCreateRequestStatusEnum._('dismissed');

ReportCreateRequestStatusEnum _$reportCreateRequestStatusEnumValueOf(
  String name,
) {
  switch (name) {
    case 'pending':
      return _$reportCreateRequestStatusEnum_pending;
    case 'investigating':
      return _$reportCreateRequestStatusEnum_investigating;
    case 'resolved':
      return _$reportCreateRequestStatusEnum_resolved;
    case 'dismissed':
      return _$reportCreateRequestStatusEnum_dismissed;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ReportCreateRequestStatusEnum>
_$reportCreateRequestStatusEnumValues = BuiltSet<ReportCreateRequestStatusEnum>(
  const <ReportCreateRequestStatusEnum>[
    _$reportCreateRequestStatusEnum_pending,
    _$reportCreateRequestStatusEnum_investigating,
    _$reportCreateRequestStatusEnum_resolved,
    _$reportCreateRequestStatusEnum_dismissed,
  ],
);

Serializer<ReportCreateRequestCategoryEnum>
_$reportCreateRequestCategoryEnumSerializer =
    _$ReportCreateRequestCategoryEnumSerializer();
Serializer<ReportCreateRequestStatusEnum>
_$reportCreateRequestStatusEnumSerializer =
    _$ReportCreateRequestStatusEnumSerializer();

class _$ReportCreateRequestCategoryEnumSerializer
    implements PrimitiveSerializer<ReportCreateRequestCategoryEnum> {
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
  final Iterable<Type> types = const <Type>[ReportCreateRequestCategoryEnum];
  @override
  final String wireName = 'ReportCreateRequestCategoryEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReportCreateRequestCategoryEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReportCreateRequestCategoryEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReportCreateRequestCategoryEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReportCreateRequestStatusEnumSerializer
    implements PrimitiveSerializer<ReportCreateRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[ReportCreateRequestStatusEnum];
  @override
  final String wireName = 'ReportCreateRequestStatusEnum';

  @override
  Object serialize(
    Serializers serializers,
    ReportCreateRequestStatusEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ReportCreateRequestStatusEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ReportCreateRequestStatusEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ReportCreateRequest extends ReportCreateRequest {
  @override
  final String? orderId;
  @override
  final String reporterId;
  @override
  final String targetUserId;
  @override
  final ReportCreateRequestCategoryEnum category;
  @override
  final String description;
  @override
  final String? evidenceUrl;
  @override
  final ReportCreateRequestStatusEnum? status;
  @override
  final String? handledById;
  @override
  final String? resolution;

  factory _$ReportCreateRequest([
    void Function(ReportCreateRequestBuilder)? updates,
  ]) => (ReportCreateRequestBuilder()..update(updates))._build();

  _$ReportCreateRequest._({
    this.orderId,
    required this.reporterId,
    required this.targetUserId,
    required this.category,
    required this.description,
    this.evidenceUrl,
    this.status,
    this.handledById,
    this.resolution,
  }) : super._();
  @override
  ReportCreateRequest rebuild(
    void Function(ReportCreateRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ReportCreateRequestBuilder toBuilder() =>
      ReportCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReportCreateRequest &&
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
    return (newBuiltValueToStringHelper(r'ReportCreateRequest')
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

class ReportCreateRequestBuilder
    implements Builder<ReportCreateRequest, ReportCreateRequestBuilder> {
  _$ReportCreateRequest? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  String? _reporterId;
  String? get reporterId => _$this._reporterId;
  set reporterId(String? reporterId) => _$this._reporterId = reporterId;

  String? _targetUserId;
  String? get targetUserId => _$this._targetUserId;
  set targetUserId(String? targetUserId) => _$this._targetUserId = targetUserId;

  ReportCreateRequestCategoryEnum? _category;
  ReportCreateRequestCategoryEnum? get category => _$this._category;
  set category(ReportCreateRequestCategoryEnum? category) =>
      _$this._category = category;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _evidenceUrl;
  String? get evidenceUrl => _$this._evidenceUrl;
  set evidenceUrl(String? evidenceUrl) => _$this._evidenceUrl = evidenceUrl;

  ReportCreateRequestStatusEnum? _status;
  ReportCreateRequestStatusEnum? get status => _$this._status;
  set status(ReportCreateRequestStatusEnum? status) => _$this._status = status;

  String? _handledById;
  String? get handledById => _$this._handledById;
  set handledById(String? handledById) => _$this._handledById = handledById;

  String? _resolution;
  String? get resolution => _$this._resolution;
  set resolution(String? resolution) => _$this._resolution = resolution;

  ReportCreateRequestBuilder() {
    ReportCreateRequest._defaults(this);
  }

  ReportCreateRequestBuilder get _$this {
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
  void replace(ReportCreateRequest other) {
    _$v = other as _$ReportCreateRequest;
  }

  @override
  void update(void Function(ReportCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReportCreateRequest build() => _build();

  _$ReportCreateRequest _build() {
    final _$result =
        _$v ??
        _$ReportCreateRequest._(
          orderId: orderId,
          reporterId: BuiltValueNullFieldError.checkNotNull(
            reporterId,
            r'ReportCreateRequest',
            'reporterId',
          ),
          targetUserId: BuiltValueNullFieldError.checkNotNull(
            targetUserId,
            r'ReportCreateRequest',
            'targetUserId',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'ReportCreateRequest',
            'category',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'ReportCreateRequest',
            'description',
          ),
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
