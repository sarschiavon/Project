import 'package:app_project/providers/homepage_provider.dart';
import 'package:app_project/providers/results_provider.dart';
import 'package:app_project/screens/FitbitterLogin.dart';
import 'package:app_project/screens/ResultsPage.dart';
import 'package:flutter/material.dart';
import 'package:app_project/screens/HomePage.dart';
import 'package:app_project/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        FitbitterLogin.route: (context) => const FitbitterLogin(),
        HomePage.route: (context) => ChangeNotifierProvider(
            create: (context) => HomepageProvider(), child: const HomePage()),
        ResultsPage.route: (context) => ChangeNotifierProvider(
              create: (context) => ResultsProvider(),
              child: const ResultsPage(),
            )
      },
    );
  } //build
}//MyApp