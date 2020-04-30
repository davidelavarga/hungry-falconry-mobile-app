import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'feederlist/feeder_list.dart';
import 'config/app_settings.config.dart';
import 'login/login.dart';

void main() {
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Yours Feerders"),
      ),
      body: MyHomePage(),
    ),
  ));
}
