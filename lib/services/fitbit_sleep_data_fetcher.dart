import 'package:app_project/services/fitbit_credentials.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';

class FitbitSleepDataFetcher {
  BuildContext? context;

  FitbitSleepDataFetcher(BuildContext this.context);

  Future<List<FitbitData>> fetch() async {
    FitbitSleepDataManager fitbitSleepDataManager = getFitbitSleepDataManager();
    FitbitSleepAPIURL fitbitSleepApiUrl = await getFitbitSleepApiUrl();
    List<FitbitData> fitbitSleepData =
        await fitbitSleepDataManager.fetch(fitbitSleepApiUrl);
    return fitbitSleepData;
  }

  Future<FitbitSleepAPIURL> getFitbitSleepApiUrl() async {
    return FitbitSleepAPIURL.withUserIDAndDay(
      date: DateTime.now(),
      userID: await UserStorage.read(),
    );
  }

  FitbitSleepDataManager getFitbitSleepDataManager() {
    return FitbitSleepDataManager(
      clientID: FitbitCredentials.clientId,
      clientSecret: FitbitCredentials.clientSecret,
    );
  }
}
