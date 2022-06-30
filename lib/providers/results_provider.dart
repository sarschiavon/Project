import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/foundation.dart';

import '../entities/fitbit_activity.dart';
import '../entities/fitbit_heart.dart';

class ResultsProvider extends ChangeNotifier {
  late List<FitbitHeart> _heartDataList = [];
  List<FitbitHeart> get heartDataList => _heartDataList;

  int get averageHeartRate => _heartDataList.isEmpty
      ? 0
      : (_heartDataList
                  .map((heartData) => heartData.restingHeartRate)
                  .reduce((value, element) => value! + element!)! /
              _heartDataList.length)
          .floor();

  int? get lastHeartDataDateOfMonitoring => _heartDataList.isNotEmpty
      ? _heartDataList[_heartDataList.length - 1].dateOfMonitoring
      : null;

  void setHeartDataList(List<FitbitHeart> freshHeartDataList) {
    _heartDataList = freshHeartDataList;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeHeartData() {
    _heartDataList.clear();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<FitbitActivity> _activityDataList = [];
  List<FitbitActivity> get activityDataList => _activityDataList;

  int get averageActivityDistance => _activityDataList.isEmpty
      ? 0
      : (_activityDataList
                  .map((heartData) => heartData.distance)
                  .reduce((value, element) => value! + element!)! /
              _activityDataList.length)
          .floor();

  int get averageActivityCalories => _activityDataList.isEmpty
      ? 0
      : (_activityDataList
                  .map((heartData) => heartData.calories)
                  .reduce((value, element) => value! + element!)! /
              _activityDataList.length)
          .floor();

  int get averageActivityDuration => _activityDataList.isEmpty
      ? 0
      : (_activityDataList
                  .map((heartData) => heartData.duration)
                  .reduce((value, element) => value! + element!)! /
              _activityDataList.length)
          .floor();

  int? get lastActivityDataDateOfMonitoring => _activityDataList.isNotEmpty
      ? _activityDataList[_activityDataList.length - 1].dateOfMonitoring
      : null;

  void setActivityDataList(List<FitbitActivity> freshActivityDataList) {
    _activityDataList = freshActivityDataList;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeActivityData() {
    _activityDataList.clear();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
