import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

String host = GlobalConfiguration().getString("Host");
String token = GlobalConfiguration().getString("Token");

Future<Map<String, dynamic>> fetchSchedulesByFeeder(int feeder) async {
  Map<String, String> requestHeaders = {'Authorization': token};
  String url = host + '/feeders/' + feeder.toString() + '/schedules/';
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

Future<http.Response> createSchedule(String timestamp, int feeder, bool done) {
  Map<String, dynamic> postSchedule = {
    'timestamp': timestamp,
    'done': done,
    'feeder': feeder
  };
  return http.post(
    host + '/feeders/' + feeder.toString() + '/schedules/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
    body: jsonEncode(postSchedule),
  );
}

Future<http.Response> deleteSchedule(int feeder, int schedule) {
  String url = host +
      '/feeders/' +
      feeder.toString() +
      '/schedules/' +
      schedule.toString() + '/';
  return http.delete(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': token
  });
}
