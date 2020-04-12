import 'package:flutter/material.dart';
import 'package:using_listview/contactlist/modal/feeder.dart';

class FeederListItem extends StatelessWidget {
  final FeederModel _feederModal;

  FeederListItem(this._feederModal);

  @override
  Widget build(BuildContext context) {
    String portionsStatus = _feederModal.currentPortions.toString() +
        "/" +
        _feederModal.maxPortions.toString();
    return ListTile(
      leading: CircleAvatar(child: Text(_feederModal.nameByUser[0])),
      title: Text(_feederModal.nameByUser),
      subtitle: Text(portionsStatus),
      trailing: Icon(
        Icons.access_time,
        color: Colors.black26,
      ),
    );
  }
}
