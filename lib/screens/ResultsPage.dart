import 'package:app_project/providers/results_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../database.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  static const route = '/results_page/';
  static const routename = 'Analysis';

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final List<bool> isExpandedList = [true, true];

  Future<void> fetchHeartDataFromDB(BuildContext context) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final results = Provider.of<ResultsProvider>(context, listen: false);

    final fitbitHeartDao = database.fitbitHeartDao;
    final heartList = await fitbitHeartDao.all();
    results.setHeartDataList(heartList);
  }

  Future<void> fetchActivityDataFromDB(BuildContext context) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();

    final results = Provider.of<ResultsProvider>(context, listen: false);

    final fitbitActivityDao = database.fitbitActivityDao;
    final allActivity = await fitbitActivityDao.all();
    results.setActivityDataList(allActivity);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((_) =>
        {fetchHeartDataFromDB(context), fetchActivityDataFromDB(context)});

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(ResultsPage.routename),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<ResultsProvider>(
                  builder: ((_context, results, _child) => ExpansionPanelList(
                          expansionCallback: (panelIndex, isExpanded) =>
                              setState(() {
                                isExpandedList[panelIndex] = !isExpanded;
                              }),
                          children: [
                            ExpansionPanel(
                              isExpanded: isExpandedList[0],
                              headerBuilder: ((context, isExpanded) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(children: [
                                    const Text(
                                      'Cardiac data analysis',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        'Last update: ${updatedAtDate(results.lastHeartDataDateOfMonitoring)}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600))
                                  ]))),
                              body: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Average heartbeat: ${results.averageHeartRate}'),
                                          Icon(Icons.circle,
                                              color:
                                                  averageHeartRateColorIndication(
                                                      results))
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            ExpansionPanel(
                              isExpanded: isExpandedList[1],
                              headerBuilder: ((context, isExpanded) => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(children: [
                                    const Text(
                                      'Activity data analysis',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        'Last update: ${updatedAtDate(results.lastActivityDataDateOfMonitoring)}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600))
                                  ]))),
                              body: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Average distance: ${results.averageActivityDistance}m'),
                                          Icon(Icons.circle,
                                              color:
                                                  averageActivityDistanceColorIndication(
                                                      results))
                                        ],
                                      ),
                                      const Divider(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Average caloric consumption: ${results.averageActivityCalories}KJ'),
                                          Icon(Icons.circle,
                                              color:
                                                  averageActivityCaloriesColorIndication(
                                                      results))
                                        ],
                                      ),
                                      const Divider(
                                        height: 12,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Average duration: ${formatDuration(results.averageActivityDuration)}'),
                                          Icon(Icons.circle,
                                              color:
                                                  averageActivityDurationColorIndication(
                                                      results))
                                        ],
                                      )
                                    ],
                                  )),
                            )
                          ]))),
            )
          ],
        ));
  }

  String updatedAtDate(int? dateInMillis) {
    if (dateInMillis == null) return '';

    final datetime = DateTime.fromMillisecondsSinceEpoch(dateInMillis);
    return '${datetime.day}/${datetime.month}/${datetime.year}';
  }

  Color averageHeartRateColorIndication(ResultsProvider results) {
    if (results.averageHeartRate < 50) {
      return Colors.green.shade200;
    } else if (results.averageHeartRate < 85) {
      return Colors.green;
    } else if (results.averageHeartRate < 100) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  Color averageActivityDistanceColorIndication(ResultsProvider results) {
    if (results.averageActivityDistance < 500) {
      // 0.5 km
      return Colors.red;
    } else if (results.averageActivityDistance < 1500) {
      // 1.5 km
      return Colors.amber;
    } else if (results.averageActivityDistance < 4000) {
      // 3.5 km
      return Colors.green;
    } else {
      return Colors.green.shade800;
    }
  }

  Color averageActivityCaloriesColorIndication(ResultsProvider results) {
    if (results.averageActivityCalories < 80) {
      return Colors.red;
    } else if (results.averageActivityCalories < 200) {
      return Colors.amber;
    } else if (results.averageActivityCalories < 300) {
      return Colors.green;
    } else {
      return Colors.green.shade800;
    }
  }

  Color averageActivityDurationColorIndication(ResultsProvider results) {
    double averageDurationInSeconds = results.averageActivityDuration / 1000;
    if (averageDurationInSeconds < (60 * 5)) {
      // 5 min
      return Colors.red;
    } else if (averageDurationInSeconds < (60 * 15)) {
      // 15 min
      return Colors.amber;
    } else if (averageDurationInSeconds < (60 * 30)) {
      // 30 min
      return Colors.green;
    } else {
      return Colors.green.shade800;
    }
  }

  String formatDuration(duration) {
    final durationObj = Duration(milliseconds: duration);
    return '${durationObj.inMinutes} min';
  }
} // _ResultsPageState
