import 'package:floor/floor.dart';

@entity
class FitbitHeart {
  @primaryKey
  final int? id;

  final int? dateOfMonitoring; // in milliseconds

  final int? restingHeartRate;

  FitbitHeart(
      {this.id,
      required this.dateOfMonitoring,
      required this.restingHeartRate});
}
