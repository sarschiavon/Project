import 'package:app_project/services/fitbit_credentials.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class FitbitterLogin extends StatelessWidget {
  const FitbitterLogin({Key? key}) : super(key: key);

  static const route = '/fitbitter_login/';
  static const routename = 'Fitbitter login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Hello! Log into your Fitibit account with the button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton(
                onPressed: () => performFitbitterLogin(context),
                child: const Text('LOG IN'))
          ]),
        ));
  } //build

  void performFitbitterLogin(BuildContext context) async {
    String? userId = await fitbitUserId(context);

    if (userId != null) {
      UserStorage.save(userId);
      Navigator.of(context).pushReplacementNamed(HomePage.route);
    }
  }

  Future<String?> fitbitUserId(BuildContext context) async {
    return await FitbitConnector.authorize(
        context: context,
        clientID: FitbitCredentials.clientId,
        clientSecret: FitbitCredentials.clientSecret,
        redirectUri: FitbitCredentials.redirectUri,
        callbackUrlScheme: FitbitCredentials.callbackUrlScheme);
  }
} //FitbitterLogin
