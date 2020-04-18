import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchFeeders() async {
  Map<String, String> requestHeaders = {
    'Authorization': 'Token faaecf120a8858e156b7c602fbf45d92a1e95909'
  };
  final response =
      await http.get('https://hungry-falconry.ew.r.appspot.com/feeders/', headers: requestHeaders);
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
