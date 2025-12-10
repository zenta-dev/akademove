part of '_export.dart';

enum DistanceUnit { m, km }

class Distance extends Equatable {
  const Distance({required this.value, required this.unit});
  final double value;
  final DistanceUnit unit;

  @override
  String toString() {
    if (value >= 1000 && unit == DistanceUnit.m) {
      final inKm = value ~/ 1000;
      return '${inKm.toStringAsFixed(0)} ${unit.name}';
    }
    return '${value.toStringAsFixed(0)} ${unit.name}';
  }

  Distance copyWith({double? value, DistanceUnit? unit}) {
    return Distance(value: value ?? this.value, unit: unit ?? this.unit);
  }

  @override
  List<Object?> get props => [value, unit];

  @override
  bool get stringify => true;
}
