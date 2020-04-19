import 'dart:async';
import 'package:flutter/material.dart';
import 'package:using_listview/api_requests/schedule.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';
import 'package:using_listview/schedulelist/modal/schedule.dart';
import 'package:using_listview/schedulelist/schedule_list_item.dart';
import 'package:intl/intl.dart';

class ScheduleStateful extends StatefulWidget {
  final FeederModel feederModel;
  ScheduleStateful({@required this.feederModel});
  @override
  _ScheduleState createState() => _ScheduleState(feederModel: this.feederModel);
}

class _ScheduleState extends State<ScheduleStateful> {
  FeederModel feederModel;
  final DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mmZ');
  _ScheduleState({@required this.feederModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feederModel.nameByUser + ' Schedules'),
      ),
      body: ScheduleList(feederModel: feederModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedDate = await _selectDateTime(context);
          if (selectedDate == null) return;

          final selectedTime = await _selectTime(context);
          if (selectedTime == null) return;
          DateTime timestamp = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
          await createSchedule(timestamp.toString(), feederModel.id, false);
          _refreshSchedules(); // Date and Time have value
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _refreshSchedules() {
    setState(() {
      feederModel = this.feederModel;
    });
  }

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light(),
            child: child,
          );
        },
      );
  Future<TimeOfDay> _selectTime(BuildContext context) {
    final now = DateTime.now();

    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
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
              return Text("No data was loaded from feeders");
          } //end switch
        },
      ),
    );
  }
}
