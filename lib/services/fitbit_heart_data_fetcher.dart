import 'package:app_project/services/fitbit_credentials.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';

class FitbitHeartDataFetcher {
  BuildContext? context;

  FitbitHeartDataFetcher(BuildContext this.context);

  Future<List<FitbitData>> fetch() async {
    FitbitHeartDataManager fitbitHeartDataManager = getFitbitHeartDataManager();
    FitbitHeartAPIURL fitbitHeartApiUrl = await getFitbitHeartApiUrl();
    List<FitbitData> fitbitHeartData =
        await fitbitHeartDataManager.fetch(fitbitHeartApiUrl);
    return fitbitHeartData;
  }

  Future<FitbitHeartAPIURL> getFitbitHeartApiUrl() async {
    return FitbitHeartAPIURL.dayWithUserID(
      date: DateTime.now(),
      userID: await UserStorage.read(),
    );
  }

  FitbitHeartDataManager getFitbitHeartDataManager() {
    return FitbitHeartDataManager(
      clientID: FitbitCredentials.clientId,
      clientSecret: FitbitCredentials.clientSecret,
    );
  }
}
