import 'package:flutter/material.dart';

import 'feederlist/feeder_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Yours Feerders"),
      ),
      body: FeederList(),
    ),
  ));
}

