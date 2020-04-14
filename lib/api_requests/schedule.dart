import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchSchedulesByFeeder(int feeder) async {
  Map<String, String> requestHeaders = {
    'Authorization': 'Token 4ad122c759d37ddfe0acb8cae11652c0f83987e2'
  };
  String url = 'http://10.0.2.2:8000/feeders/' + feeder.toString() + '/schedules/';
  final response =
  await http.get(url, headers: requestHeaders);
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