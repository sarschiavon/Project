import 'package:app_project/entities/fitbit_activity.dart';
import 'package:floor/floor.dart';

@dao
abstract class FitbitActivityDao {
  @Query('SELECT * FROM FitbitActivity ORDER BY dateOfMonitoring desc')
  Future<List<FitbitActivity>> all();

  @Query('SELECT * FROM FitbitActivity ORDER BY dateOfMonitoring desc LIMIT 1')
  Future<FitbitActivity?> mostRecent();

  @Query('SELECT * FROM FitbitActivity WHERE id = :id')
  Future<FitbitActivity?> find(int id);

  @Query('SELECT * FROM FitbitActivity ORDER BY id desc LIMIT 1')
  Future<FitbitActivity?> lastInserted();

  @insert
  Future<void> create(FitbitActivity fitbitActivity);
}
