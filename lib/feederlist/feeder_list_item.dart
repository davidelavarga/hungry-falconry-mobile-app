import 'package:flutter/material.dart';
import 'package:using_listview/feederlist/modal/feeder.dart';
import 'package:using_listview/schedulelist/schedule_list.dart';

class FeederListItem extends StatelessWidget {
  final FeederModel _feederModal;

  FeederListItem(this._feederModal);

  @override
  Widget build(BuildContext context) {
    String portionsStatus =
        "Max. portions: " + _feederModal.maxPortions.toString();
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: Text(_feederModal.nameByUser[0])),
        title: Text(
          _feederModal.nameByUser,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(portionsStatus),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleStateful(feederModel: _feederModal),
            ),
          );
        });
  }
}
