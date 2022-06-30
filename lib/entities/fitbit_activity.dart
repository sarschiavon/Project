import 'package:floor/floor.dart';

@entity
class FitbitActivity {
  @primaryKey
  final int id;

  final String? name;

  final String? description;

  final double? calories;
  final double? distance;
  final double? duration;
  final int? dateOfMonitoring; // in milliseconds
  final int? startTime; // in milliseconds

  FitbitActivity(this.id, this.name, this.description, this.calories,
      this.distance, this.duration, this.dateOfMonitoring, this.startTime);
}
