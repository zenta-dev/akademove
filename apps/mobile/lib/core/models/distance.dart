part of '_export.dart';

enum DistanceUnit { m, km }

@MappableClass()
class Distance with DistanceMappable {
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
}
