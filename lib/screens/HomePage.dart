import 'package:app_project/entities/fitbit_activity.dart';
import 'package:app_project/entities/fitbit_heart.dart';
import 'package:app_project/providers/homepage_provider.dart';
import 'package:app_project/screens/ResultsPage.dart';
import 'package:app_project/screens/SplashScreen.dart';
import 'package:app_project/services/fitbit_heart_data_fetcher.dart';
import 'package:app_project/services/fitbit_activity_data_fetcher.dart';
import 'package:app_project/services/fitbit_sleep_data_fetcher.dart';
import 'package:app_project/services/user_storage.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../database.dart';

class HomePage extends StatelessWidget {
  static const route = '/home/';
  static const routename = 'Homepage';

  const HomePage({Key? key}) : super(key: key);

  Future<void> fetchHeartData(BuildContext context) async {
    final heartDataFetcher = FitbitHeartDataFetcher(context);
    final heartDataList =
        await heartDataFetcher.fetch() as List<FitbitHeartData>;
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final fitbitHeartDao = database.fitbitHeartDao;
    var lastItem = await fitbitHeartDao.lastInserted();
    for (var heartItem in heartDataList) {
      final heart = FitbitHeart(
          id: (lastItem?.id ?? 0) + 1,
          restingHeartRate: heartItem.restingHeartRate,
          dateOfMonitoring: heartItem.dateOfMonitoring?.millisecondsSinceEpoch);
      fitbitHeartDao.create(heart);
      lastItem = heart;
    }
    fetchHeartDataFromDB(context);
  }

  Future<void> fetchActivityData(BuildContext context) async {
    final activityDataFetcher = FitbitActivityDataFetcher(context);
    final activityDataList =
        await activityDataFetcher.fetch() as List<FitbitActivityData>;
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final fitbitActivityDao = database.fitbitActivityDao;
    var lastItem = await fitbitActivityDao.lastInserted();
    for (var activityItem in activityDataList) {
      final activity = FitbitActivity(
          (lastItem?.id ?? 0) + 2,
          activityItem.name,
          activityItem.description,
          activityItem.calories,
          activityItem.distance,
          activityItem.duration,
          activityItem.dateOfMonitoring?.millisecondsSinceEpoch,
          activityItem.startTime?.millisecondsSinceEpoch);
      fitbitActivityDao.create(activity);
      lastItem = activity;
    }
    fetchActivityDataFromDB(context);
  }

  Future<void> fetchSleepData(BuildContext context) async {
    final activityDataFetcher = FitbitSleepDataFetcher(context);
    final sleepDataList = await activityDataFetcher.fetch();
    final homepage = Provider.of<HomepageProvider>(context, listen: false);
    homepage.setSleepData(sleepDataList as List<FitbitSleepData>);
  }

  Future<void> fetchActivityDataFromDB(BuildContext context) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final homepage = Provider.of<HomepageProvider>(context, listen: false);

    final fitbitActivityDao = database.fitbitActivityDao;
    final mostRecentActivity = await fitbitActivityDao.mostRecent();
    if (mostRecentActivity != null) {
      homepage.setActivityData(mostRecentActivity);
    }
  }

  Future<void> fetchHeartDataFromDB(BuildContext context) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final homepage = Provider.of<HomepageProvider>(context, listen: false);

    final fitbitHeartDao = database.fitbitHeartDao;
    final mostRecentHeart = await fitbitHeartDao.mostRecent();
    if (mostRecentHeart != null) {
      homepage.setHeartData(mostRecentHeart);
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) =>
        {fetchActivityDataFromDB(context), fetchHeartDataFromDB(context)});

    SchedulerBinding.instance?.addPostFrameCallback((_) => {
          fetchHeartData(context),
          fetchActivityData(context),
          fetchSleepData(context)
        });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(HomePage.routename),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<HomepageProvider>(
                  builder: ((_context, homepage, _child) => Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                                leading: Icon(
                                  Icons.favorite,
                                  color: Colors.red.shade800,
                                  size: 30,
                                ),
                                title: Text(
                                    'Last recorded heartbeat: ${homepage.heartData?.restingHeartRate}'))
                          ],
                        ),
                      )))),
              Consumer<HomepageProvider>(
                  builder: ((_context, homepage, _child) => Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                                leading: Icon(
                                  Icons.run_circle_outlined,
                                  color: Colors.purpleAccent,
                                  size: 30,
                                ),
                                title: Text(
                                    'Last physical activity: ${homepage.activityData?.name}')),
                            Text("Duration: ~${durationToHuman(homepage)} min"),
                            Text(
                                "Calories burnt: ${homepage.activityData?.calories}")
                          ],
                        ),
                      )))),
              Consumer<HomepageProvider>(
                  builder: ((_context, homepage, _child) => Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListTile(
                                leading: Icon(
                                  Icons.bedtime_rounded,
                                  size: 30,
                                  color: Colors.blue.shade800,
                                ),
                                title: homepage.asleepDate != null
                                    ? Text(
                                        'You fell asleep at: ${homepage.asleepDate?.hour}:${homepage.asleepDate?.minute}')
                                    : null),
                          ],
                        ),
                      ))))
            ],
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Welcome, this application will help you monitor your health on a daily basis thanks to the information acquired by your Fitbit. So, always remember to wear your smartwatch to take full advantage of this application!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.lime,
              ),
              title: const Text('LOGOUT'),
              onTap: () => performLogout(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToResultsPage(context),
        child: const Icon(Icons.auto_graph),
      ),
    );
  }

  int durationToHuman(HomepageProvider homepage) {
    var duration = homepage.activityData?.duration;
    duration = duration ?? 0;

    return (duration / 36000).floor();
  } //build

  void navigateToResultsPage(BuildContext context) {
    Navigator.of(context).pushNamed(ResultsPage.route);
  }

  void performLogout(BuildContext context) {
    UserStorage.clear();
    //Pop the drawer first
    Navigator.pop(context);
    //Then pop the HomePage
    Navigator.of(context).pushReplacementNamed(SplashScreen.route);
  } //performLogout

} //HomePage
