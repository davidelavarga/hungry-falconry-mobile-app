import 'package:flutter/material.dart';
import 'package:using_listview/contactlist/contact_list.dart';
import 'package:using_listview/contactlist/modal/feeder.dart';

class ContactPage extends StatelessWidget {
  _buildContactList() {
    return <FeederModel>[
      const FeederModel(
          nameByUser: 'Romain Hoogmoed', currentPortions: 1, maxPortions: 2),
      const FeederModel(
          nameByUser: 'Emilie Olsen', currentPortions: 1, maxPortions: 2),
      const FeederModel(
          nameByUser: 'Nishant Srivastava', currentPortions: 0, maxPortions: 1),
      const FeederModel(
          nameByUser: 'Romain Hoogmoed', currentPortions: 1, maxPortions: 1),
      const FeederModel(
          nameByUser: 'Emilie Olsen', currentPortions: 1, maxPortions: 2),
      const FeederModel(
          nameByUser: 'Nishant Srivastava', currentPortions: 0, maxPortions: 1),
      const FeederModel(
          nameByUser: 'Romain Hoogmoed', currentPortions: 1, maxPortions: 1),
      const FeederModel(
          nameByUser: 'Emilie Olsen', currentPortions: 1, maxPortions: 2),
      const FeederModel(
          nameByUser: 'Nishant Srivastava', currentPortions: 0, maxPortions: 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: null);
  }
}
