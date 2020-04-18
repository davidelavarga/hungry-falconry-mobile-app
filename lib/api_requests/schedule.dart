import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchSchedulesByFeeder(int feeder) async {
  Map<String, String> requestHeaders = {
    'Authorization': 'Token faaecf120a8858e156b7c602fbf45d92a1e95909'
  };
  String url = 'https://hungry-falconry.ew.r.appspot.com/feeders/' +
      feeder.toString() +
      '/schedules/';
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
    'https://hungry-falconry.ew.r.appspot.com/feeders/' +
        feeder.toString() +
        '/schedules/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token faaecf120a8858e156b7c602fbf45d92a1e95909'
    },
    body: jsonEncode(postSchedule),
  );
}
