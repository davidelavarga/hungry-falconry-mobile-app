import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'config/app_settings.config.dart';
import 'login/login.dart';

void main() {
//  Add FF at the beginning
//  123f03
//  355E3B
//  3a972f
//  0a745d
//  0f3d01
//  065014
//  0a520b
  const PrimaryColor = const Color(0xFF355E3B);
  GlobalConfiguration().loadFromMap(appSettings);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text(
          "Hungry Falconry",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: PrimaryColor,
      ),
      body: LoginScreen(),
    ),
  ));
}
