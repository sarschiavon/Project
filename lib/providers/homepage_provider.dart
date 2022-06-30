import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/foundation.dart';

import '../entities/fitbit_activity.dart';
import '../entities/fitbit_heart.dart';

class HomepageProvider extends ChangeNotifier {
  FitbitHeart? _heartData;
  FitbitHeart? get heartData => _heartData;

  void setHeartData(FitbitHeart freshHeartData) {
    _heartData = freshHeartData;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeHeartData() {
    _heartData = null;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  FitbitActivity? _activityData;
  FitbitActivity? get activityData => _activityData;

  void setActivityData(FitbitActivity freshActivityData) {
    _activityData = freshActivityData;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeActivityData() {
    _activityData = null;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  List<FitbitSleepData?> _sleepData = [];
  List<FitbitSleepData?> get sleepData => _sleepData;
  DateTime? get asleepDate =>
      _sleepData.isNotEmpty ? _sleepData[0]!.entryDateTime : null;

  void setSleepData(List<FitbitSleepData> freshSleepData) {
    _sleepData = freshSleepData;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeSleepData() {
    _sleepData.clear();

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
