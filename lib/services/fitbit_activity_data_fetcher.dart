import 'package:app_project/services/fitbit_credentials.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';

class FitbitActivityDataFetcher {
  BuildContext? context;

  FitbitActivityDataFetcher(BuildContext this.context);

  Future<List<FitbitData>> fetch() async {
    FitbitActivityDataManager fitbitActivityDataManager =
        getFitbitActivityDataManager();
    FitbitActivityAPIURL fitbitActivityApiUrl = await getFitbitActivityApiUrl();
    List<FitbitData> fitbitActivityData =
        await fitbitActivityDataManager.fetch(fitbitActivityApiUrl);
    return fitbitActivityData;
  }

  Future<FitbitActivityAPIURL> getFitbitActivityApiUrl() async {
    return FitbitActivityAPIURL.day(
      date: DateTime.now(),
      userID: await UserStorage.read(),
    );
  }

  FitbitActivityDataManager getFitbitActivityDataManager() {
    return FitbitActivityDataManager(
      clientID: FitbitCredentials.clientId,
      clientSecret: FitbitCredentials.clientSecret,
    );
  }
}
