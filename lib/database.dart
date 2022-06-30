import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:app_project/daos/fitbit_heart_dao.dart';
import 'package:app_project/daos/fitbit_activity_dao.dart';
import 'package:app_project/entities/fitbit_activity.dart';
import 'package:app_project/entities/fitbit_heart.dart';
import 'package:floor/floor.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 2, entities: [FitbitActivity, FitbitHeart])
abstract class AppDatabase extends FloorDatabase {
  FitbitActivityDao get fitbitActivityDao;
  FitbitHeartDao get fitbitHeartDao;
}
