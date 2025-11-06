// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of '_export.dart';

class PlaceMapper extends ClassMapperBase<Place> {
  PlaceMapper._();

  static PlaceMapper? _instance;
  static PlaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlaceMapper._());
      DistanceMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Place';

  static String _$name(Place v) => v.name;
  static const Field<Place, String> _f$name = Field('name', _$name);
  static String _$vicinity(Place v) => v.vicinity;
  static const Field<Place, String> _f$vicinity = Field('vicinity', _$vicinity);
  static double _$lat(Place v) => v.lat;
  static const Field<Place, double> _f$lat = Field('lat', _$lat);
  static double _$lng(Place v) => v.lng;
  static const Field<Place, double> _f$lng = Field('lng', _$lng);
  static String _$icon(Place v) => v.icon;
  static const Field<Place, String> _f$icon = Field('icon', _$icon);
  static Distance? _$distance(Place v) => v.distance;
  static const Field<Place, Distance> _f$distance = Field(
    'distance',
    _$distance,
    opt: true,
  );

  @override
  final MappableFields<Place> fields = const {
    #name: _f$name,
    #vicinity: _f$vicinity,
    #lat: _f$lat,
    #lng: _f$lng,
    #icon: _f$icon,
    #distance: _f$distance,
  };

  static Place _instantiate(DecodingData data) {
    return Place(
      name: data.dec(_f$name),
      vicinity: data.dec(_f$vicinity),
      lat: data.dec(_f$lat),
      lng: data.dec(_f$lng),
      icon: data.dec(_f$icon),
      distance: data.dec(_f$distance),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Place fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Place>(map);
  }

  static Place fromJson(String json) {
    return ensureInitialized().decodeJson<Place>(json);
  }
}

mixin PlaceMappable {
  String toJson() {
    return PlaceMapper.ensureInitialized().encodeJson<Place>(this as Place);
  }

  Map<String, dynamic> toMap() {
    return PlaceMapper.ensureInitialized().encodeMap<Place>(this as Place);
  }

  PlaceCopyWith<Place, Place, Place> get copyWith =>
      _PlaceCopyWithImpl<Place, Place>(this as Place, $identity, $identity);
  @override
  String toString() {
    return PlaceMapper.ensureInitialized().stringifyValue(this as Place);
  }

  @override
  bool operator ==(Object other) {
    return PlaceMapper.ensureInitialized().equalsValue(this as Place, other);
  }

  @override
  int get hashCode {
    return PlaceMapper.ensureInitialized().hashValue(this as Place);
  }
}

extension PlaceValueCopy<$R, $Out> on ObjectCopyWith<$R, Place, $Out> {
  PlaceCopyWith<$R, Place, $Out> get $asPlace =>
      $base.as((v, t, t2) => _PlaceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlaceCopyWith<$R, $In extends Place, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  DistanceCopyWith<$R, Distance, Distance>? get distance;
  $R call({
    String? name,
    String? vicinity,
    double? lat,
    double? lng,
    String? icon,
    Distance? distance,
  });
  PlaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlaceCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Place, $Out>
    implements PlaceCopyWith<$R, Place, $Out> {
  _PlaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Place> $mapper = PlaceMapper.ensureInitialized();
  @override
  DistanceCopyWith<$R, Distance, Distance>? get distance =>
      $value.distance?.copyWith.$chain((v) => call(distance: v));
  @override
  $R call({
    String? name,
    String? vicinity,
    double? lat,
    double? lng,
    String? icon,
    Object? distance = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != null) #name: name,
      if (vicinity != null) #vicinity: vicinity,
      if (lat != null) #lat: lat,
      if (lng != null) #lng: lng,
      if (icon != null) #icon: icon,
      if (distance != $none) #distance: distance,
    }),
  );
  @override
  Place $make(CopyWithData data) => Place(
    name: data.get(#name, or: $value.name),
    vicinity: data.get(#vicinity, or: $value.vicinity),
    lat: data.get(#lat, or: $value.lat),
    lng: data.get(#lng, or: $value.lng),
    icon: data.get(#icon, or: $value.icon),
    distance: data.get(#distance, or: $value.distance),
  );

  @override
  PlaceCopyWith<$R2, Place, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DistanceMapper extends ClassMapperBase<Distance> {
  DistanceMapper._();

  static DistanceMapper? _instance;
  static DistanceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DistanceMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Distance';

  static double _$value(Distance v) => v.value;
  static const Field<Distance, double> _f$value = Field('value', _$value);
  static DistanceUnit _$unit(Distance v) => v.unit;
  static const Field<Distance, DistanceUnit> _f$unit = Field('unit', _$unit);

  @override
  final MappableFields<Distance> fields = const {
    #value: _f$value,
    #unit: _f$unit,
  };

  static Distance _instantiate(DecodingData data) {
    return Distance(value: data.dec(_f$value), unit: data.dec(_f$unit));
  }

  @override
  final Function instantiate = _instantiate;

  static Distance fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Distance>(map);
  }

  static Distance fromJson(String json) {
    return ensureInitialized().decodeJson<Distance>(json);
  }
}

mixin DistanceMappable {
  String toJson() {
    return DistanceMapper.ensureInitialized().encodeJson<Distance>(
      this as Distance,
    );
  }

  Map<String, dynamic> toMap() {
    return DistanceMapper.ensureInitialized().encodeMap<Distance>(
      this as Distance,
    );
  }

  DistanceCopyWith<Distance, Distance, Distance> get copyWith =>
      _DistanceCopyWithImpl<Distance, Distance>(
        this as Distance,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DistanceMapper.ensureInitialized().stringifyValue(this as Distance);
  }

  @override
  bool operator ==(Object other) {
    return DistanceMapper.ensureInitialized().equalsValue(
      this as Distance,
      other,
    );
  }

  @override
  int get hashCode {
    return DistanceMapper.ensureInitialized().hashValue(this as Distance);
  }
}

extension DistanceValueCopy<$R, $Out> on ObjectCopyWith<$R, Distance, $Out> {
  DistanceCopyWith<$R, Distance, $Out> get $asDistance =>
      $base.as((v, t, t2) => _DistanceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DistanceCopyWith<$R, $In extends Distance, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? value, DistanceUnit? unit});
  DistanceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DistanceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Distance, $Out>
    implements DistanceCopyWith<$R, Distance, $Out> {
  _DistanceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Distance> $mapper =
      DistanceMapper.ensureInitialized();
  @override
  $R call({double? value, DistanceUnit? unit}) => $apply(
    FieldCopyWithData({
      if (value != null) #value: value,
      if (unit != null) #unit: unit,
    }),
  );
  @override
  Distance $make(CopyWithData data) => Distance(
    value: data.get(#value, or: $value.value),
    unit: data.get(#unit, or: $value.unit),
  );

  @override
  DistanceCopyWith<$R2, Distance, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DistanceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

