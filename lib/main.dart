import 'package:flutter/material.dart';
import 'package:using_listview/contact_page.dart';

import 'contactlist/contact_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Using Listview"),
      ),
      body: FeederList(),
    ),
  ));
}

