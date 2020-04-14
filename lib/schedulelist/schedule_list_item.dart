import 'package:flutter/material.dart';
import 'package:using_listview/schedulelist/modal/schedule.dart';

class ScheduleListItem extends StatelessWidget {
  final ScheduleModel _scheduleModal;

  ScheduleListItem(this._scheduleModal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.brown.shade800,
        child: Text(""),
      ),
      title: Text(_scheduleModal.timestamp.toUpperCase()),
      trailing: Icon(
        _scheduleModal.done ? Icons.done : Icons.access_time,
        color: _scheduleModal.done ? Colors.green : Colors.black26,
      ),
    );
  }
}
