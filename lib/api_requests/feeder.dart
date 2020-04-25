import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

String host = GlobalConfiguration().getString("Host");
String token = GlobalConfiguration().getString("Token");

Future<Map<String, dynamic>> fetchFeeders() async {
  Map<String, String> requestHeaders = {'Authorization': token};
  final response = await http.get(host + '/feeders/', headers: requestHeaders);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feeders');
  }
}
