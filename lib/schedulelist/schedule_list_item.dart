import 'package:flutter/material.dart';
import 'package:using_listview/api_requests/schedule.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';
import 'package:using_listview/schedulelist/modal/schedule.dart';

class ScheduleListItem extends StatelessWidget {
  final ScheduleModel _scheduleModel;
  final FeederModel _feederModel;

  ScheduleListItem(this._scheduleModel, this._feederModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.brown.shade800,
        child: Text(""),
      ),
      title: Text(_scheduleModel.timestamp.toUpperCase()),
      trailing: Icon(
        _scheduleModel.done ? Icons.done : Icons.access_time,
        color: _scheduleModel.done ? Colors.green : Colors.black26,
      ),
      onLongPress: () => {
        _alertDeleteSchedule(context, _feederModel.id, _scheduleModel.id)
      },
    );
  }

  bool _alertDeleteSchedule(BuildContext context, int feeder, int schedule) {
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
              onPressed: () {
                deleteSchedule(feeder, schedule);
                Navigator.of(context).pop();
                return true;
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
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

}
