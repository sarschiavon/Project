import 'package:app_project/screens/HomePage.dart';
import 'package:app_project/screens/FitbitterLogin.dart';
import 'package:app_project/services/fitbit_credentials.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => redirectUserToRightScreen());
  } //initState

  //Check if the user is already logged in before rendering the login page
  void redirectUserToRightScreen() async {
    if (await isUserAlreadyLogged()) {
      Navigator.of(context).pushReplacementNamed(HomePage.route);
    } else {
      Navigator.of(context).pushReplacementNamed(FitbitterLogin.route);
    }
  }

  Future<bool> isUserAlreadyLogged() async {
    // is user is not present in storage go to Login
    if (!await UserStorage.present()) {
      return false;
    }

    // if token valid go to homepage
    if (await FitbitConnector.isTokenValid()) {
      return true;
    }

    // if token not valid try the refresh token
    await FitbitConnector.refreshToken(
        clientID: FitbitCredentials.clientId,
        clientSecret: FitbitCredentials.clientSecret);

    // if token is valid now go to homepage otherwise go to login
    return await FitbitConnector.isTokenValid();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Center(
      child: Text('loading...'),
    )));
  } //build
} //SplashScreen
