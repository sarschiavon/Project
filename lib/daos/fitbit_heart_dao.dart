import 'package:app_project/entities/fitbit_heart.dart';
import 'package:floor/floor.dart';

@dao
abstract class FitbitHeartDao {
  @Query('SELECT * FROM FitbitHeart ORDER BY dateOfMonitoring desc')
  Future<List<FitbitHeart>> all();

  @Query('SELECT * FROM FitbitHeart ORDER BY dateOfMonitoring desc LIMIT 1')
  Future<FitbitHeart?> mostRecent();

  @Query('SELECT * FROM FitbitHeart ORDER BY id desc LIMIT 1')
  Future<FitbitHeart?> lastInserted();

  @insert
  Future<void> create(FitbitHeart fitbitHeart);
}
