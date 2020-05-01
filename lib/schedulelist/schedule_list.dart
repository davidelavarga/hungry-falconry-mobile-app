import 'dart:async';
import 'package:flutter/material.dart';
import 'package:using_listview/api_requests/schedule.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';
import 'package:using_listview/schedulelist/modal/schedule.dart';

int scheduleLength = 0;

class ScheduleStateful extends StatefulWidget {
  final FeederModel feederModel;
  ScheduleStateful({@required this.feederModel});
  @override
  _ScheduleState createState() => _ScheduleState(feederModel: this.feederModel);
}

class _ScheduleState extends State<ScheduleStateful> {
  FeederModel feederModel;
  _ScheduleState({@required this.feederModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(feederModel.nameByUser + ' Schedules'),
      ),
      body: Container(
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
                scheduleLength = 0;
                if (snapshot.data != null) {
                  List<ScheduleModel> schedules =
                      new List(snapshot.data["results"].length);
                  for (var i = 0; i < snapshot.data["results"].length; i++) {
                    schedules[i] =
                        ScheduleModel.fromJson(snapshot.data["results"][i]);

                    if (!schedules[i].done) scheduleLength++;
                  }

                  return ListView.builder(
                      itemExtent: 90,
                      itemCount: schedules
                          .length, // getting map length you can use keyList.length too
                      itemBuilder: (BuildContext context, int index) {
                        ScheduleModel currentScheduleItem = schedules[index];
                        var parsedDate = DateTime.parse(
                            currentScheduleItem.timestamp.toUpperCase());
                        String day = parsedDate.day.toString();
                        if (parsedDate.day < 10) {
                          day = "0" + day;
                        }
                        String month = parsedDate.month.toString();
                        if (parsedDate.month < 10) {
                          month = "0" + month;
                        }
                        String hour = parsedDate.hour.toString();
                        if (parsedDate.hour < 10) {
                          hour = "0" + hour;
                        }
                        String min = parsedDate.minute.toString();
                        if (parsedDate.minute < 10) {
                          min = "0" + min;
                        }

                        return ListTile(
                          title: RichText(
                              text: TextSpan(
                                  // set the default style for the children TextSpans
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(fontSize: 25),
                                  children: [
                                TextSpan(
                                    text: day + "/" + month + " ",
                                    style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                  text: hour + ":" + min,
                                ),
                              ])),
                          trailing: Icon(
                            currentScheduleItem.done
                                ? Icons.done
                                : Icons.access_time,
                            color: currentScheduleItem.done
                                ? Colors.green
                                : Colors.black26,
                          ),
                          onLongPress: () => {
                            _alertDeleteSchedule(
                                context, feederModel.id, currentScheduleItem.id)
                          },
                        );
                      });
                }
                return Text("No data was loaded from schedules");
            } //end switch
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (scheduleLength >= feederModel.maxPortions) {
            await _alertNoMoreSchedules();
            return;
          }
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

  void _alertNoMoreSchedules() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error", style: TextStyle(color: Colors.red)),
          content: new Text("Cannot add more schedules"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _alertDeleteSchedule(BuildContext context, int feeder, int schedule) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete", style: TextStyle(color: Colors.black)),
          content: new Text("Are you sure?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Delete"),
              textColor: Colors.red,
              onPressed: () async {
                await deleteSchedule(feeder, schedule);
                _refreshSchedules();
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
