import 'package:flutter/material.dart';
import 'package:using_listview/api_requests/schedule.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';
import 'package:using_listview/schedulelist/modal/schedule.dart';
import 'package:using_listview/schedulelist/schedule_list_item.dart';

class SchedulesScaffold extends StatelessWidget {
  final FeederModel feederModel;

  SchedulesScaffold({@required this.feederModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: ScheduleList(feederModel: this.feederModel),
    );
  }
}

class ScheduleList extends StatelessWidget {
  final FeederModel feederModel;

  ScheduleList({@required this.feederModel});

  @override
  Widget build(BuildContext ctxt) {
    return Container(
      child: FutureBuilder(
        future: fetchSchedulesByFeeder(feederModel.id),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("there is no connection");

            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: new CircularProgressIndicator());

            case ConnectionState.done:
              if (snapshot.data != null) {
                List<ScheduleModel> schedules =
                    new List(snapshot.data["results"].length);
                for (var i = 0; i < snapshot.data["results"].length; i++) {
                  schedules[i] =
                      ScheduleModel.fromJson(snapshot.data["results"][i]);
                }

                return ListView.builder(
                    itemExtent: 90,
                    itemCount: schedules
                        .length, // getting map length you can use keyList.length too
                    itemBuilder: (BuildContext context, int index) {
                      return ScheduleListItem(schedules[index]);
                    });
              }
              // here your snapshot data is null so SharedPreferences has no data...
              return Text("No data was loaded from SharedPreferences");
          } //end switch
        },
      ),
    );
  }
}
