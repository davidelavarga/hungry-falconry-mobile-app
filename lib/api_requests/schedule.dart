import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

String host = GlobalConfiguration().getString("Host");

Future<Map<String, dynamic>> fetchSchedulesByFeeder(
    int hubId, int feeder) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "Token");
  Map<String, String> requestHeaders = {'Authorization': token};
  String url = host + '/hubs/$hubId/feeders/$feeder/schedules/';
  final response = await http.get(url, headers: requestHeaders);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load schedules');
  }
}

Future<http.Response> createSchedule(
    String timestamp, int hubId, int feeder, bool done) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "Token");
  Map<String, dynamic> postSchedule = {
    'timestamp': timestamp,
    'done': done,
    'feeder': feeder
  };
  return http.post(
    host + '/hubs/$hubId/feeders/$feeder/schedules/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
    body: jsonEncode(postSchedule),
  );
}

Future<http.Response> deleteSchedule(
    int hubId, int feeder, int schedule) async {
  final storage = FlutterSecureStorage();
  String token = await storage.read(key: "Token");
  String url = host + '/hubs/$hubId/feeders/$feeder/schedules/$schedule/';
  final response = await http.delete(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': token
  });
  if (response.statusCode == 200) {
    return response;
  } else if (response.statusCode == 204) {
    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete schedule $schedule');
  }
}
